#!/bin/bash

# Directory containing installer scripts
INSTALLER_DIR="$HOME/.config/scripts/installer"

# Define menu options with icons and display names in order
declare -a menu_order=(
    " System Update"
    " Install Official Packages"
    " Install AUR Packages"
    " Remove Packages"
    " Create Web App"
    " Remove Web App"
)

declare -A options
options[" System Update"]="system-update.sh"
options[" Install AUR Packages"]="pkg-aur-install.sh"
options[" Install Official Packages"]="pkg-packman-install.sh"
options[" Remove Packages"]="pkg-remove.sh"
options[" Create Web App"]="webapp-install.sh"
options[" Remove Web App"]="webapp-remove.sh"

# Create the menu string for rofi in correct order
menu=""
for display_name in "${menu_order[@]}"; do
    menu="${menu}${display_name}\n"
done

# Remove trailing newline
menu=$(echo -e "$menu" | head -c -1)

# Show rofi menu
selected=$(echo -e "$menu" | rofi -dmenu -i -p ">" -theme "$HOME/.config/rofi/ai.rasi")

# Execute the corresponding script if something was selected
if [[ -n "$selected" ]]; then
    script_name="${options[$selected]}"
    if [[ -f "$INSTALLER_DIR/$script_name" ]]; then
        # Execute the script in kitty terminal
        kitty --class installer -e bash -c "cd '$INSTALLER_DIR' && ./$script_name"
    else
        # Show error notification
        notify-send "Error" "Script not found: $script_name"
    fi
fi
