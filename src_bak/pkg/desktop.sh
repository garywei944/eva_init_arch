#!/usr/bin/env bash

_kde() {
  _pacin xorg plasma kde-applications sddm

  sudo systemctl enable sddm
  sudo systemctl enable NetworkManager
}

_awesome() {
  _pacin awesome

  cd "$HOME"/.config/awesome || exit

  make
}

desktop_apps() {
  _pacin picom
}
