#!/bin/bash
# zathura theme switcher
# Usage: ./set-theme.sh <0|1>
# 0 = Night (Gruvbox)
# 1 = Day (Kanagawa)

THEME="$1"
ZATHURA_DIR="$HOME/.config/zathura"

if [ "$THEME" = "1" ]; then
    # Kanagawa (day)
    cp "$ZATHURA_DIR/zathurarc-kanagawa" "$ZATHURA_DIR/zathurarc"
    echo "✓ zathura theme set to: Kanagawa (day)"
elif [ "$THEME" = "0" ]; then
    # Gruvbox (night)
    cp "$ZATHURA_DIR/zathurarc-gruvbox" "$ZATHURA_DIR/zathurarc"
    echo "✓ zathura theme set to: Gruvbox (night)"
else
    echo "Usage: ./set-theme.sh <0|1>"
    echo "  0 = Night (Gruvbox)"
    echo "  1 = Day (Kanagawa)"
    exit 1
fi

# Note: zathura does NOT auto-reload config
# User must restart zathura instances to see changes
if pgrep -x "zathura" > /dev/null; then
    echo "  ⚠ zathura is running - needs restart to apply changes"
    echo "    Close and reopen PDF files to see the new theme"
else
    echo "  ✓ Theme applied - will be used when opening zathura"
fi
