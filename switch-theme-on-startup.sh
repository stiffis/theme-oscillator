#!/bin/bash

# Theme wrapper script for Hyprland startup
# Detects current time and applies the correct theme

# Theme-oscillator directory
SCRIPT_DIR="$HOME/.config/theme-oscillator"

# Detect current time (24h format)
CURRENT_HOUR=$(date +%H)

# Determine theme based on time
if [ "$CURRENT_HOUR" -ge 19 ] || [ "$CURRENT_HOUR" -lt 7 ]; then
    # Night (7 PM - 7 AM) → Gruvbox
    echo "🕐 Time: $CURRENT_HOUR:00 - NIGHT mode"
    "$SCRIPT_DIR/switch-theme.sh" 0
else
    # Day (7 AM - 7 PM) → Kanagawa
    echo "🕐 Time: $CURRENT_HOUR:00 - DAY mode"
    "$SCRIPT_DIR/switch-theme.sh" 1
fi
