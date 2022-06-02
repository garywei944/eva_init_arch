#!/usr/bin/env bash

[[ -z $SRC_DIR ]] && SRC_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null && pwd)

_pacin() {
  sudo pacman -S --needed --noconfirm "$@"
}

_yain() {
  yay -S --needed --noconfirm "$@"
}

for f in "$SRC_DIR"/pkg/*.sh; do
  # shellcheck source=/dev/null
  . "$f"
done
