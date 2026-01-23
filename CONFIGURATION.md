# Configuration Guide

This file contains all paths you need to CUSTOMIZE for your system.

---

## 📁 Directory Structure

By default, the project uses:
- `~/.config/theme-oscillator/` - Where you install the project
- `/home/USER/` - Your home directory

---

## 🔧 Paths to Configure

### 1. Obsidian
**File:** `obsidian/set-theme.sh`

```bash
THEME_FILE="/home/USER/VAULT/obsidian-theme.txt"
```

Replace:
- `/home/USER/` → Your HOME (e.g., `/home/yourname/`)
- `VAULT` → Your Obsidian vault (e.g., `my-notes/`)

**Example:**
```bash
THEME_FILE="/home/juan/my-notes/obsidian-theme.txt"
```

---

### 2. systemd timers
**Files:** `systemd-timers/theme-morning.service` and `theme-evening.service`

```ini
ExecStart=/home/USER/.config/theme-oscillator/switch-theme.sh
```

Replace:
- `/home/USER/` → Your HOME

**Example:**
```ini
ExecStart=/home/juan/.config/theme-oscillator/switch-theme.sh
```

---

### 3. Startup script (optional)
**File:** `switch-theme-on-startup.sh`

```bash
SCRIPT_DIR="$HOME/.config/theme-oscillator"
```

This uses `$HOME` automatically, no changes needed.

---

## 📋 Files to Modify Summary

| File | What to change |
|------|----------------|
| `obsidian/set-theme.sh` | `THEME_FILE` |
| `systemd-timers/theme-morning.service` | `ExecStart` |
| `systemd-timers/theme-evening.service` | `ExecStart` |

---

## ✅ After Configuring

1. Copy the project to your config directory:
```bash
cp -r theme-oscillator ~/.config/
```

2. Setup timers:
```bash
cp systemd-timers/*.service ~/.config/systemd/user/
cp systemd-timers/*.timer ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable theme-morning.timer
systemctl --user enable theme-evening.timer
```

3. Setup Hyprland startup:
```bash
cp switch-theme-on-startup.sh ~/.config/hypr/scripts/
# Add to Startup_Apps.conf:
# exec-once = ~/.config/hypr/scripts/switch-theme-on-startup.sh
```

---

## 💡 Tip

You can use environment variables:
```bash
# In your .bashrc or .zshrc
export THEME_OSCILLATOR="$HOME/.config/theme-oscillator"
```

Then scripts will use that variable if you define it.
