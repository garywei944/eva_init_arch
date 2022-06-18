#!/bin/bash

# This script should be executed within arch linux installation media

# Exit when error happens
set -e

# Print premise message
echo Please make sure that
echo 1. Connected to the internet
echo 2. All disk partition and filesystem are created manually and mounted under /mnt
read -r -p "Press Enter to Continue..."
echo ---------------------------------------------------------------------------

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

# Check if using UEFI
ls /sys/firmware/efi/efivars &>/dev/null && UEFI=1
if [[ -n $UEFI ]] && ! mountpoint -q /mnt; then
  echo /mnt not mounted!
  exit 1
fi

## Find fastest mirrors
#echo Optimizing mirrorlist, it may take a few seconds...
#reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

# Install essential packages

# Check if CPU is intel or amd
lscpu | grep -q -i intel && cpu_make=intel || cpu_make=amd
apps=(
  # arch linux basic
  base linux linux-firmware base-devel
  # system basic
  ntfs-3g dhcpcd iwd zsh vim man
  # cpu and gpu drivers
  "$cpu_make"-ucode
  # Dual-system
  grub efibootmgr os-prober
  # useful tools
  git wget
)
pacstrap /mnt "${apps[@]}"

# install nvidia if needed
lspci | grep -q -i nvidia && pacstrap /mnt nvidia cuda cudnn

# Configure the system
# fstab
genfstab -U /mnt >/mnt/etc/fstab

# Move script to /tmp
cp arch_chroot.sh /mnt/root/

arch-chroot /mnt bash /root/arch_chroot.sh
rm -f /mnt/root/arch_chroot.sh

echo install.sh finished!
echo ready to reboot and welcome to Arch Linux!
