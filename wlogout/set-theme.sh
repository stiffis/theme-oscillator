#!/bin/bash
# wlogout theme switcher
# Usage: ./set-theme.sh <0|1>
# 0 = Night (Gruvbox)
# 1 = Day (Kanagawa)

THEME="$1"
WL_DIR="$HOME/.config/wlogout"

if [ "$THEME" = "1" ]; then
    # Kanagawa (day)
    cp "$WL_DIR/themes/kanagawa.css" "$WL_DIR/style.css"
    echo "✓ wlogout theme set to: Kanagawa (day)"
elif [ "$THEME" = "0" ]; then
    # Gruvbox (night)
    cp "$WL_DIR/themes/gruvbox.css" "$WL_DIR/style.css"
    echo "✓ wlogout theme set to: Gruvbox (night)"
else
    echo "Usage: ./set-theme.sh <0|1>"
    echo "  0 = Night (Gruvbox)"
    echo "  1 = Day (Kanagawa)"
    exit 1
fi
