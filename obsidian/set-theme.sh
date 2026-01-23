#!/bin/bash

# Obsidian theme switcher script
# Usage: ./set-theme.sh [0|1]
# 0 = Night (Gruvbox)
# 1 = Day (Kanagawa)

# OBSIDIAN FILE PATH - CONFIGURE THIS:
# Replace /home/USER/ with your HOME and VAULT with your Obsidian vault
THEME_FILE="/home/USER/VAULT/obsidian-theme.txt"

# Validate argument
if [ -z "$1" ]; then
    echo "Error: You must specify an argument"
    echo "Usage: $0 [0|1]"
    echo "  0 = Night (Gruvbox)"
    echo "  1 = Day (Kanagawa)"
    exit 1
fi

# Determine theme from argument
if [ "$1" = "1" ]; then
    THEME="Kanagawa"
    echo "Changing Obsidian to DAY theme: Kanagawa"
elif [ "$1" = "0" ]; then
    THEME="Obsidian gruvbox"
    echo "Changing Obsidian to NIGHT theme: Gruvbox"
else
    echo "Error: Invalid argument"
    echo "Use 0 (night) or 1 (day)"
    exit 1
fi

# Write to file (Obsidian watches this file)
echo "$THEME" > "$THEME_FILE"

echo "✓ Obsidian theme configured: $THEME"
echo "  File: $THEME_FILE"
echo ""
echo "📝 Note: In Obsidian, the ThemeSwitcher script will detect the change in 2-3 seconds."
