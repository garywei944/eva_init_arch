#!/usr/bin/env bash

_awesome() {
  _pacin awesome

  cd "$HOME"/.config/awesome/ || exit
  make install
}
