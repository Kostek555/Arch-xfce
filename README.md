# Arch-xfce
W tym repozytorium znajdziesz skrypt pakietów do podstawowej instalacji Arch Linux xfce, uczyń skrypt wykonywalnym za pomocą chmod +x nazwa_skryptu, a następnie uruchom za pomocą ./nazwa_skryptu. Skrypt do podstawowej instalacji na MBR. Pamiętaj, że pierwsza część instalacji Arch Linux jest ręczna, to znaczy, że będziesz musiał samodzielnie podzielić, sformatować i zamontować dysk. 
1 Zainstaluj pakiety podstawowe pacstrap /mnt base linux linux-firmware git vim (lub nano) intel-ucode (lub amd-ucode). 
2  Wygeneruj plik FSTAB za pomocą genfstab -U /mnt >> /mnt/etc/fstab
3 Chrootuj za pomocą arch-chroot /mnt

4 Zainstaluj grub komendą pacman -S grub
za x wpisz dysk na którym instalujesz grub
grub-install /dev/sdx   
grub-mkconfig -o /boot/gurb/grub.cfg
 
