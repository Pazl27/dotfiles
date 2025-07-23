#!/bin/bash

# Define the external monitor you want to detect
EXT_MON="Samsung Electric Company Odyssey G60SD HNAX700903"

# Use hyprctl to check connected monitors
if hyprctl monitors | grep -q "$EXT_MON"; then
    # If external monitor is connected, disable laptop screen
    hyprctl dispatch dpms off eDP-1
    hyprctl keyword monitor "eDP-1, disable"
else
    # If external monitor is not connected, enable laptop screen
    hyprctl keyword monitor "eDP-1, 1920x1080, auto, 1"
fi

