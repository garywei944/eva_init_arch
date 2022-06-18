# eva_init_arch

Arch Linux Initialization Script

***Intended to be changed, I'm going to merge this repo with [eva_init](https://github.com/garywei944/eva_init).***

## TL;DR

*Under development, Not Safe For Work*

1. Follow the [installation guide](https://wiki.archlinux.org/title/installation_guide) to format partitions and mount to `/mnt`.
2. Run `bash install.sh` in the live environment.
   1. Arch linux should be installed with drivers and a small set of packages
   2. `nvidia` installed if detected
   3. `intel-ucode` or `amd-ucode` is installed as detected
   4. No graphics user interface is installed at this point
3. Run `bash setup.sh` to install a desktop and other packages.

## Clean Arch Linux installation workflow

1. Archinstall
   1. *Connect to internet (Manual)*
   2. *Mount partitions*
   3. Install arch linux
      - Basic drivers: nvidia, amd-ucode, touch-pad, etc
      - en_US locale
      - US Eastern time
      - Essential tools
      - New user & sudo
2. Post Install
   1. Base
      1. yay, CN source if needed
      2. development environments
         - Runtime environment
         - Commandline tools
      3. Base configs
         - private keys & secrets
         - config files
         - shell (zsh)
         - vim
      4. Docker
   2. Desktop
      1. Desktop Environment
         - Xorg, KDE, SDDM
         - Awesome WM
      2. Chinese & Japanese
         - Fonts, locate, input
      3. Drivers & Essential tools
         - pulse audio
         - screenshot (flameshot)
         - albert, dmenu, picom, nitrogen, terminator, etc
         - security (ufw)
         - chrome
   3. VMs
      - VirtualBox
      - Vagrant
      - VMware
3. Configuration and other software!
