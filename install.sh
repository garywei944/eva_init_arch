#!/bin/bash

# Exit when error happens
set -o errexit

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

# Find fastest mirrors
echo Optimizing mirrorlist, it may take a few seconds...
reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

# Install essential packages
pacstrap /mnt base linux linux-firmware

# Configure the system
# fstab
genfstab -U /mnt >/mnt/etc/fstab

# Move script to /tmp
cp arch_chroot.sh /mnt/root/

arch-chroot /mnt bash /root/arch_chroot.sh
rm -f /mnt/root/arch_chroot.sh

umount -R /mnt
