#!/usr/bin/env bash

locale_cn() {
  echo Setting up CN locale
  echo "zh_CN.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen
  sudo locale-gen

  local cn_fonts=(
    adobe-source-han-sans-cn-fonts
    adobe-source-han-sans-tw-fonts
    adobe-source-han-serif-cn-fonts
    adobe-source-han-serif-tw-fonts
    noto-fonts-sc
    noto-fonts-tc
    wqy-microhei
    wqy-zenhei
    wqy-bitmapfont
    ttf-arphic-ukai
    ttf-arphic-uming
    opendesktop-fonts
    ttf-hannom
    ttf-tw
    ttf-twcns-fonts
    ttf-ms-win8-zh_cn
    ttf-ms-win8-zh_tw
    ttf-ms-win10-zh_cn
    ttf-ms-win10-zh_tw
    ttf-i.bming
  )
  for font in "${cn_fonts[@]}"; do
    _yain "$font" || true
  done
}

locale_jp() {
  echo Setting up jp locale
  echo "ja_JP.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen
  sudo locale-gen

  local jp_fonts=(
    adobe-source-han-sans-jp-fonts
    adobe-source-han-serif-jp-fonts
    otf-ipafont
    ttf-hanazono
    ttf-sazanami
    ttf-koruri
    ttf-monapo
    ttf-mplus-git
    ttf-vlgothic
  )
  for font in "${jp_fonts[@]}"; do
    _yain "$font" || true
  done
}

sougou_input() {
  (update)

  _pacin fcitx fcitx-configtool
  _yain fcitx-sogoupinyin

  cat <<"EOF" >>~/.xsession
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
EOF
}

mozc_input() {
  _pacin fcitx-mozc
}
