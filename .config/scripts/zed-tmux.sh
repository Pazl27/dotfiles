#!/bin/bash

# ─── CONFIG ─────────────────────────────────────────────────────────────
SESSION_NAME=${PWD##*/}

# ─── SWITCH TO DROP WORKSPACE ───────────────────────────────────────────
hyprctl dispatch togglespecialworkspace drop

# ─── LAUNCH (OR ATTACH) IN KITTY ────────────────────────────────────────
if ! pgrep -f "kitty.*tmux" >/dev/null; then
  kitty \
    --class "dropterm" \
    tmux new-session -A -s "$SESSION_NAME" &
  KITTY_PID=$!          
  sleep 0.1            
  hyprctl dispatch focuswindow "class:dropterm"
  wait $KITTY_PID     
else
  hyprctl dispatch focuswindow "class:dropterm"
fi
