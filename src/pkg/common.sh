#!/usr/bin/env bash

update() {
  pacman -Syu --noconfirm
}

_yay() {
  cd /tmp || exit
  pacman -S --needed git base-devel
  git clone https://aur.archlinux.org/yay-bin.git --depth 1
  cd yay-bin || exit
  makepkg -si

  rm -fr /tmp/yay-bin
}

# Basic Runtime Environments
basic() {
  [[ -n ${NOSUDO+x} ]] && exit

  update

  (_yay)

  apps=(
    # System Essentials
    git zsh net-tools openssh wget curl zip unrar ufw gnupg rust
    # System management
    screen tmux bashtop htop fd mlocate ripgrep the_silver_searcher rsync
    numlockx traceroute jq ranger tree
    # Development Runtimes
    base-devel jdk-openjdk python python-pip python-virtualenv python-pipenv
    cmake clang ghostscript cabal-install lua nodejs npm r
    # Development tools
    emacs vim gitflow-avh gdb valgrind ctags rlwrap aspell autoconf libtool
    colordiff dos2unix lazygit pwndbg postgresql
    # Just for fun
    screenfetch neofetch lolcat figlet fortune-mod cowsay
  )

  aur_apps=(
    # System Essentials
    rar
    # System management
    shadowsocks-rust
    # Development Runtimes
    mamabaforge
    # Development tools
    shc heroku-cli aws-cli-v2
  )

  _pacin "${apps[@]}"

  _yain "${aur_apps[@]}"

  # update to latest node
  sudo npm install -g n
  sudo n latest
}
