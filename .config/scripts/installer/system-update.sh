#!/bin/bash

echo -e "\e[32mChecking for system updates...\e[0m\n"

# Check for official repo updates
echo "Checking official repositories..."
pacman_updates=$(checkupdates 2>/dev/null)

# Check for AUR updates
echo "Checking AUR packages..."
aur_updates=$(yay -Qua 2>/dev/null)

# Combine all updates
all_updates=""
update_count=0

if [[ -n "$pacman_updates" ]]; then
    all_updates="$pacman_updates"
    update_count=$((update_count + $(echo "$pacman_updates" | wc -l)))
fi

if [[ -n "$aur_updates" ]]; then
    if [[ -n "$all_updates" ]]; then
        all_updates="$all_updates\n$aur_updates"
    else
        all_updates="$aur_updates"
    fi
    update_count=$((update_count + $(echo "$aur_updates" | wc -l)))
fi

if [[ $update_count -eq 0 ]]; then
    echo -e "\e[32m✓ System is up to date!\e[0m"
    ./show-done.sh
    exit 0
fi

fzf_args=(
    --preview 'if pacman -Si {1} &>/dev/null; then pacman -Si {1}; else yay -Siia {1}; fi'
    --preview-label="Package information - Press ENTER to update all packages"
    --preview-label-pos='bottom'
    --preview-window 'right:60%:wrap'
    --bind 'alt-p:toggle-preview'
    --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up'
    --bind 'alt-k:preview-up,alt-j:preview-down'
    --header="$update_count package(s) available for update"
    --color 'pointer:blue,marker:blue'
    --no-multi
)

echo -e "$all_updates" | fzf "${fzf_args[@]}" > /dev/null

# Check if user pressed enter (fzf returns 0 on selection)
if [[ $? -eq 0 ]]; then
    echo -e "\n\e[33mStarting system update...\e[0m\n"

    # Update system using yay (handles both official and AUR packages)
    yay -Syu --noconfirm

    # Update locate database
    sudo updatedb

    echo -e "\n\e[32m✓ System update completed!\e[0m"
    ./show-done.sh
else
    echo -e "\n\e[31mUpdate cancelled.\e[0m"
fi
