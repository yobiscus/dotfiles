#!/bin/bash

packages=(
  i3
  i3blocks
  j4-dmenu-desktop
  fish
  keychain
)

sudo apt-get update
sudo apt-get install "${packages[@]}"
