#!/bin/bash

# set Time-zone to US Eastern
ln -sf /usr/share/zoneinfo/US/Eastern /etc/localtime
hwclock --systohc

# Localization
echo "en_US.UTF-8 UTF-8" >>/etc/locale.gen
locale-gen

echo "LANG=en_US.UTF-8" >/etc/locale.conf

# initramfs
mkinitcpio -P

# boot
echo "GRUB_DISABLE_OS_PROBER=false" >>/etc/default/grub
os-prober
# install GRUB based on UEFI
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Set root password
echo Setting root password
passwd root

# Add aris user
useradd -m -G wheel aris
passwd aris

echo arch_chroot.sh finished!
