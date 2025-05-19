#!/bin/bash

set -e

cd "$HOME"

#
# Preflight check
#

if ! grep -q DISTRIB_ID=Ubuntu /etc/lsb-release; then
    echo "Error: Distro not supported by init script." >&2
    exit 1
fi

arch=$(uname -m)
if [[ "$arch" != "x86_64" ]]; then
    echo "Error: Arch '$arch' not supported by init script." >&2
    exit 1
fi
arch_alt=x64

#
# Settings
#

shell=zsh

apt_pkgs=(
    clang
    cmake
    curl
    git
    golang
    i3
    make
    python3
    tmux
    unzip
    zsh
)

cargo_pkgs=(
    ripgrep
    fd-find
)

snap_pkgs=(
    alacritty:"--classic"
)

go_pkgs=(
    github.com/gopasspw/gopass@latest
)

archived_pkgs=(
    "nvim=https://github.com/neovim/neovim/releases/download/v0.11.1/nvim-linux-${arch}.tar.gz"
    "node,npm,npx=https://nodejs.org/dist/v22.15.1/node-v22.15.1-linux-${arch_alt}.tar.xz"
)

fonts=(
    https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
)

#
# Install
#

function curl() {
    /usr/bin/curl --proto '=https' --tlsv1.2 -sSfL "$@"
}

mkdir -p ".local/bin"

if [[ ${#apt_pkgs[@]} -gt 0 ]]; then
    echo "Installing apt packages..."
    sudo apt update
    sudo apt dist-upgrade -y
    sudo apt install -y "${apt_pkgs[@]}"
    sudo apt autoremove --purge -y
fi

if [[ ${#snap_pkgs[@]} -gt 0 ]]; then
    echo ""
    echo "Installing snap packages..."
    for p in "${snap_pkgs[@]}"; do
        name=${p%%:*}
        opts=${p#*:}
        sudo snap install "$name" $opts
    done
fi

echo ""
echo "Installing rust..."
curl https://sh.rustup.rs | sh -s -- -y
source ".cargo/env"

if [[ ${#cargo_pkgs[@]} -gt 0 ]]; then
    echo ""
    echo "Installing cargo packages..."
    cargo install "${cargo_pkgs[@]}"
fi

if [[ ${#go_pkgs[@]} -gt 0 ]]; then
    echo ""
    echo "Installing go packages..."
    go install "${go_pkgs[@]}"
fi

split_string() {
    local -n ref=$3
    [[ -n $2 ]] && local IFS=$2
    ref+=($1)
    local IFS=$'\n'
    echo "${ref[*]}"
}

if [[ ${#archived_pkgs[@]} -gt 0 ]]; then
    echo ""
    echo "Installing archived packages..."
    for p in "${archived_pkgs[@]}"; do
        installed=1
        names=()
        split_string "${p%%=*}" , names
        for name in "${names[@]}"; do
            [[ ! -x ".local/bin/$name" ]] && installed=
        done
        [[ ! $installed ]] || continue

        if [[ -z "${names[0]}" ]]; then
            echo "Error: Bad archive format '$p'."
            exit 1
        fi

        # download to .local/opt
        url=${p#*=}
        bname=${url##*/}
        destdir=.local/opt/${names[0]}
        rm -rf "$destdir"
        mkdir -p "$destdir"
        curl -o "$destdir/$bname" "${url}"
        # extract
        tar -C "$destdir" -xf "$destdir/$bname"
        # create symlink in $PATH
        for name in "${names[@]}"; do
            ln -sfr $(fd "^${name}$" "$destdir" --type executable --max-results 1) .local/bin/
        done
    done
fi

if [[ ${#fonts[@]} -gt 0 ]]; then
    echo ""
    echo "Installing fonts..."
    mkdir -p .fonts
    for url in "${fonts[@]}"; do
        fqname=${url##*/}
        name=${fqname%.*}
        [[ ! -d ".fonts/$name" ]] || continue
        set -x
        curl -o ".fonts/$fqname" "$url"
        set +x
        [[ "$fqname" == *.zip ]] || { echo "Unsupported font extension for $fqname" >&2; continue; }
        unzip ".fonts/$fqname" -d ".fonts/$name"
        fc-cache -vr
    done
fi

if [[ ! -e .local/bin/starship ]]; then
    echo ""
    echo "Installing starship prompt..."
    curl -sS https://starship.rs/install.sh | { sh -s -- -y -b .local/bin >/dev/null; }
fi

#
# Configure
#

function dotfiles {
    git --git-dir=$.dotfiles --work-tree=. "$@"
}

if [[ ! -d .dotfiles ]]; then
    echo ""
    echo "Cloning dotfiles..."
    git clone --bare https://github.com/yobiscus/dotfiles.git -b v2 .dotfiles
    dotfiles config --local status.showUntrackedFiles no
    dotfiles checkout
fi

if [[ -z $(git config --global user.name) ]]; then
    echo ""
    echo "Configuring git..."
    read -p "Full name: " name
    git config --global user.name "$name"
    read -p "Email: " email
    git config --global user.email "$email"
fi

if [[ -z $(gpg --list-secret-keys) ]]; then
    echo ""
    echo "Creating gpg keys..."
    gpg --batch --gen-key <<EOF
Key-Type: 1
Key-Length: 2048
Subkey-Type: 1
Subkey-Length: 2048
Name-Real: $(git config --global user.name)
Name-Email: $(git config --global user.email)
Expire-Date: 0
EOF
    gpg --export --armour "$(git config --global user.email)"
fi

if [[ ! -e .ssh/id_ed25519.pub ]]; then
    echo ""
    echo "Creating ssh keys..."
    ssh-keygen -t ed25519 -C "$(git config --global user.email)" -f .ssh/id_ed25519
    cat .ssh/id_ed25519.pub
fi

echo ""
echo "Done!"
