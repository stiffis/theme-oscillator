#!/bin/bash

# Hyprlock sync script
# Copies the current wallpaper and regenerates colors

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
WALLPAPER_CURRENT="$HOME/.config/hypr/wallpaper_effects/.wallpaper_current"

# Determine current wallpaper from state file
STATE_FILE="$HOME/.config/theme-oscillator/wallpaper/.current-theme"

if [ -f "$STATE_FILE" ]; then
    CURRENT_THEME=$(cat "$STATE_FILE")

    if [ "$CURRENT_THEME" = "dark" ]; then
        WALLPAPER="csl-chan-gruvbox-dark.png"
        THEME_NAME="Gruvbox"
    else
        WALLPAPER="csl-chan-kanagawa.png"
        THEME_NAME="Kanagawa"
    fi
else
    # If not found, use Kanagawa as default
    WALLPAPER="csl-chan-kanagawa.png"
    THEME_NAME="Kanagawa (default)"
fi

WALLPAPER_PATH="$WALLPAPER_DIR/$WALLPAPER"

# Verify wallpaper exists
if [ ! -f "$WALLPAPER_PATH" ]; then
    echo "⚠ Wallpaper not found: $WALLPAPER_PATH"
    exit 1
fi

echo "→ Syncing hyprlock with theme: $THEME_NAME"

# Copy wallpaper to .wallpaper_current
cp "$WALLPAPER_PATH" "$WALLPAPER_CURRENT"
echo "  ✓ Wallpaper copied: $(basename $WALLPAPER)"

# Regenerate colors with wallust
if command -v wallust &> /dev/null; then
    wallust run -s "$WALLPAPER_PATH" > /dev/null 2>&1
    echo "  ✓ Colors regenerated with wallust"
else
    echo "  ⚠ wallust is not installed"
fi

echo "✓ Hyprlock synced"
