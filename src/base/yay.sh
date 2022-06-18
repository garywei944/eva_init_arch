#!/usr/bin/env bash

_yay() {
  # Exit if yay installed
  [[ -n $(command -v yay) ]] && exit

  cd /tmp || exit
  sudo pacman -S --needed git base-devel
  git clone https://aur.archlinux.org/yay-bin.git --depth 1
  cd yay-bin || exit
  makepkg -si --needed --noconfirm

  rm -fr /tmp/yay-bin
}

arch_cn() {
  # Add archlinuxcn source
  cat <<"EOF" | sudo tee -a /etc/pacman.conf
[archlinuxcn]
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
EOF

  _pacin archlinuxcn-keyring
  sudo pacman -Sy
}
