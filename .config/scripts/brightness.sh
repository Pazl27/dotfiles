#!/bin/bash

# Configuration
notification_timeout=1000
step=5  # Brightness step in percent

# Get current brightness percentage (as integer)
get_backlight() {
  brightnessctl -m | cut -d, -f4 | sed 's/%//'
}

# Pick appropriate icon name based on brightness level
get_icon() {
  current=$(get_backlight)
  if [ "$current" -le 20 ]; then
    icon="display-brightness-low"
  elif [ "$current" -le 40 ]; then
    icon="display-brightness-low"
  elif [ "$current" -le 60 ]; then
    icon="display-brightness-medium"
  elif [ "$current" -le 80 ]; then
    icon="display-brightness-high"
  else
    icon="display-brightness-high"
  fi
}

# Show notification with brightness level
notify_user() {
  notify-send -e \
    -h string:x-canonical-private-synchronous:brightness_notify \
    -h int:value:"$current" \
    -u low \
    -i "$icon" \
    "Screen" "Brightness: $current%"
}

# Change brightness up/down or set directly
change_backlight() {
  local current_brightness
  current_brightness=$(get_backlight)

  if [[ "$1" == +*% ]]; then
    new_brightness=$((current_brightness + step))
  elif [[ "$1" == -*% ]]; then
    new_brightness=$((current_brightness - step))
  else
    new_brightness="$1"
  fi

  # Clamp brightness between 5% and 100%
  if (( new_brightness < 5 )); then
    new_brightness=5
  elif (( new_brightness > 100 )); then
    new_brightness=100
  fi

  brightnessctl set "${new_brightness}%"
  get_icon
  current=$new_brightness
  notify_user
}

# Main dispatcher
case "$1" in
  "--get")
    get_backlight
    ;;
  "--inc")
    change_backlight "+${step}%"
    ;;
  "--dec")
    change_backlight "-${step}%"
    ;;
  *)
    echo "Usage: $0 --get | --inc | --dec"
    ;;
esac

