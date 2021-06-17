#!/bin/sh


## REFLECTOR

pacman -Sy
pacman -S reflector --noconfirm

reflector --score 5 --latest 10 --sort rate --save /etc/pacman.d/mirrorlist

# CONFIGURATION

echo "arch" > /etc/hostname

sed -i -- 's/#pl_PL.UTF-8 UTF-8/pl_PL.UTF-8 UTF-8/g' /etc/locale.gen
sed -i -- 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen

locale-gen

cat <<EOF > /etc/locale.conf
LANG=pl_PL.UTF-8
LANGUAGE=pl_PL
EOF

echo "KEYMAP=pl" > /etc/vconsole.conf

ln -s /usr/share/zoneinfo/Europe/Warsaw /etc/localtime

hwclock --utc --systohc
timedatectl set-ntp true

# GRUB

pacman -S grub --noconfirm

grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

# DESKTOP

pacman -S xorg-server xorg-xrandr xorg-xinit xorg-xclock xorg-xbacklight xorg-xrdb xorg-xrefresh xorg-xkill xorg-xgamma --noconfirm 

pacman -S xfce4 xfce4-goodies lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings partitionmanager breeze breeze-iconsarc-gtk-theme arc-icon-theme gtk-engine-murrine firefox firefox-i18n-pl chromium --noconfirm

pacman -S sudo nano bash-completions ntfs-3g leafpad arch-install-scripts xdg-user-dirs --noconfirm

pacman -S gvfs gvfs-afc gvfs-smb gvfs-gphoto2 gvfs-mtp gvfs-goa gvfs-nfs gvfs-google util-linux --noconfirm

pacman -S linux-headers --noconfirm

# FONTS

pacman -S ttf-dejavu ttf-liberation ttf-inconsolata --noconfirm

pacman -S file-roller unrar p7zip unace lrzip mtools gparted --noconfirm

# SERVICES

systemctl enable lightdm
systemctl enable NetworkManager
systemctl enable fstrim.timer

# DRIVERS INTEL

pacman -S xf86-video-intel intel-ucode libva-intel-driver libva-mesa-driver mesa vulkan-intel vulkan-tools gst-libav --noconfirm

# USER

useradd -m -g users -G wheel,storage,power,video -s /bin/bash greg

# PASSWORD

echo -e "root\root" | passwd
echo -e "greg\greg" | passwd gred

# SUDO

sed -i -- 's/# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers

cd .. && rm -rf arch
