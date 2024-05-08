#!/bin/bash

packages=(
  i3
  i3blocks
  fish
  keychain
)

sudo apt-get update
sudo apt-get install "${packages[@]}"
