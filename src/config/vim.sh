#!/usr/bin/env bash

config_vim() {
  [[ ${EVA+x} ]] || exit

  cd ~ || exit
  mkdir -p ~/.vim/pack/vendor/start ~/.vim/.backup ~/.vim/.swp ~/.vim/.undo

  #tender
  git clone --depth 1 https://github.com/jacoborus/tender.vim ~/.vim/pack/vendor/start/tendor

  # nerdtree
  git clone --depth 1 https://github.com/scrooloose/nerdtree ~/.vim/pack/vendor/start/nerdtree

  # mru
  git clone --depth 1 https://github.com/lvht/mru ~/.vim/pack/vendor/start/mru

  # fzf
  git clone --depth 1 https://github.com/lvht/fzf ~/.vim/pack/vendor/start/fzf

  # ag
  git clone --depth 1 https://github.com/mileszs/ack.vim ~/.vim/pack/vendor/start/ack

  # exit if no sudo permission
  [[ ${NOSUDO+x} ]] && exit

  _pacin fzf ack the_silver_searcher
}
