#!/usr/bin/env bash

update() {
  sudo pacman -Syu --noconfirm
}

_yay() {
  cd /tmp || exit
  sudo pacman -S --needed git base-devel
  git clone https://aur.archlinux.org/yay-bin.git --depth 1
  cd yay-bin || exit
  makepkg -si

  rm -fr /tmp/yay-bin
}

# Basic Runtime Environments
basic() {
  [[ -n ${NOSUDO+x} ]] && exit

  update

  [[ -n $(command -v yay) ]] || (_yay)

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
    emacs vim gdb valgrind ctags rlwrap aspell autoconf libtool
    colordiff dos2unix lazygit pwndbg postgresql
    # Just for fun
    screenfetch neofetch lolcat figlet fortune-mod cowsay
    # Maybe
    aws-cli
  )

  aur_apps=(
    # System management
    shadowsocks-rust
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
}
