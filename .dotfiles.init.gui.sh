#!/bin/bash

set -e

hyprland=.local/opt/hyprland
if [[ -x .local/bin/hyprland ]]; then
    echo "Hyprland already installed!"
fi

cd "$HOME"
# rm -rf .local/opt/hyprland
mkdir -p "$hyprland"

arch=$(uname -m)

# Hyprland

v_hyprland=v0.49.0
v_wayland=1.23.1
v_wayland_protocols=1.44
v_libdisplay_info=0.2.0
v_hyprwayland_scanner=v0.4.4
v_hyprutils=v0.7.1
v_aquamarine=v0.8.0
v_hyprlang=v0.6.3
v_hyprcursor=v0.1.12
v_hyprgraphics=v0.1.3
#
# # Install deps
sudo apt install -y \
    kitty \
    meson wget build-essential ninja-build cmake-extras cmake gettext \
    gettext-base fontconfig libfontconfig-dev libffi-dev libxml2-dev \
    libdrm-dev libxkbcommon-x11-dev libxkbregistry-dev libxkbcommon-dev \
    libpixman-1-dev libudev-dev libseat-dev seatd libxcb-dri3-dev \
    libegl-dev libgles2 libegl1-mesa-dev glslang-tools libinput-bin \
    libinput-dev libxcb-composite0-dev libavutil-dev libavcodec-dev \
    libavformat-dev libxcb-ewmh2 libxcb-ewmh-dev libxcb-present-dev \
    libxcb-icccm4-dev libxcb-render-util0-dev libxcb-res0-dev \
    libxcb-xinput-dev libtomlplusplus3 libre2-dev \
    doxygen graphviz xmlto xsltproc libpugixml-dev libgbm-dev \
    libzip-dev librsvg2-dev libtomlplusplus-dev libmagic-dev \
    libspng-dev libxcb-errors-dev

# Prepare environment
PKG_CONFIG_PATH=$HOME/.local/lib/pkgconfig
PKG_CONFIG_PATH+=:$HOME/.local/lib/${arch}-linux-gnu/pkgconfig
PKG_CONFIG_PATH+=:$HOME/.local/share/pkgconfig
export PKG_CONFIG_PATH

# Install deps
[[ -d "$hyprland/wayland" ]] || (
    set -e
    git -C "$hyprland" \
        clone https://gitlab.freedesktop.org/wayland/wayland.git \
        -b "$v_wayland"
    cd "$hyprland/wayland"
    meson setup build/ --prefix="$HOME/.local"
    ninja -C build/ install
)
[[ -d "$hyprland/wayland-protocols" ]] || (
    set -e
    git -C "$hyprland" \
        clone https://gitlab.freedesktop.org/wayland/wayland-protocols.git \
        -b "$v_wayland_protocols"
    cd "$hyprland/wayland-protocols"
    meson setup build/ --prefix="$HOME/.local"
    ninja -C build/ install
)
[[ -d "$hyprland/libdisplay-info" ]] || (
    set -e
    git -C "$hyprland" \
        clone https://gitlab.freedesktop.org/emersion/libdisplay-info.git \
        -b "$v_libdisplay_info"
    cd "$hyprland/libdisplay-info"
    meson setup build/ --prefix="$HOME/.local"
    ninja -C build/ install
)
[[ -d "$hyprland/hyprwayland-scanner" ]] || (
    set -e
    git -C "$hyprland" \
        clone https://github.com/hyprwm/hyprwayland-scanner.git \
        -b "$v_hyprwayland_scanner"
    cd "$hyprland/hyprwayland-scanner"
    cmake \
        -DCMAKE_INSTALL_PREFIX:PATH="$HOME/.local" \
        -B build
    cmake --build build -j "$(nproc)"
    cmake --install build
)
[[ -d "$hyprland/hyprutils" ]] || (
    set -e
    git -C "$hyprland" \
        clone https://github.com/hyprwm/hyprutils.git \
        -b "$v_hyprutils"
    cd "$hyprland/hyprutils"
    cmake --no-warn-unused-cli \
        -DCMAKE_BUILD_TYPE:STRING=Release \
        -DCMAKE_INSTALL_PREFIX:PATH="$HOME/.local" \
        -S . -B ./build
    cmake --build ./build \
        --config Release --target all \
        -j "$(nproc 2>/dev/null || getconf NPROCESSORS_CONF)"
    sudo cmake --install build
)
[[ -d "$hyprland/aquamarine" ]] || (
    set -e
    git -C "$hyprland" \
        clone https://github.com/hyprwm/aquamarine.git \
        -b "$v_aquamarine"
    cd "$hyprland/aquamarine"
    cmake \
        --no-warn-unused-cli \
        -DCMAKE_BUILD_TYPE:STRING=Release \
        -DCMAKE_INSTALL_PREFIX:PATH="$HOME/.local" \
        -S . -B ./build
    cmake \
        --build ./build --config Release --target all \
        -j"$(nproc 2>/dev/null || getconf _NPROCESSORS_CONF)"
    sudo cmake --install build
)
[[ -d "$hyprland/hyprlang" ]] || (
    set -e
    git -C "$hyprland" \
        clone https://github.com/hyprwm/hyprlang.git \
        -b "$v_hyprlang"
    cd "$hyprland/hyprlang"
    cmake --no-warn-unused-cli \
        -DCMAKE_BUILD_TYPE:STRING=Release \
        -DCMAKE_INSTALL_PREFIX:PATH="$HOME/.local" \
        -S . -B ./build
    cmake --build ./build \
        --config Release --target hyprlang \
        -j "$(nproc 2>/dev/null || getconf _NPROCESSORS_CONF)"
    sudo cmake --install build
)
[[ -d "$hyprland/hyprcursor" ]] || (
    set -e
    git -C "$hyprland" \
        clone https://github.com/hyprwm/hyprcursor.git \
        -b "$v_hyprcursor"
    cd "$hyprland/hyprcursor"
    cmake --no-warn-unused-cli \
        -DCMAKE_BUILD_TYPE:STRING=Release \
        -DCMAKE_INSTALL_PREFIX:PATH="$HOME/.local" \
        -S . -B ./build
    cmake --build ./build \
        --config Release --target all \
        -j "$(nproc 2>/dev/null || getconf _NPROCESSORS_CONF)"
    sudo cmake --install build
)
[[ -d "$hyprland/hyprgraphics" ]] || (
    set -e
    git -C "$hyprland" \
        clone https://github.com/hyprwm/hyprgraphics.git \
        -b "$v_hyprgraphics"
    cd "$hyprland/hyprgraphics"
    cmake --no-warn-unused-cli \
        -DCMAKE_BUILD_TYPE:STRING=Release \
        -DCMAKE_INSTALL_PREFIX:PATH="$HOME/.local" \
        -S . -B ./build
    cmake --build ./build \
        --config Release --target all \
        -j "$(nproc 2>/dev/null || getconf NPROCESSORS_CONF)"
    sudo cmake --install build
)
[[ -d "$hyprland/Hyprland" ]] || (
    set -e
    git -C "$hyprland" \
        clone --recursive https://github.com/hyprwm/Hyprland.git \
        -b "$v_hyprland"
    cd "$hyprland/Hyprland"
    rm -rf build/
    make all
    sudo make install
)
