#!/usr/bin/env bash

_kde() {
  _pacin xorg plasma kde-applications sddm

  sudo systemctl enable sddm
  sudo systemctl enable NetworkManager
}
