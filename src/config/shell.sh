#!/usr/bin/env bash

# Configure sudo without password
config_sudo() {
  cat <<"EOF" | sudo tee -a /etc/sudoers
Defaults	editor=/usr/bin/vim
%wheel	ALL=(ALL:ALL)	NOPASSWD: ALL
EOF
}

# Configuration Terminal
config_shell() {
  [[ ${EVA+x} ]] || exit

  # Configure zsh
  chsh -s /bin/zsh || cat <<'EOF' >>~/.bashrc
if [[ -n $SSH_TTY && $SHLVL == 1 && -n $(command -v zsh) ]]; then
	zsh
	exit
fi
EOF

  if [[ $COUNTRY == CN ]]; then
    wget https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh -O - | sh
  else
    wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh
  fi
  git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh_custom/plugins/zsh-autosuggestions
  git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh_custom/plugins/zsh-syntax-highlighting

  echo '. ~/.config/rc.zsh' >~/.zshrc
}
