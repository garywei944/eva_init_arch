#!/usr/bin/env bash

_awesome() {
  _pacin awesome

  cd ~/.config/awesome/ || exit
  make install
}
