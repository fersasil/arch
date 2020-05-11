#!/bin/bash  


# echo "Enter grub partition"
# read efiPartition

efiPartition=$1

pacman -S grub efibootmgr dosfstools os-prober mtools --noconfirm

mkdir /boot/efi
mount ${efiPartition} /boot/efi
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi --removable
grub-mkconfig -o /boot/grub/grub.cfg