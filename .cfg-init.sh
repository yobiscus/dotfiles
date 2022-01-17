#!/bin/bash

set -e

function fatal() {
    echo $@ >&2
    exit 1
}

/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME submodule update --init

if command -v dnf &>/dev/null; then
    sudo dnf install -y zsh tmux python3-devel python3-pip util-linux-user
elif command -v apt-get &>/dev/null; then
    sudo apt install -y zsh tmux python3-dev python3-pip
else
    fatal "Unsupported distro"
fi

if [[ -z "$ZSH" ]]; then
  export CHSH=no
  export RUNZSH=no
  export KEEP_ZSHRC=yes
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
rm -f ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

sudo chsh -s /usr/bin/zsh $USER
