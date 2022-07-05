#!/bin/sh
# Executed after .xprofile and before .autostart.sh
# This script contains some general settings usefull for everyone using my dotfiles

# Set keyboard rate higher
xset r rate 300 50
# Map Caps Lock to Escape for easier Vim etc.
setxkbmap -option caps:escape &

# Unclutter, automatically hides the cursor when inactive
unclutter --start-hidden &


