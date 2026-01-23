#!/bin/bash

# Waybar theme switcher script
# Usage: ./set-theme.sh [0|1]
# 0 = Night (Gruvbox)
# 1 = Day (Kanagawa)

WAYBAR_CONFIG="$HOME/.config/waybar"
WAYBAR_CSS="$WAYBAR_CONFIG/style.css"

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
    THEME_IMPORT='@import "../waybar/style/kanagawa-themes/wave.css";'
    THEME_NAME="Kanagawa Wave"
    echo "Changing Waybar to DAY theme: Kanagawa"
elif [ "$1" = "0" ]; then
    THEME_IMPORT='@import "../waybar/style/gruvbox.css";'
    THEME_NAME="Gruvbox"
    echo "Changing Waybar to NIGHT theme: Gruvbox"
else
    echo "Error: Invalid argument"
    echo "Use 0 (night) or 1 (day)"
    exit 1
fi

# Verify CSS file exists
if [ ! -f "$WAYBAR_CSS" ]; then
    echo "Error: style.css not found: $WAYBAR_CSS"
    exit 1
fi

echo ""
echo "=== Changing Waybar theme ==="

# 1. Update @import line in style.css
sed -i "s|^@import.*|${THEME_IMPORT}|" "$WAYBAR_CSS"
echo "✓ Import updated: $THEME_NAME"

# 2. Reload waybar WITHOUT killing it (using signals like Refresh.sh)
if pgrep -x "waybar" > /dev/null; then
    echo "→ Waybar detected, reloading CSS..."

    # Send USR2 signal to reload CSS (without killing the process)
    # Note: SIGUSR1 toggles visibility (hide/show), so we removed it to prevent hiding
    killall -q cava
    pkill -SIGUSR2 waybar
    sleep 0.3

    # Verify it's still running
    if pgrep -x "waybar" > /dev/null; then
        echo "✓ Waybar reloaded successfully (theme: $THEME_NAME)"
    else
        echo "⚠ Waybar closed, restarting..."
        waybar > /dev/null 2>&1 &
        sleep 0.5
        if pgrep -x "waybar" > /dev/null; then
            echo "✓ Waybar restarted"
        fi
    fi
else
    echo "→ Waybar was not running, starting..."
    waybar > /dev/null 2>&1 &
    sleep 0.5

    if pgrep -x "waybar" > /dev/null; then
        echo "✓ Waybar started"
    else
        echo "⚠ Error: Could not start Waybar"
    fi
fi

echo ""
echo "=== Theme applied: $THEME_NAME ==="
