# eva_init_arch

Arch Linux Initialization Script

***Intended to be changed, I'm going to merge this repo with [eva_init](https://github.com/garywei944/eva_init).***

## TL;DR

*Under development, not safe for work*

1. Follow the [installation guide](https://wiki.archlinux.org/title/installation_guide) to format partitions and mount to `/mnt`.
2. Run `bash install.sh` in the live environment.
   1. Arch linux should be installed with drivers and a small set of packages
   2. `nvidia` installed if detected
   3. `intel-ucode` or `amd-ucode` is installed as detected
   4. No graphics user interface is installed at this point
3. Run `bash setup.sh` to install a desktop and other packages.
