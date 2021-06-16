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
echo root:password | passwd

pacman -S grub networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools reflector base-devel linux-headers xdg-user-dirs xdg-utils gvfs gvfs-afc gvfs-smb gvfs-gphoto2 gvfs-mtp gvfs-goa gvfs-nfs gvfs-google alsa-utils bash-completion rsync acpi acpi_call dnsmasq sof-firmware acpid ntfs-3g terminus-font xterm xorg-twm xorg-xclock xfce4 xfce4-goodies pavucontrol pulseaudio-alsa pavucontrol pulseaudio-alsa chromium file-roller unrar p7zip unace lrzip lightdm lightdm-gtk-greeter leafpad arch-install-scripts bash-completion ttf-inconsolata gparted util-linux arc-gtk-theme arc-icon-theme gtk-engine-murrine vim jre-openjdk jdk-openjdk sudo --noconfirm

pacman -S --noconfirm xf86-video-intel
pacman -S --noconfirm xf86-video-nouveau

grub-install /dev/sdx
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable acpid

useradd -m -g users -G wheel -s /bin/bash greg
echo greg:password | passwd1

echo "greg ALL=(ALL) ALL" >> /etc/sudoers.d/greg

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
