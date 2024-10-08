#!/bin/bash

if tmux has-session -t 0 2>/dev/null; then
  exec tmux attach-session -t 0
else
  exec tmux new-session -s 0
fi

