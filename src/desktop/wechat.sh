#!/usr/bin/env bash

_wechat() {
  # Enabling multilib
  cat <<"EOF" | sudo tee -a /etc/pacman.conf
[multilib]
Include = /etc/pacman.d/mirrorlist
EOF

  pacman -Sy

  _pacin lib32-nvidia-utils wine
  _yain noto-fonts-sc
  _yain deepin-wine-wechat
}
