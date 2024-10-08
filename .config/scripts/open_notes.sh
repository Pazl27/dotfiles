#!/bin/bash

SESSION_NAME="notes"
TARGET_DIR="$HOME/notes_vault/personal/"

if tmux has-session -t $SESSION_NAME 2>/dev/null; then
  # If already in tmux, switch to the session instead of nesting
  if [ -n "$TMUX" ]; then
    tmux switch-client -t $SESSION_NAME
  else
    exec tmux attach-session -t $SESSION_NAME
  fi
else
  # Create a new session in the specified directory and run nvim
  if [ -n "$TMUX" ]; then
    tmux new-session -ds $SESSION_NAME -c "$TARGET_DIR" 'nvim'
    tmux switch-client -t $SESSION_NAME
  else
    exec tmux new-session -s $SESSION_NAME -c "$TARGET_DIR" 'nvim'
  fi
fi

