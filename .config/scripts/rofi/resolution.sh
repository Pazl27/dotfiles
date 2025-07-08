#!/usr/bin/env bash

MONITOR1="eDP-1"
MONITOR2="HDMI-A-1"

MODE_1080="1920x1080"

MENU=$(printf "1080p\nPreferred\n----\nMirror\nExtend")

CHOICE=$(echo -e "$MENU" | rofi -dmenu -p "Choose action")

case "$CHOICE" in
  "1080p")
    hyprctl keyword monitor "$MONITOR1,$MODE_1080,auto,1"
    notify-send "Resolution" "Set $MONITOR1 to $MODE_1080"
    ;;

  "Preferred")
    # Use hyprland default preferred mode by just not specifying a mode
    # (or specify your preferred res explicitly if you want)
    hyprctl keyword monitor "$MONITOR1,preferred,auto,1"
    notify-send "Resolution" "Set $MONITOR1 to Preferred mode"
    ;;

  "Mirror")
    # Mirror HDMI to eDP with same resolution as eDP
    hyprctl keyword monitor "$MONITOR1,1920x1080,0x0,1"
    hyprctl keyword monitor "$MONITOR2,1920x1080,0x0,1,mirror,$MONITOR1"
    notify-send "Display Mode" "Switched to Mirror"
    ;;

  "Extend")
    # Extend HDMI to right of eDP with its preferred resolution
    hyprctl keyword monitor "$MONITOR1,1920x1080,0x0,1"
    hyprctl keyword monitor "$MONITOR2,preferred,1920x0,1"
    swww img ~/Pictures/wallpaper/gruvbox/anime/chainsaw-man.jpg -o "$MONITOR2" 
    notify-send "Display Mode" "Switched to Extend"
    ;;

  *)
    echo "No selection or cancelled."
    ;;
esac
