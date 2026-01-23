#!/bin/bash
# swaync theme switcher
# Usage: ./set-theme.sh <0|1>
# 0 = Night (Gruvbox)
# 1 = Day (Kanagawa)

THEME="$1"
SWAYNC_DIR="$HOME/.config/swaync"

if [ "$THEME" = "1" ]; then
    # Kanagawa (day)
    cp "$SWAYNC_DIR/style-kanagawa.css" "$SWAYNC_DIR/style.css"
    echo "✓ swaync theme set to: Kanagawa (day)"
elif [ "$THEME" = "0" ]; then
    # Gruvbox (night)
    cp "$SWAYNC_DIR/style-gruvbox.css" "$SWAYNC_DIR/style.css"
    echo "✓ swaync theme set to: Gruvbox (night)"
else
    echo "Usage: ./set-theme.sh <0|1>"
    echo "  0 = Night (Gruvbox)"
    echo "  1 = Day (Kanagawa)"
    exit 1
fi

# Reload swaync CSS
if pgrep -x "swaync" > /dev/null; then
    swaync-client --reload-css
    echo "  ✓ swaync CSS reloaded"
else
    echo "  ⚠ swaync is not running, will apply on start"
fi
