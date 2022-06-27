#!/bin/bash

# Exit when error happens
set -e

# set Time-zone to US Eastern
ln -sf /usr/share/zoneinfo/US/Eastern /etc/localtime
hwclock --systohc

# Localization
echo "en_US.UTF-8 UTF-8" >>/etc/locale.gen
locale-gen

echo "LANG=en_US.UTF-8" >/etc/locale.conf

# Hostname
echo ---------------------------------------------------------------------------
read -r -p "Hostname: " hostname
echo "$hostname" >/etc/hostname

# hosts file
cat <<"EOF" >>/etc/hosts
#<ip-address>	<hostname.domain.org>	<hostname>
127.0.0.1	localhost.localdomain	localhost
::1		localhost.localdomain	localhost
EOF

# initramfs
mkinitcpio -P

# Enable network
systemctl enable dhcpcd

# boot

# https://www.reddit.com/r/archlinux/comments/v0x3c4/psa_if_you_run_kernel_518_with_nvidia_pass_ibtoff/
sed '/GRUB_CMDLINE_LINUX=/s/"$/ibt=off"/' -i /etc/default/grub

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
read -r -p "Admin username: " username
echo Setting "$username" password
useradd -m -G wheel "$username"
passwd aris

# Enable wheel admin no password
cat <<"EOF" | sudo tee -a /etc/sudoers
Defaults	editor=/usr/bin/vim
%wheel	ALL=(ALL:ALL)	NOPASSWD: ALL
EOF

echo arch_chroot.sh finished!
