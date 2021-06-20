#!/bin/bash

#---------Reflector

pacman -Sy
pacman -S reflector --noconfirm
reflector --score 5 --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

#---------Loaltime-------------------------

ln -s /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
hwclock --systohc --utc

sed -i '177s/.//' /etc/locale.gen &&  sed -i '390s/.//' /etc/locale.gen
locale-gen
echo "LANG=pl_PL.UTF-8" >> /etc/locale.conf
echo "pl_PL.UTF-8 UTF-8" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts


# --------Grub---------------------

pacman -S grub efibootmgr --noconfirm
grub-install /dev/sdc
grub-install --target=x86_64-efi --efi-directory /boot --boot-directory /boot --removabl
grub-mkconfig -o /boot/grub/grub.cfg


#--------Network------------------

pacman -S networkmanager network-manager-applet dialog wpa_supplicant mtools base-devel --noconfirm

systemctl enable NetworkManager

#--------Xorg----------------------

pacman -S xorg xterm xorg-twm xorg-xclock 

#----------System---------------

pacman -S gvfs gvfs-afc gvfs-smb gvfs-gphoto2 gvfs-mtp gvfs-goa gvfs-nfs gvfs-google ntfs-3g

#---------Lightdm--------------

pacman -S  lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings --noconfirm

systemctl enable lightdm

#-----------Xfce------------------

pacman -S xfce4 xfce4-goodies pavucontrol pulseaudio-alsa chromium file-roller unrar p7zip unace lrzip leafpad arch-install-scripts bash-completion mtools dosfstools xdg-user-dirs xdg-utils acpi acpi_call terminus-font ttf-inconsolata gparted util-linux arc-gtk-theme arc-icon-theme gtk-engine-murrine leafpad jre-openjdk jdk-openjdk vim sudo --noconfirm

systemctl enable fstrim.timer
systemctl enable reflector.timer

#---------linux-headers---------

pacman -S linux-headers --noconfirm

#=========================
cd .. 

printf "\e[1;32mDone! Type exit, umount -R /mnt and reboot.\e[0m"

