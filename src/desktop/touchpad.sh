#!/usr/bin/env bash

touchpad() {
  # TODO: maybe automatic check if touchpad device available

  read -r -p "Install touchpad driver? (disabled by default) [y/N] " response
  case "$response" in
  [yY][eE][sS] | [yY])
    echo Installing touchpad driver and disable it
    ;;

  *)
    exit
    ;;
  esac

  _pacin libinput xf86-input-synaptics

  sudo cp /usr/share/X11/xorg.conf.d/70-synaptics.conf /etc/X11/xorg.conf.d

  cat <<"EOF" | sudo tee -a /etc/X11/xorg.conf.d/70-synaptics.conf
# Tap to Click
Section "InputClass"
	Identifier "touchpad"
	Driver "synaptics"
	MatchIsTouchpad "on"
	Option "TapButton1" "1"
	Option "TapButton2" "3"
	Option "TapButton3" "0"
	Option "VertEdgeScroll" "on"
	Option "VertTwoFingerScroll" "on"
	Option "HorizEdgeScroll" "on"
	Option "HorizTwoFingerScroll" "on"
	Option "VertScrollDelta" "-112"
	Option "HorizScrollDelta" "-114"
	Option "MaxTapTime" "125"
EndSection

# Disable touchpad
Section "InputClass"
	Identifier "touchpad"
	MatchDriver "synaptics"
  # Option "TouchpadOff" "1"
EndSection
EOF
}
