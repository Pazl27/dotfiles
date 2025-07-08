#!/bin/bash

# System icon names
ICON_MUTE="audio-volume-muted"
ICON_LOW="audio-volume-low"
ICON_MEDIUM="audio-volume-medium"
ICON_HIGH="audio-volume-high"
ICON_MIC_MUTE="microphone-sensitivity-muted"
ICON_MIC="microphone-sensitivity-high"

###################
# Helper functions
###################

get_volume_number() {
  pamixer --get-volume
}

is_muted() {
  pamixer --get-mute
}

get_volume_icon() {
  local vol
  vol=$(get_volume_number)
  if [[ $(is_muted) == "true" || "$vol" -eq 0 ]]; then
    echo "$ICON_MUTE"
  elif (( vol <= 30 )); then
    echo "$ICON_LOW"
  elif (( vol <= 60 )); then
    echo "$ICON_MEDIUM"
  else
    echo "$ICON_HIGH"
  fi
}

###################
# Notify functions
###################

notify_user() {
  local vol muted
  vol=$(get_volume_number)
  muted=$(is_muted)

  if [[ "$muted" == "true" ]]; then
    # Show Muted but also the % level
    notify-send -e -h int:value:"$vol" \
      -h string:x-canonical-private-synchronous:volume_notif \
      -u low \
      -i "$ICON_MUTE" \
      "Volume" "Muted (${vol}%)"
  else
    notify-send -e -h int:value:"$vol" \
      -h string:x-canonical-private-synchronous:volume_notif \
      -u low \
      -i "$(get_volume_icon)" \
      "Volume" "${vol}%"
  fi
}

###################
# Volume controls
###################

inc_volume() {
  pamixer -i 5 --allow-boost --set-limit 150
  notify_user
}

dec_volume() {
  pamixer -d 5
  notify_user
}

toggle_mute() {
  if [[ $(is_muted) == "true" ]]; then
    local vol
    vol=$(get_volume_number)
    pamixer -u
    notify-send -e -u low -i "$(get_volume_icon)" "Volume" "Unmuted (${vol}%)"
  else
    pamixer -m
    local vol
    vol=$(get_volume_number)
    notify-send -e -u low -i "$ICON_MUTE" "Volume" "Muted (${vol}%)"
  fi
}

###################
# Microphone controls
###################

get_mic_volume_number() {
  pamixer --default-source --get-volume
}

is_mic_muted() {
  pamixer --default-source --get-mute
}

get_mic_icon() {
  local vol
  vol=$(get_mic_volume_number)
  if [[ $(is_mic_muted) == "true" || "$vol" -eq 0 ]]; then
    echo "$ICON_MIC_MUTE"
  else
    echo "$ICON_MIC"
  fi
}

notify_mic_user() {
  local vol muted
  vol=$(get_mic_volume_number)
  muted=$(is_mic_muted)

  if [[ "$muted" == "true" ]]; then
    notify-send -e -h int:value:"$vol" \
      -h string:x-canonical-private-synchronous:volume_notif \
      -u low \
      -i "$ICON_MIC_MUTE" \
      "Mic" "Muted (${vol}%)"
  else
    notify-send -e -h int:value:"$vol" \
      -h string:x-canonical-private-synchronous:volume_notif \
      -u low \
      -i "$ICON_MIC" \
      "Mic Level" "${vol}%"
  fi
}

inc_mic_volume() {
  pamixer --default-source -i 5
  notify_mic_user
}

dec_mic_volume() {
  pamixer --default-source -d 5
  notify_mic_user
}

toggle_mic() {
  if [[ $(is_mic_muted) == "true" ]]; then
    pamixer --default-source -u
    notify-send -e -u low -i "$ICON_MIC" "Mic" "Unmuted"
  else
    pamixer --default-source -m
    local vol
    vol=$(get_mic_volume_number)
    notify-send -e -u low -i "$ICON_MIC_MUTE" "Mic" "Muted (${vol}%)"
  fi
}

###################
# CLI Dispatcher
###################

case "$1" in
  --get) get_volume_number ;;
  --inc) inc_volume ;;
  --dec) dec_volume ;;
  --toggle) toggle_mute ;;
  --toggle-mic) toggle_mic ;;
  --mic-inc) inc_mic_volume ;;
  --mic-dec) dec_mic_volume ;;
  *) notify_user ;;
esac
