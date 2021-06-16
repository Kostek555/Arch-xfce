# Arch-inatall
W tym repozytorium znajdziesz skrypty pakietów do podstawowej instalacji Arch Linux xfce, uczyń skrypt wykonywalnym za pomocą chmod +x nazwa_skryptu, a następnie uruchom za pomocą ./nazwa_skryptu.Skrypt do podstawowej instalacji na MBR/Legacy. Pamiętaj, że pierwsza część instalacji Arch Linux jest ręczna, to znaczy, że będziesz musiał samodzielnie podzielić, sformatować i zamontować dysk. Zainstaluj pakiety podstawowe i upewnij się, że zawiera git, aby móc sklonować repozytorium w chroot.

Sformatuj partycje
Zamontuj pattycje
Zainstaluj pakiety podstawowe w /mnt (pacstrap /mnt base linux linux-firmware git vim (lub nano) intel-ucode (lub amd-ucode))
Wygeneruj plik FSTAB za pomocą genfstab -U /mnt >> /mnt/etc/fstab
Chrootuj za pomocą arch-chroot /mnt
Pobierz repozytorium git .

