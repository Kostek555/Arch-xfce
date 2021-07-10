#!/bin/bash

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

# --------Grub---------------------
pacman -S grub  --noconfirm
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

#--------Xorg----------------------

pacman -S xorg-server xorg-apps --noconfirm 

#----------------Video-intel-----------------------------------------

pacman -S xf86-video-intel libva-intel-driver libva-mesa-driver mesa vulkan-intel vulkan-tools gst-libav --noconfirm

cat <<EOF > /etc/X11/xorg.conf.d/20-intel.conf
Section "Device"
  Identifier "Intel Graphics"
  Driver "intel"
  Option "TearFree" "true"
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

#--------Network------------------

pacman -S networkmanager network-manager-applet --noconfirm

systemctl enable NetworkManager

#-----------Xfce------------------

pacman -S xfce4 xfce4-goodies pavucontrol pulseaudio-alsa file-roller unrar p7zip unace lrzip arch-install-scripts --noconfirm

pacman -S bash-completion dosfstools xdg-user-dirs xdg-utils acpi acpi_call terminus-font ttf-inconsolata util-linux --noconfirm

pacman -S arc-gtk-theme arc-icon-theme gtk-engine-murrine leafpad jre-openjdk jdk-openjdk sudo chromium net-tools --noconfirm

pacman -S file-roller unrar p7zip unace lrzip mtools gparted youtube-dl dialog wpa_supplicant --noconfirm

pacman -S intel-ucode libreoffice-fresh-pl hunspell-pl gnome-calculator --noconfirm

systemctl enable fstrim.timer

#---------linux-headers---------

pacman -S linux-headers --noconfirm

# SUDO

sed -i -- 's/# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers

#-------------

cd .. && rm -rf Arch-xfce


printf "\e[1;32mDone! Type exit, umount -R /mnt and reboot.\e[0m"
