#!/bin/sh
pkgs=$(sed "s/\s*#.*//g;/^$/d" .packages | tr '\n' ' ')
aur_pkgs=$(sed "s/\s*#.*//g;/^$/d" .aur-packages | tr '\n' ' ')
sudo pacman -S --needed $pkgs
paru -S --needed $aur_pkgs
