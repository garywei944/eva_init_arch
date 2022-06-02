#!/usr/bin/env bash

common() {
  (basic)
  (config_sudo)

  (config_keys)
  (config_git)
  (clone_config)

  (_docker)
  (_gtest) || true

  (config_terminal)
  (config_vim)
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
  (_mambaforge)
  (_awscli)

  (config_terminal)
  (config_emacs)
  (config_vim)
  (config_server)
}

vagrant() {
  (common)
  (config_server)
}
