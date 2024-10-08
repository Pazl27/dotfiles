#!/usr/bin/env sh

# Function to select and focus a window based on a class name
selectOne() {
    target=$(hyprctl clients -j | jq -rc '.[] | select((.class |test("'"${1}"'")))')
    if [ -n "${target}" ]; then
        target=$(echo "${target}" | jq -r '.address')
        hyprctl dispatch "focuswindow address:${target}" >/dev/null
        return 0
    fi
    return 1
}

# Function to process a list of classes and try to focus the first one found
processFirst() {
    set -f; IFS='|'
    #shellcheck disable=SC2086
    set -- ${1}
    for param in "$@"; do
        if selectOne "${param}"; then
            return 0
        fi
    done
    set +f; unset IFS
    return 1
}

# Main function that does the work, with a default check for "kitty" if no argument is passed
doWork() {
    # If no arguments are provided, use "kitty" as the default search term
    if [ -z "$1" ]; then
        set -- "kitty"
    fi

    # Try to focus the first matching window, otherwise run the command (if provided)
    if processFirst "$1"; then
        true
    elif [ -n "${2}" ]; then
        shift
        "$@" &
    else
        "${1}" &
    fi
}

# Execute the main function
doWork "$@"

