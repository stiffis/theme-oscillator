#!/bin/bash

# Kitty theme switcher script
# Usage: ./set-theme.sh [0|1]
# 0 = Night (Gruvbox)
# 1 = Day (Kanagawa)

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEMES_DIR="$SCRIPT_DIR/themes"

# Validate argument
if [ -z "$1" ]; then
    echo "Error: You must specify an argument"
    echo "Usage: $0 [0|1]"
    echo "  0 = Night (Gruvbox)"
    echo "  1 = Day (Kanagawa)"
    exit 1
fi

# User Kitty config directory
USER_KITTY_CONFIG="$HOME/.config/kitty"
USER_THEMES_DIR="$USER_KITTY_CONFIG/themes"

# Determine theme from argument
if [ "$1" = "1" ]; then
    THEME_FILE="$USER_THEMES_DIR/kanagawa.conf"
    THEME_NAME="Kanagawa"
    echo "Changing Kitty to DAY theme: Kanagawa"
elif [ "$1" = "0" ]; then
    THEME_FILE="$USER_THEMES_DIR/gruvbox.conf"
    THEME_NAME="Gruvbox"
    echo "Changing Kitty to NIGHT theme: Gruvbox"
else
    echo "Error: Invalid argument"
    echo "Use 0 (night) or 1 (day)"
    exit 1
fi

# Verify theme file exists
if [ ! -f "$THEME_FILE" ]; then
    echo "Error: Theme file not found: $THEME_FILE"
    exit 1
fi

# 1. UPDATE PERSISTENCE (For new windows)
# Create/update current-theme.conf symlink
ln -sf "$THEME_FILE" "$USER_KITTY_CONFIG/current-theme.conf"
echo "✓ Persistence configured: New windows will use $THEME_NAME"

# 2. UPDATE LIVE (For open windows)
# Apply theme to ALL Kitty windows using remote control
# Kitty automatically appends PID to socket (e.g., /tmp/mykitty-1234)
SOCKET_PREFIX="/tmp/mykitty"

# Find all active sockets starting with the prefix
SOCKETS=$(ls ${SOCKET_PREFIX}* 2>/dev/null)

if [ -n "$SOCKETS" ]; then
    for SOCKET in $SOCKETS; do
        if [ -S "$SOCKET" ]; then
            kitty @ --to "unix:$SOCKET" set-colors -a "$THEME_FILE"
        fi
    done
    echo "✓ Kitty theme configured: $THEME_NAME"
    echo "✓ All Kitty windows ($ (echo "$SOCKETS" | wc -l) instances) updated instantly"
else
    if pgrep -x "kitty" > /dev/null; then
        echo "⚠ Kitty is running but no sockets found in ${SOCKET_PREFIX}*"
        echo "  Make sure 'listen_on unix:${SOCKET_PREFIX}' is in your kitty.conf"
    else
        echo "⚠ Kitty is not running."
    fi
fi
