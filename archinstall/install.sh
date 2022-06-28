#!/bin/bash

# This script should be executed within arch linux installation media

# Exit when error happens
set -e

# Clean up temp file
rm /tmp/profile || true

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

# Ask if in China and set up pacman sources

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

# https://stackoverflow.com/questions/3231804/in-bash-how-to-add-are-you-sure-y-n-to-any-command-or-alias
read -r -p "Are you currently in China? [y/N] " response
case "$response" in
[yY][eE][sS] | [yY])
  echo Setting CN sources and Shanghai time zone.
  COUNTRY=CN
  curl -s "https://archlinux.org/mirrorlist/?country=CN&protocol=http&protocol=https&ip_version=4&ip_version=6&use_mirror_status=on" |
    sed -e 's/^#Server/Server/' -e '/^#/d' |
    rankmirrors -n 5 - |
    tee /etc/pacman.d/mirrorlist
  ;;
*)
  echo Setting US sources and US Eastern Time.
  COUNTRY=US
  curl -s "https://archlinux.org/mirrorlist/?country=US&protocol=http&protocol=https&ip_version=4&ip_version=6&use_mirror_status=on" |
    sed -e 's/^#Server/Server/' -e '/^#/d' |
    rankmirrors -n 5 - |
    tee /etc/pacman.d/mirrorlist
  ;;
esac

echo "COUNTRY=$COUNTRY" >>/tmp/profile

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
  git wget pacman-contrib
)
pacstrap /mnt "${apps[@]}"

# install nvidia if needed
lspci | grep -q -i nvidia && pacstrap /mnt nvidia cuda cudnn

# Configure the system
# fstab
genfstab -U /mnt >/mnt/etc/fstab

# Move script to /root
cp arch_chroot.sh /mnt/root/
cp /tmp/profile /mnt/root

arch-chroot /mnt bash /root/arch_chroot.sh
rm -f /mnt/root/arch_chroot.sh

echo install.sh finished!
echo ready to reboot and welcome to Arch Linux!
