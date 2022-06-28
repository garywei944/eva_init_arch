#!/usr/bin/env bash

sound() {
  apps=(
    # pulse audio
    pulseaudio pulseaudio-alsa pulseaudio-bluetooth
    # ALSA
    alsa-utils alsa-firmware sof-firmware alsa-ucm-conf
  )
  _pacin "${apps[@]}"
}
