#!/usr/bin/env bash
# Check for pending package updates for waybar

# Detect package manager and count updates
UPDATES=""

if command -v checkupdates &>/dev/null; then
    # Arch Linux (pacman)
    UPDATES=$(checkupdates 2>/dev/null | wc -l)
elif command -v apt &>/dev/null; then
    # Debian/Ubuntu
    apt list --upgradable 2>/dev/null | grep -c upgradable
elif command -v dnf &>/dev/null; then
    # Fedora
    UPDATES=$(dnf check-update --quiet 2>/dev/null | grep -cE '^\S')
elif command -v zypper &>/dev/null; then
    # openSUSE
    UPDATES=$(zypper list-updates 2>/dev/null | grep -c '^v ')
fi

# Handle --check flag (for exec-if)
if [ "$1" = "--check" ]; then
    if [ -n "$UPDATES" ] && [ "$UPDATES" -gt 0 ] 2>/dev/null; then
        exit 0
    else
        exit 1
    fi
fi

# Output for waybar
if [ -n "$UPDATES" ] && [ "$UPDATES" -gt 0 ] 2>/dev/null; then
    echo " $UPDATES"
else
    echo " 0"
fi
