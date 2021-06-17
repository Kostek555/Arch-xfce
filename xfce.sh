#!/bin/bash


#Reflector

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


pacman -S xorg networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools  base-devel linux-headers xdg-user-dirs xdg-utils gvfs gvfs-afc gvfs-smb gvfs-gphoto2 gvfs-mtp gvfs-goa gvfs-nfs gvfs-google alsa-utils bash-completion  acpi acpi_call dnsmasq sof-firmware acpid ntfs-3g terminus-font xterm xorg-twm xorg-xclock xfce4 xfce4-goodies pavucontrol pulseaudio-alsa  chromium file-roller unrar p7zip unace lrzip lightdm lightdm-gtk-greeter leafpad arch-install-scripts ttf-inconsolata gparted util-linux arc-gtk-theme arc-icon-theme gtk-engine-murrine vim jre-openjdk jdk-openjdk sudo lightdm lightdm-gtk-greeter	lightdm-gtk-greeter-settings --noconfirm




systemctl enable lightdm
systemctl enable NetworkManager
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable acpid



printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"

