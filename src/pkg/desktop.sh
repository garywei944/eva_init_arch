#!/usr/bin/env bash

_kde() {
  _pacin xorg plasma kde-applications sddm

  sudo systemctl enable sddm
}

_awesome() {
  _pacin awesome

  cd "$HOME"/.config/awesome || exit

  make
}

desktop_apps() {
  _pacin picom
}
