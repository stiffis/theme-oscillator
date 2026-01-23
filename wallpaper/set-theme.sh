#!/bin/bash

# Wallpaper switcher script
# Usage: ./set-theme.sh [0|1]
# 0 = Night (Gruvbox)
# 1 = Day (Kanagawa)

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"

# Validate argument
if [ -z "$1" ]; then
    echo "Error: You must specify an argument"
    echo "Usage: $0 [0|1]"
    echo "  0 = Night (Gruvbox)"
    echo "  1 = Day (Kanagawa)"
    exit 1
fi

# Determine wallpaper from argument
if [ "$1" = "1" ]; then
    WALLPAPER="csl-chan-kanagawa.png"
    THEME_NAME="Kanagawa"
    THEME_STATE="light"
    echo "Changing wallpaper to: Kanagawa"
elif [ "$1" = "0" ]; then
    WALLPAPER="csl-chan-gruvbox-dark.png"
    THEME_NAME="Gruvbox"
    THEME_STATE="dark"
    echo "Changing wallpaper to: Gruvbox"
else
    echo "Error: Invalid argument"
    echo "Use 0 (night) or 1 (day)"
    exit 1
fi

WALLPAPER_PATH="$WALLPAPER_DIR/$WALLPAPER"

# Verify wallpaper exists
if [ ! -f "$WALLPAPER_PATH" ]; then
    echo "Error: Wallpaper not found: $WALLPAPER_PATH"
    exit 1
fi

echo ""
echo "→ Updating hyprpaper.conf..."

# Update preload in hyprpaper.conf
sed -i "s|^preload = .*|preload = $WALLPAPER_PATH|" "$HYPRPAPER_CONF"

# Update wallpaper for each monitor
sed -i "s|^wallpaper = eDP-1,.*|wallpaper = eDP-1,$WALLPAPER_PATH|" "$HYPRPAPER_CONF"
sed -i "s|^wallpaper = HDMI-A-1,.*|wallpaper = HDMI-A-1,$WALLPAPER_PATH|" "$HYPRPAPER_CONF"

echo "  ✓ hyprpaper.conf updated"

# Save state for hyprlock
echo "$THEME_STATE" > "$HOME/.config/theme-oscillator/wallpaper/.current-theme"

# ============================================
# APPLY WALLPAPER WITH SWWW
# ============================================
echo ""
echo "→ Applying wallpaper with swww..."

if pgrep -x "swww-daemon" > /dev/null; then
    swww img "$WALLPAPER_PATH" --outputs eDP-1,HDMI-A-1
    echo "  ✓ Wallpaper applied: $WALLPAPER"
else
    echo "  ⚠ swww-daemon is not running, change will apply on restart"
fi

echo ""
echo "✓ Wallpaper configured: $THEME_NAME ($WALLPAPER)"
