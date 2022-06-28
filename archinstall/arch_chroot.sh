#!/bin/bash

# Exit when error happens
set -e

# Source env variables
. /root/profile || true

# Use CN source if needed
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

case "$COUNTRY" in
CN)
  echo Setting CN sources and Shanghai time zone.
  curl -s "https://archlinux.org/mirrorlist/?country=CN&protocol=http&protocol=https&ip_version=4&ip_version=6&use_mirror_status=on" |
    sed -e 's/^#Server/Server/' -e '/^#/d' |
    rankmirrors -n 5 - |
    tee /etc/pacman.d/mirrorlist
  ;;
*)
  echo Setting US sources and US Eastern Time.
  curl -s "https://archlinux.org/mirrorlist/?country=US&protocol=http&protocol=https&ip_version=4&ip_version=6&use_mirror_status=on" |
    sed -e 's/^#Server/Server/' -e '/^#/d' |
    rankmirrors -n 5 - |
    tee /etc/pacman.d/mirrorlist
  ;;
esac

# set Time-zone
case "$COUNTRY" in
CN)
  ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
  ;;
*)
  ln -sf /usr/share/zoneinfo/US/Eastern /etc/localtime
  ;;
esac
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
