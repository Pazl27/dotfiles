#!/bin/bash

selected=$(find ~ -type d -print | fzf)

if [ -n "$selected" ]; then
    session_name=$(basename "$selected")

    if tmux has-session -t "$session_name" 2>/dev/null; then
        tmux attach-session -t "$session_name"
    else
        tmux new-session -s "$session_name" -c "$selected"
    fi
else
    echo "No directory selected."
fi

