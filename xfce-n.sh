#!/bin/bash

## ----Reflector----

pacman -Sy
pacman -S reflector  --noconfirm

reflector --verbose --country 'Poland' -l 6 -p https --sort rate --save /etc/pacman.d/mirrorlist

#---------Loaltime-------------------------

sed -i '177s/.//' /etc/locale.gen &&  sed -i '390s/.//' /etc/locale.gen
locale-gen
echo "LANG=pl_PL.UTF-8" >> /etc/locale.conf
echo "pl_PL.UTF-8 UTF-8" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts

ln -s /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
hwclock --systohc --utc
timedatectl set-ntp true

# --------Grub---------------------
pacman -S grub  --noconfirm
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

#--------Xorg----------------------

pacman -S xorg-server xorg-apps xorg-xinit --noconfirm 

#----------------Video-nouveau-----------------------------------------

pacman -S xf86-video-nouveau --noconfirm

cat <<EOF > /etc/X11/xorg.conf.d/20-nouveau.conf
Section "Device"
    Identifier "Nvidia card"
    Driver "nouveau"
EndSection
EOF

#----
mkinitcpio -p linux

#----------System---------------

pacman -S gvfs gvfs-afc gvfs-smb gvfs-gphoto2 gvfs-mtp gvfs-goa gvfs-nfs gvfs-google ntfs-3g mtools base-devel --noconfirm

#---------Lightdm--------------

pacman -S  lightdm lightdm-gtk-greeter-settings lightdm-webkit-theme-litarvan --noconfirm

systemctl enable lightdm

#--------Network------------------

pacman -S networkmanager network-manager-applet networkmanager-openvpn --noconfirm

systemctl enable NetworkManager

#-----------Xfce------------------

pacman -S xfce4 xfce4-goodies pipewire pipewire-pulse file-roller unrar p7zip unace lrzip arch-install-scripts --noconfirm

pacman -S bash-completion dosfstools xdg-user-dirs xdg-utils acpi acpi_call terminus-font ttf-inconsolata util-linux --noconfirm

pacman -S arc-gtk-theme arc-icon-theme gtk-engine-murrine archlinux-wallpaper papirus-icon-theme leafpad jre-openjdk jdk-openjdk sudo firefox-i18n-pl net-tools --noconfirm

pacman -S file-roller unrar p7zip unace lrzip mtools gparted dialog wpa_supplicant rsync --noconfirm

pacman -S libreoffice-fresh-pl hunspell-pl gnome-calculator dnsutils nomacs  --noconfirm

systemctl enable fstrim.timer
systemctl enable reflector.timer

#---------linux-headers---------

pacman -S linux-headers --noconfirm

#----------------------------------
cat <<EOF > /etc/X11/xorg.conf.d/keyboard.conf
Section "InputClass"
    Identifier             "Keyboard Defaults"
    MatchIsKeyboard        "yes"
    Option                 "XkbLayout" "pl"
EndSection
EOF

#------------------------------------------------

# SUDO

sed -i -- 's/# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers



printf "\e[1;32mDone! Type exit, umount -R /mnt and reboot.\e[0m"

