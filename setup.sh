#!/bin/bash

pacman -Syu --noconfirm

apps=(
  xorg plasma kde-applications sddm
)
pacman -S --noconfirm --needed "${apps[@]}"
