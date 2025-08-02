#!/bin/bash

# Give the terminal a short moment to appear before setting content
sleep 0.1

echo "AI is thinking...."

# Wait until the file appears
while [ ! -f "/tmp/askai-resp.md" ]; do
  sleep 0.2
done

clear
glow -w 100 -s "$HOME/.config/glow/gruvbox-dark.json" -t /tmp/askai-resp.md

exit
