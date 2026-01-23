#!/bin/bash
# rofi theme switcher
# Usage: ./set-theme.sh <0|1>
# 0 = Night (Gruvbox)
# 1 = Day (Kanagawa)

THEME="$1"
ROFI_DIR="$HOME/.config/rofi/wallust"

if [ "$THEME" = "1" ]; then
    # Kanagawa (day)
    cp "$ROFI_DIR/colors-rofi-kanagawa.rasi" "$ROFI_DIR/colors-rofi.rasi"
    echo "✓ rofi theme set to: Kanagawa (day)"
elif [ "$THEME" = "0" ]; then
    # Gruvbox (night)
    cp "$ROFI_DIR/colors-rofi-gruvbox.rasi" "$ROFI_DIR/colors-rofi.rasi"
    echo "✓ rofi theme set to: Gruvbox (night)"
else
    echo "Usage: ./set-theme.sh <0|1>"
    echo "  0 = Night (Gruvbox)"
    echo "  1 = Day (Kanagawa)"
    exit 1
fi
