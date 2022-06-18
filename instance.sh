#!/usr/bin/env bash

common() {
  (_yay)
  (arch_cn)

  (basic)

  (config_keys)
  (config_git)
  (dotfiles)
  (config_shell)
  (config_vim)

  (_docker)
}

desktop() {
  (common)

  (_kde)
  (_awesome)
}

# Stand Alone Server - no sudo permission
sa_server() {
  export NOSUDO=

  (config_keys)
  (config_git)
  (clone_config)

  (sa_common)

  (config_shell)
  (config_emacs)
  (config_vim)
  (config_server)
}
