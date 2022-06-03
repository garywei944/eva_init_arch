#!/usr/bin/env bash

set -e

sudo pacman -Syu

pacin() {
  sudo pacman -S --needed --noconfirm "$@"
}

yain() {
  yay -S --needed --noconfirm --useask --noremovemake "$@"
}

apps=(
  xorg plasma kde-applications sddm
  pulseaudio picom nitrogen flameshot

  # Libre Office
  libreoffice-fresh

  # apps
  discord netease-cloud-music
)

aur_apps=(
  google-chrome albert visual-studio-code-bin
  zoom simplenote-electron-bin
)

pacin "${apps[@]}"
yain "${aur_apps[@]}"

# Chinese
echo "zh_CN.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen
sudo locale-gen
cn_fonts=(
  ttf-ubraille ttf-symbola texlive-core noto-fonts-emoji ttf-cm-unicode
  otf-latin-modern otf-xits ttf-joypixels ttf-twemoji-color
  adobe-source-han-sans-otc-fonts adobe-source-han-serif-otc-fonts
  noto-fonts-cjk wqy-microhei wqy-microhei-lite ttf-i.bming
  adobe-source-han-serif-cn-fonts adobe-source-han-serif-tw-fonts
  adobe-source-han-sans-cn-fonts adobe-source-han-sans-tw-fonts noto-fonts-sc
  noto-fonts-tc wqy-zenhei wqy-bitmapfont ttf-arphic-ukai ttf-arphic-uming
  opendesktop-fonts ttf-hannom ttf-tw ttf-twcns-fonts ttf-ms-win8-zh_cn
  ttf-ms-win8-zh_tw ttf-ms-win10-zh_cn ttf-ms-win10-zh_tw fonts-cjk
  fonts-cjk-sc-yrdzst
)
yain "${cn_fonts[@]}"

# VS Code
yain visual-studio-code-bin
pacin libdbusmenu-glib org.freedesktop.secrets
yain icu69
