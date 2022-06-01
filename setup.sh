#!/bin/bash

# Exit when error happens
set -o errexit

# Print premise message
echo Please make sure that
echo 1. Connected to the internet
echo 2. All disk partition and filesystem are created manually and mounted under /mnt
read -r -p "Press Enter to Continue..."

# Assume using en keyboard layout

# Check internet access
if ! ping -c 1 archlinux.org &>/dev/null; then
  echo Please set up internet connection first!
  exit 1
fi

# Update system clock
timedatectl set-ntp true

# Check if /mnt is mounted
if ! mountpoint -q /mnt; then
  echo /mnt not mounted!
  exit 1
fi

# Find fastest mirrors
echo Optimizing mirrorlist, it may take a few seconds...
reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

# Install essential packages

# Check if CPU is intel or amd
if lscpu | grep -q -i intel; then cpu_make=intel; else cpu_make=amd; fi
# Check if GPU is nvidia
if lspci | grep -q -i nvidia; then nvidia=nvidia; fi
pacstrap_apps=(
  # arch linux basic
  base linux linux-firmware base-devel
  # system basic
  ntfs-3g dhcpcd iwd zsh vim man
  # cpu and gpu drivers
  "$cpu_make"_ucode "$nvidia"
  # Dual-system
  grub efibootmgr os-prober
  # useful tools
  git wget
)
pacstrap /mnt "${pacstrap_apps[@]}"

# Configure the system
# fstab
genfstab -U /mnt >> /mnt/etc/fstab

# Move script to /tmp
chmod +x arch_chroot.sh
mv arch_chroot.sh /mnt/tmp/

arch-chroot /mnt /tmp/arch_chroot.sh
