#!/bin/bash

# Find fastest mirrors
echo Optimizing mirrorlist, it may take a few seconds...
reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist

pacman -Syu --noconfirm

apps=(
  xorg plasma kde-applications sddm
)
pacman -S --noconfirm "${apps[@]}"
