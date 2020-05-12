#!/bin/bash  

grubPartition=$1

pacman -S grub --noconfirm
grub-install ${partition}
grub-mkconfig -o /boot/grub/grub.cfg