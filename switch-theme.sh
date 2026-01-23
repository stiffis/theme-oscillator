#!/bin/bash

# System theme switcher script
# Usage: ./switch-theme.sh [0|1]
# 0 = Night (Gruvbox)
# 1 = Day (Kanagawa)

# Script base directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
    THEME="light"  # Kanagawa (day)
    THEME_LABEL="DAY (Kanagawa)"
elif [ "$1" = "0" ]; then
    THEME="dark"   # Gruvbox (night)
    THEME_LABEL="NIGHT (Gruvbox)"
else
    echo "Error: Invalid argument"
    echo "Use 0 (night) or 1 (day)"
    exit 1
fi

# File to remember the last applied theme
STATE_FILE="$SCRIPT_DIR/.current-theme"

# Check if we're already in that theme
if [ -f "$STATE_FILE" ]; then
    LAST_THEME=$(cat "$STATE_FILE")
    if [ "$LAST_THEME" = "$THEME" ]; then
        echo "Already in $THEME_LABEL mode, no need to change"
        exit 0
    fi
fi

echo "========================================"
echo "🔄 SWITCHING SYSTEM THEME"
echo "========================================"
echo "🎨 Theme to apply: $THEME_LABEL"
echo ""

# Save current theme
echo "$THEME" > "$STATE_FILE"

# ============================================
# 1. GTK (Thunar, nwg-displays, bluetooth)
# ============================================
echo "→ Applying GTK theme..."
if [ "$THEME" = "dark" ]; then
    "$SCRIPT_DIR/gtk/set-theme.sh" 0
else
    "$SCRIPT_DIR/gtk/set-theme.sh" 1
fi

# ============================================
# 2. Neovim
# ============================================
echo ""
echo "→ Applying Neovim theme..."
if [ "$THEME" = "dark" ]; then
    echo "gruvbox" > ~/.config/nvim/current-theme.txt
    echo "  ✓ Neovim: Gruvbox"
else
    echo "kanagawa" > ~/.config/nvim/current-theme.txt
    echo "  ✓ Neovim: Kanagawa"
fi

# ============================================
# 3. Kitty (Terminal)
# ============================================
echo ""
echo "→ Applying Kitty theme..."
if [ "$THEME" = "dark" ]; then
    "$SCRIPT_DIR/kitty/set-theme.sh" 0
else
    "$SCRIPT_DIR/kitty/set-theme.sh" 1
fi

# ============================================
# 4. Waybar
# ============================================
echo ""
echo "→ Applying Waybar theme..."
if [ "$THEME" = "dark" ]; then
    "$SCRIPT_DIR/waybar/set-theme.sh" 0
else
    "$SCRIPT_DIR/waybar/set-theme.sh" 1
fi

# ============================================
# 5. Wallpaper
# ============================================
echo ""
echo "→ Applying wallpaper..."
if [ "$THEME" = "dark" ]; then
    "$SCRIPT_DIR/wallpaper/set-theme.sh" 0
else
    "$SCRIPT_DIR/wallpaper/set-theme.sh" 1
fi

# ============================================
# 6. Hyprlock (lock screen)
# ============================================
echo ""
echo "→ Syncing hyprlock..."
"$SCRIPT_DIR/hyprlock/set-theme.sh"

# ============================================
# 7. Obsidian
# ============================================
echo ""
echo "→ Applying Obsidian theme..."
if [ "$THEME" = "dark" ]; then
    "$SCRIPT_DIR/obsidian/set-theme.sh" 0
else
    "$SCRIPT_DIR/obsidian/set-theme.sh" 1
fi

# ============================================
# 8. wlogout
# ============================================
echo ""
echo "→ Applying wlogout theme..."
if [ "$THEME" = "dark" ]; then
    "$SCRIPT_DIR/wlogout/set-theme.sh" 0
else
    "$SCRIPT_DIR/wlogout/set-theme.sh" 1
fi

# ============================================
# 9. rofi
# ============================================
echo ""
echo "→ Applying rofi theme..."
if [ "$THEME" = "dark" ]; then
    "$SCRIPT_DIR/rofi/set-theme.sh" 0
else
    "$SCRIPT_DIR/rofi/set-theme.sh" 1
fi

# ============================================
# 10. swaync (Notification Center)
# ============================================
echo ""
echo "→ Applying swaync theme..."
if [ "$THEME" = "dark" ]; then
    "$SCRIPT_DIR/swaync/set-theme.sh" 0
else
    "$SCRIPT_DIR/swaync/set-theme.sh" 1
fi

# ============================================
# 11. zathura (PDF viewer)
# ============================================
echo ""
echo "→ Applying zathura theme..."
if [ "$THEME" = "dark" ]; then
    "$SCRIPT_DIR/zathura/set-theme.sh" 0
else
    "$SCRIPT_DIR/zathura/set-theme.sh" 1
fi

echo ""
echo "========================================"
echo "✅ THEME APPLIED: $THEME_LABEL"
echo "========================================"
