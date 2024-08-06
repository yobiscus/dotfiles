#!/bin/bash

# Update DPI before starting compositor and setting wallpaper
extmon_state=$(xrandr | grep DVI-I-1-1 | cut -d' ' -f2,3)
if [[ "$extmon_state" =~ ^connected\ [0-9] ]]; then
    # lists resolution, is connected and active
    sed -i 's/dpi:.*$/dpi: 120/g' ~/.Xresources
else
    sed -i 's/dpi:.*$/dpi: 96/g' ~/.Xresources
fi
xrdb -merge ~/.Xresources

# Wallpaper
feh --randomize --bg-fill ~/.wallpaper/*
