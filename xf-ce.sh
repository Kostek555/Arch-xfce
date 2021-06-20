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

echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts

hwclock --utc --systohc
timedatectl set-ntp true

# GRUB

pacman -S grub efibootmgr --noconfirm
grub-install /dev/sdd
grub-install --target=x86_64-efi --efi-directory /boot --boot-directory /boot --removabl
grub-mkconfig -o /boot/grub/grub.cfg



# NETWORK

pacman -S networkmanager network-manager-applet dialog wpa_supplicant mtools base-devel linux-headers --noconfirm

systemctl enable NetworkManager

# DESKTOP

pacman -S xorg xterm xorg-twm xorg-xclock gvfs gvfs-afc gvfs-smb gvfs-gphoto2 gvfs-mtp gvfs-goa gvfs-nfs gvfs-google ntfs-3g gvfs gvfs-afc gvfs-smb gvfs-gphoto2 gvfs-mtp gvfs-goa gvfs-nfs gvfs-google lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings vim sudo --noconfirm

systemctl enable lightdm

pacman -S xfce4 xfce4-goodies pavucontrol pulseaudio-alsa chromium file-roller unrar p7zip unace lrzip leafpad arch-install-scripts bash-completion mtools dosfstools xdg-user-dirs xdg-utils acpi acpi_call  terminus-font ttf-inconsolata gparted util-linux arc-gtk-theme arc-icon-theme gtk-engine-murrine leafpad  jre-openjdk jdk-openjdk --noconfirm

systemctl enable fstrim.timer


# FONTS

pacman -S ttf-dejavu ttf-liberation ttf-inconsolata --noconfirm

pacman -S file-roller unrar p7zip unace lrzip mtools gparted --noconfirm



# SUDO

sed -i -- 's/# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers

cd .. && rm -rf arch
