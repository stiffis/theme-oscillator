#!/bin/bash

# GTK theme switcher script
# Usage: ./set-theme.sh [0|1]
# 0 = Night (Gruvbox)
# 1 = Day (Kanagawa)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Validate argument
if [ -z "$1" ]; then
    echo "Error: You must specify an argument"
    echo "Usage: $0 [0|1]"
    echo "  0 = Night (Gruvbox-Dark)"
    echo "  1 = Day (Kanagawa-Dark)"
    exit 1
fi

# Determine theme from argument
if [ "$1" = "1" ]; then
    THEME="light"  # Day = Kanagawa
    THEME_NAME="Kanagawa-Dark"
    echo "Changing to DAY theme: Kanagawa"
elif [ "$1" = "0" ]; then
    THEME="dark"   # Night = Gruvbox
    THEME_NAME="Gruvbox-Dark"
    echo "Changing to NIGHT theme: Gruvbox"
else
    echo "Error: Invalid argument"
    echo "Use 0 (night) or 1 (day)"
    exit 1
fi

# Save current theme
echo "$THEME" > "$SCRIPT_DIR/.current-theme"

# ============================================
# APPLY GTK CONFIGURATION
# ============================================
echo "→ Configuring GTK..."

# Update gsettings (dconf)
gsettings set org.gnome.desktop.interface gtk-theme "$THEME_NAME"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.desktop.interface icon-theme "Adwaita"

# Update GTK3 settings.ini file
mkdir -p ~/.config/gtk-3.0
sed -i "s/^gtk-theme-name=.*/gtk-theme-name=$THEME_NAME/" ~/.config/gtk-3.0/settings.ini

# Update environment variable in Hyprland
sed -i "s/^env = GTK_THEME,.*/env = GTK_THEME,$THEME_NAME/" ~/.config/hypr/UserConfigs/ENVariables.conf

echo "✓ GTK configured: $THEME_NAME"

# ============================================
# RELOAD HYPRLAND
# ============================================
echo "→ Reloading Hyprland..."
hyprctl reload

echo ""
echo "✓ Theme applied successfully: $THEME_NAME"
echo "✓ Hyprland reloaded"
