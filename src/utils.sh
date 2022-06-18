#!/usr/bin/env bash

_pacin() {
  sudo pacman -S --needed --noconfirm "$@"
}

_yain() {
  yay -S --needed --noconfirm --useask --noremovemake "$@"
}

_gcld() {
  git clone --recurse-submodules --depth 1
}
