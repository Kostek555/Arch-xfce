#!/bin/bash

pacman -Sy
pacman -S reflector --noconfirm

reflector --score 5 --latest 10 --sort rate --save /etc/pacman.d/mirrorlist

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


pacman -S networkmanager network-manager-applet dialog wpa_supplicant mtools base-devel linux-headers --noconfirm

systemctl enable NetworkManager

pacman -S xorg xterm xorg-twm xorg-xclock gvfs gvfs-afc gvfs-smb gvfs-gphoto2 gvfs-mtp gvfs-goa gvfs-nfs gvfs-google ntfs-3g gvfs gvfs-afc gvfs-smb gvfs-gphoto2 gvfs-mtp gvfs-goa gvfs-nfs gvfs-google lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings vim sudo --noconfirm

systemctl enable lightdm

pacman -S xfce4 xfce4-goodies pavucontrol pulseaudio-alsa chromium file-roller unrar p7zip unace lrzip leafpad arch-install-scripts bash-completion mtools dosfstools xdg-user-dirs xdg-utils acpi acpi_call  terminus-font ttf-inconsolata gparted util-linux arc-gtk-theme arc-icon-theme gtk-engine-murrine leafpad  jre-openjdk jdk-openjdk --noconfirm

systemctl enable fstrim.timer

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"

