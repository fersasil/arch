#!/bin/bash  


echo "Enter grub partition"
read efiPartition

pacman -S grub efibootmgr dosfstools os-prober mtools --noconfirm

mkdir /boot/EFI

mount ${efiPartition} /boot/EFI  #Mount FAT32 EFI partition 
grub-install --target=x86_64-efi  --bootloader-id=grub_uefi --efi-directory=/boot/EFI --recheck

## Create Grub Configuration file
grub-mkconfig -o /boot/grub/grub.cfg
