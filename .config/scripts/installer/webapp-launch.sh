#!/bin/bash

browser=$(xdg-settings get default-web-browser)

case $browser in
google-chrome* | brave-browser* | microsoft-edge* | opera* | vivaldi* | zen*) ;;
*) browser="chromium.desktop" ;;
esac

browser_exec=$(sed -n 's/^Exec=\([^ ]*\).*/\1/p' {~/.local,~/.nix-profile,/usr}/share/applications/$browser 2>/dev/null | head -1)

if [[ -z "$browser_exec" ]]; then
    # Fallback to common browsers
    for fallback in google-chrome chromium firefox; do
        if command -v "$fallback" &>/dev/null; then
            browser_exec="$fallback"
            break
        fi
    done
fi

exec "$browser_exec" --app="$1" "${@:2}" &
