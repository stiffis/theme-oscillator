# theme-oscillator

Automatic theme switching system for Hyprland with day/night themes.

**Kanagawa** (Day, 7:00 AM) <-> **Gruvbox** (Night, 8:52 PM)

---

## Features

- **11 applications supported**: GTK, Neovim, Kitty, Waybar, Wallpaper, Hyprlock, Obsidian, wlogout, rofi, swaync, zathura
- **Automatic switching**: Timers for 7:00 AM (Kanagawa) and 8:52 PM (Gruvbox)
- **Startup detection**: Automatically detects time when Hyprland starts
- **Manual control**: Switch themes anytime with a single command
- **Session preservation**: Firefox tabs, terminal sessions, and other states are preserved

---

## Quick Start

### Prerequisites

**Required Software:**
```bash
# Hyprland ecosystem
hyprland
waybar
rofi
wlogout
swaync

# Terminal and editor
kitty
neovim

# Utilities
swww           # Wallpaper manager
wallust        # Colors from wallpaper
glib-compile-schemas  # GTK schemas
jq              # JSON processing
python3         # Scripts

# Additional for Obsidian (optional)
# - QuickAdd plugin
# - User Scripts plugin
```

### Installation

1. **Clone the repository:**
```bash
git clone https://github.com/stiffis/theme-oscillator.git
cd theme-oscillator
```

2. **Configure paths (see CONFIGURATION.md):**
```bash
# Edit these files and replace /home/USER/ with your actual paths:
# - obsidian/set-theme.sh
# - systemd-timers/theme-morning.service
# - systemd-timers/theme-evening.service
```

3. **Install to config directory:**
```bash
cp -r theme-oscillator ~/.config/
```

4. **Setup systemd timers:**
```bash
cp systemd-timers/*.service ~/.config/systemd/user/
cp systemd-timers/*.timer ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable theme-morning.timer
systemctl --user enable theme-evening.timer
```

5. **Setup Hyprland startup:**
```bash
cp switch-theme-on-startup.sh ~/.config/hypr/scripts/
```

Add to `~/.config/hypr/UserConfigs/Startup_Apps.conf`:
```conf
exec-once = ~/.config/hypr/scripts/switch-theme-on-startup.sh
```

---

## Usage

### Manual Theme Switch

```bash
# Switch to Gruvbox (Night)
~/.config/theme-oscillator/switch-theme.sh 0

# Switch to Kanagawa (Day)
~/.config/theme-oscillator/switch-theme.sh 1
```

### Timer Schedule

| Timer | Time | Theme |
|-------|------|-------|
| `theme-morning.timer` | 07:00 AM | Kanagawa (Day) |
| `theme-evening.timer` | 20:52 (8:52 PM) | Gruvbox (Night) |

### Useful Commands

```bash
# Check timer status
systemctl --user list-timers

# Manually trigger a theme change
systemctl --user start theme-morning.service  # Kanagawa now
systemctl --user start theme-evening.service  # Gruvbox now

# View logs
journalctl --user -u theme-morning.service
journalctl --user -u theme-evening.service

# Disable timers temporarily
systemctl --user stop theme-morning.timer
systemctl --user stop theme-evening.timer
```

---

## Supported Applications

| # | Application | Change Method | Reloads Without Close |
|---|-------------|---------------|----------------------|
| 1 | GTK | gsettings + sed | Yes |
| 2 | Neovim | File watcher + Lua | Yes |
| 3 | Kitty | Socket IPC | Yes |
| 4 | Waybar | SIGUSR1/SIGUSR2 | Yes |
| 5 | Wallpaper | swww img | Yes |
| 6 | Hyprlock | wallust + cp | Yes |
| 7 | Obsidian | File watcher + JS | Yes |
| 8 | wlogout | CSS swap | Yes |
| 9 | rofi | wallust colors | Yes |
| 10 | swaync | CSS reload | Yes |
| 11 | zathura | Config file | No (Requires restart) |

---

## Customization

### Change Timer Schedules

Edit the timer files:
```bash
~/.config/systemd/user/theme-morning.timer
~/.config/systemd/user/theme-evening.timer
```

Change `OnCalendar` value:
```ini
# For 8:00 AM
OnCalendar=*-*-* 08:00:00

# For 9:00 PM
OnCalendar=*-*-* 21:00:00
```

Then reload:
```bash
systemctl --user daemon-reload
systemctl --user restart theme-morning.timer
systemctl --user restart theme-evening.timer
```

### Add New Applications

See `TEMPLATE.md` for a template on how to add new applications.

### Theme Colors

- **Kanagawa Wave**: Blue accent colors (`#7E9CD8`)
- **Gruvbox**: Orange/Yellow accent colors (`#d79921`)

---

## Configuration

All configurable paths are documented in `CONFIGURATION.md`.

Key files to configure:
- `obsidian/set-theme.sh` - Obsidian vault path
- `systemd-timers/theme-morning.service` - Script path
- `systemd-timers/theme-evening.service` - Script path

---

## Troubleshooting

### Waybar disappears after theme switch

This is a known issue with Hyprland's `exec-once`. The solution is to use signals instead of killing the process:
```bash
pkill -SIGUSR2 waybar
pkill -SIGUSR1 waybar
```

### Timers not firing

Check if systemd user service is running:
```bash
systemctl --user status
systemctl --user list-timers
```

### Theme not applying

Check the logs:
```bash
journalctl --user -u theme-morning.service -n 50
journalctl --user -u theme-evening.service -n 50
```

---

## Files Overview

```
theme-oscillator/
├── switch-theme.sh              # Main theme switcher script
├── switch-theme-on-startup.sh   # Startup wrapper (detects time)
├── CONFIGURATION.md             # Path configuration guide
├── README.md                    # This file
├── TEMPLATE.md                  # How to add new applications
├── gtk/                         # GTK theme scripts
├── kitty/                       # Kitty terminal theme scripts
├── waybar/                      # Waybar theme scripts
├── wallpaper/                   # Wallpaper scripts
├── hyprlock/                    # Hyprlock theme scripts
├── neovim/                      # Neovim plugin scripts
├── obsidian/                    # Obsidian theme scripts
├── wlogout/                     # wlogout theme scripts
├── rofi/                        # Rofi theme scripts
├── swaync/                      # SwayNC theme scripts
├── zathura/                     # Zathura theme scripts
├── systemd-timers/              # Systemd timer files
└── themes/                      # Theme definitions
```

---

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

---

## License

This project is licensed under the **GPL-3.0 License**.

See `LICENSE` file for details.

---

## Credits

- **Kanagawa Theme**: Based on [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim)
- **Gruvbox Theme**: Based on [gruvbox](https://github.com/morhetz/gruvbox)
- **Hyprland**: [hyprland](https://github.com/hyprwm/Hyprland)

---

Made with love for the Hyprland community