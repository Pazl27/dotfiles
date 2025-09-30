#!/bin/sh
set -eu

# Set your terminal:
terminal="st"

# Search for projects in ~/dev/*/*
configs="$(find "$HOME/dev" -mindepth 2 -maxdepth 2 -type d -printf '%P\n' 2>/dev/null)"
[ -n "$configs" ] || exit 0

# Pick project
chosen="$(printf '%s\n' "$configs" | rofi -dmenu -theme "$HOME/.config/rofi/ai.rasi" -p 'Projects:')"
[ -n "$chosen" ] || exit 0
dir="$HOME/dev/$chosen"

# Kill existing terminal (if you only want one instance)
# pkill -x "$terminal" 2>/dev/null || true
# sleep 0.1

zeditor "$dir"
sleep 0.1

# Launch terminal with tmux session (attach if exists, else create new)
exec kitty tmux new-session -As "$(basename "$chosen")" -c "$dir"
