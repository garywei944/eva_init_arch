#!/bin/bash

# Check if CPU is intel or amd
lscpu | grep -q -i intel && cpu_make=intel || cpu_make=amd
# Check if GPU is nvidia
lspci | grep -q -i nvidia && nvidia=nvidia
pacstrap_apps=(
  # arch linux basic
  base linux linux-firmware base-devel
  # system basic
  ntfs-3g dhcpcd iwd zsh vim man
  # cpu and gpu drivers
  "$cpu_make"-ucode "$nvidia"
  # Dual-system
  grub efibootmgr os-prober
  # useful tools
  git wget
)
pacstrap /mnt "${pacstrap_apps[@]}"

# set Time-zone to US Eastern
ln -sf /usr/share/zoneinfo/US/Eastern /etc/localtime
hwclock --systohc

# Localization
echo "en_US.UTF-8 UTF-8" >>/etc/locale.gen
locale-gen

echo "LANG=en_US.UTF-8" >/etc/locale.conf

# Hostname
read -r -p "Hostname: " hostname
echo "$hostname" >/etc/hostname

# initramfs
mkinitcpio -P

# Enable network
systemctl enable dhcpcd

# boot

# https://www.reddit.com/r/archlinux/comments/v0x3c4/psa_if_you_run_kernel_518_with_nvidia_pass_ibtoff/
sed '/GRUB_CMDLINE_LINUX=/s/"$/ibt=off"$/' -i /etc/default/grub

echo "GRUB_DISABLE_OS_PROBER=false" >>/etc/default/grub
os-prober
# install GRUB based on UEFI
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Set root password
echo ---------------------------------------------------------------------------
echo Setting root password
passwd root

# Add aris user
echo ---------------------------------------------------------------------------
echo Setting aris password
useradd -m -G wheel aris
passwd aris

echo arch_chroot.sh finished!
