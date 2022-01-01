#!/bin/bash

## ----Reflector----

pacman -Sy
pacman -S reflector --noconfirm

reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

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
hwclock --systohc

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

# KERNEL INITRD

mkinitcpio -P

# FASTBOOT

echo "options i915 fastboot=1" > /etc/modprobe.d/i915.conf

#----------System---------------

pacman -S gvfs gvfs-afc gvfs-smb gvfs-gphoto2 gvfs-mtp gvfs-goa gvfs-nfs gvfs-google ntfs-3g mtools base-devel --noconfirm

#---------Lightdm--------------

pacman -S  lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings --noconfirm

systemctl enable lightdm


#-----------Xfce------------------

pacman -S xfce4 xfce4-goodies pipewire pipewire-pulse  arch-install-scripts --noconfirm

pacman -S bash-completion  --noconfirm

pacman -S arc-gtk-theme arc-icon-theme gtk-engine-murrine archlinux-wallpaper papirus-icon-theme leafpad firefox --noconfirm

pacman -S file-roller unrar p7zip unace lrzip mtools gparted youtube-dl dialog wpa_supplicant rsync --noconfirm

pacman -S intel-ucode libreoffice-fresh-pl  gnome-calculator  nomacs --noconfirm

#systemctl enable fstrim.timer
#systemctl enable reflector.timer

#---------linux-headers---------

pacman -S linux-headers --noconfirm

#-----------------------------------
cat <<EOF > /etc/X11/xorg.conf.d/keyboard.conf
Section "InputClass"
    Identifier             "Keyboard Defaults"
    MatchIsKeyboard        "yes"
    Option                 "XkbLayout" "pl"
EndSection
EOF

#---------------------------------------------

cd .. && rm -rf Arch-xfce


printf "\e[1;32mDone! Type exit, umount -R /mnt and reboot.\e[0m"

