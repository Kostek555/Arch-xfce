#!/bin/bash

## ----Reflector----

pacman -Sy
pacman -S intel-ucode gvfs gvfs-afc gvfs-smb gvfs-gphoto2 gvfs-mtp gvfs-goa gvfs-nfs gvfs-google ntfs-3g mtools leafpad file-roller unrar p7zip unace lrzip arch-install-scripts bash-completion dosfstools xdg-user-dirs xdg-utils acpi acpi_call terminus-font ttf-inconsolata util-linux arc-gtk-theme arc-icon-theme gtk-engine-murrine archlinux-wallpaper papirus-icon-theme leafpad jre-openjdk jdk-openjdk net-tools mtools gparted yt-dlp dialog wpa_supplicant rsync meld firefox firefox-i18n-pl icedtea-web wireguard-tools usbutils libreoffice-fresh-pl hunspell-pl gnome-calculator dnsutils iwd nomacs neofetch  networkmanager-openvpn speedtest-cli networkmanager-openvpn linux-headers --noconfirm

systemctl enable fstrim.timer

#----------------------------------
cat <<EOF > /etc/X11/xorg.conf.d/keyboard.conf
Section "InputClass"
    Identifier             "Keyboard Defaults"
    MatchIsKeyboard        "yes"
    Option                 "XkbLayout" "pl"
EndSection
EOF

#------------------------------------------------

printf "\e[1;32mDone! Type exit, umount -R /mnt and reboot.\e[0m"

