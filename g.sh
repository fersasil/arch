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

printf "Digite: \n[0] - para uefi\n[1] - para legacy: "
read grubOption

# if [[ $aug1 == "and" ]];


if [[ "$opPartitions" == "y" ]]
then
    sudo chmod +x create-partitions.sh
    printf "${partitionName}" | ./create-partitions.sh
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
printf "${swapPartition}\n${filesystemPartition}\n" | source installation.sh


## Copiar os scripts para o sistema recem montado
mkdir /mnt/temp
cp * /mnt/temp

if [[ "$grubOption" == "0" ]]
then
    arch-chroot /mnt ./grub-efi.sh ${efiPartition}
elif [[ "$grubOption" == "1" ]]
    echo "Instalando o grub efi..."
    arch-chroot /mnt ./grub-legacy.sh ${partitionName}


echo "Começando a configurar o sistema"

arch-chroot /mnt ./config.sh $username $password $hostname

arch-chroot /mnt /bin/bash <<EOF
    printf "$dde\n" | ./dde.sh
EOF


# Interface grafica

# arch-chroot /mnt source dde.sh <<END
# $dde
# END