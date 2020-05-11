#!/bin/bash  

echo "Enter the username: "
read username

echo "Enter the password: "
read password

echo "Enter the hostname: "
read hostname

pacman -Syu sudo vim networkmanager --noconfirm

location="en_US.UTF-8 UTF-8\npt_BR.UTF-8 UTF-8\n"

echo $hostname > /etc/hostname

printf $location >> /etc/locale.gen

locale-gen

echo LANG=en_US.UTF-8 > /etc/locale.conf

export LANG=en_US.UTF-8

ln -s /usr/share/zoneinfo/Brazil/East /etc/localtime
hwclock --systohc --utc


printf "\n[multilib]\nSigLevel = PackageRequired\nInclude = /etc/pacman.d/mirrorlist\n" >> /etc/pacman.conf


username="g"
password="k1k2k3"

passwd <<END
$password
$password
END

useradd -mg users -G wheel,storage,power -s /bin/bash $username

passwd <<END
$password
$password
END

chage -d 0 $username


systemctl enable NetworkManager

echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

#exit
# umount -a
# telinit 6
