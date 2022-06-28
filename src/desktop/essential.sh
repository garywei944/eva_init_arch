#!/usr/bin/env bash

desktop_essential() {
  apps=(
    # Gnome Keyring
    gnome-keyring libsecret seahorse
    # Screenshot
    flameshot scrot
    # Essential
    dmenu picom nitrogen terminator ufw xclip numlockx gparted
    # Office
    libreoffice-fresh
    # apps
    discord xdg-utils libpulse sublime-merge
    # zoom
    pulseaudio-alsa qt5-webengine xcompmgr
  )

  aur_apps=(
    albert
    google-chrome
    visual-studio-code-bin
    zoom
    simplenote-electron-bin
    netease-cloud-music
  )

  _pacin "${apps[@]}"

  _yain "${aur_apps[@]}"

  sudo ufw enable
}
