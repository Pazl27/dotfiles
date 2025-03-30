#!/usr/bin/env bash

picture_list=$(find $HOME/Pictures/wallpaper/gruvbox -type f)

chosen_picture=$(echo -e "$toggle\n$picture_list" | uniq -u | rofi -dmenu -i -selected-row 1 -p "Wallpaper: " )

if [ -z "$chosen_picture" ]; then
  exit
else
  notify-send "Setting wallpaper to $chosen_picture"

  swww img -t none --transition-duration 0 $chosen_picture
fi
