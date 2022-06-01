#!/bin/bash

# set Time-zone to US Eastern
ln -sf /usr/share/zoneinfo/US/Eastern /etc/localtime
hwclock --systohc

# Localization
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

echo "LANG=en_US.UTF-8" > /etc/locale.conf

mkinitcpio -P

# boot


# exit if EVA not set
[[ ${EVA+x} ]] || exit

# Set root password
Echo Setting root password
passwd root

# Add aris user
useradd -m -G wheel aris
passwd aris
