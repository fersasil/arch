#!/bin/bash  

echo "Enter the partition name: "
read partitionName

echo "Enter the username: "
read username

echo "Enter the password"
read password

echo "Enter the hostname"
read hostname

echo "Erase partitions [y/n]: "
read opPartitions

printf "Digite: \n[0] - instalar i3\n[1] - instalar xfce4: "
read dde

if [$opPartitions == "y"]
then
    sudo chmod +x create-partitions.sh
    ./create-partitions.sh
    efiPartition=${partitionName}1
    swapPartition=${partitionName}2
    filesystemPartition=${partitionName}3

    
else
    echo "Enter the grub efi"
    read efiPartition

    echo "Enter the swap partition"
    read swapPartition

    echo "Enter the filesystem partition"
    read filesystemPartition
fi

## Iniciar instalação do arch
echo "Instalando a base do sistema..."
printf "${swapPartition}\n${filesystemPartition}\n" ./installation

echo "Instalando o grub efi..."
arch-chroot /mnt printf "${efiPartition}\n" | ./grub-efi.sh

echo "Começando a configurar o sistema"

arch-chroot /mnt ./config.sh <<END
$username
$password
$hostname
END

# Interface grafica

arch-chroot /mnt ./dde.sh <<END
$dde
END









