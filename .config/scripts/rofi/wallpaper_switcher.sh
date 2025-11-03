#!/bin/bash

SELECTED=$(find ~/Pictures/wallpaper/gruvbox \
    -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \)  \
    | shuf |
    while read -r img; do
        echo -en "$img\0icon\x1f$img\n"
    done \
| rofi -dmenu -show-icons -theme "$HOME/.config/rofi/wallselect.rasi" -p ">")


if [ -z "$SELECTED" ]; then
    exit 0
fi
notify-send "new wallpaper: $(basename "$SELECTED")"

swww img -t grow --transition-duration 2 "$SELECTED"


