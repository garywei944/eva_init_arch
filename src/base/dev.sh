#!/usr/bin/env bash

update() {
  sudo pacman -Syu --noconfirm
}

# Basic Runtime Environments
basic() {
  [[ -n ${NOSUDO+x} ]] && exit

  update

  apps=(
    # System Essentials
    git zsh net-tools openssh wget curl zip unrar ufw gnupg
    # Development Runtimes
    base-devel jdk-openjdk cmake clang nodejs npm rust lua
    python python-pip python-virtualenv python-pipenv
    ghostscript cabal-install r
    # System management
    tmux screen bashtop htop
    fd mlocate fzf ack ranger tree
    ripgrep the_silver_searcher
    rsync traceroute jq
    # Development tools
    emacs vim gdb valgrind ctags rlwrap aspell autoconf libtool
    colordiff dos2unix lazygit postgresql
    # pwngdb
    pwndbg checksec radare2 ropgadget ropper
    # Just for fun
    screenfetch neofetch lolcat figlet fortune-mod cowsay
    # Maybe
    aws-cli
  )

  aur_apps=(
    # Development Runtimes
    mambaforge gitflow-avh
    # Development tools
    shc heroku-cli
  )

  _pacin "${apps[@]}"

  _yain "${aur_apps[@]}"

  # update to latest node
  sudo npm install -g n
  sudo n latest

  # pwngdb
  if ! grep pwndbg ~/.gdbinit &>/dev/null; then
    echo "source /usr/share/pwndbg/gdbinit.py" >>~/.gdbinit
  fi
}
