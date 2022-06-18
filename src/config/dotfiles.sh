#!/usr/bin/env bash

dotfiles() {
  [[ ${EVA+x} ]] || exit

  cd ~ || exit
  rm -fr .git
  git init
  git remote add origin git@github.com:garywei944/eva_arch.git
  git config core.excludesFile .eva.gitignore
  git fetch --depth=1
  git reset --hard origin/main
  git branch -m master main
  git branch --set-upstream-to=origin/main main
}
