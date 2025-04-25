#!/bin/bash

hyprctl dispatch togglespecialworkspace drop

# Nur starten, wenn es nicht läuft
if ! pgrep -f "kitty.*yazi" > /dev/null; then
  kitty --class dropterm -e yazi &
  sleep 0.5
  hyprctl dispatch focuswindow "class:dropterm"
fi
