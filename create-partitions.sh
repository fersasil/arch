#!/bin/bash  

echo "Enter the partition name: "
read partitionName


{
## Deletar todas as partições
wipefs -a -f $partitionName

## Criar efi partition
sudo gdisk $partitionName <<END
n


+50MB
ef00
w
y

END


## Criar SWAP partition
sudo gdisk $partitionName <<END
n


+4GB
8200
w
y

END


fileSystemSize = ""

## Criar o sistema de arquivos
sudo gdisk $partitionName <<END
n


$fileSystemSize

w
y

END

## Desmontar
sudo umount ${partitionName}1
sudo umount ${partitionName}2
sudo umount ${partitionName}3

} #&> /dev/null

echo "Formatando partições..."

{

## Formatar o disco
sudo mkfs.fat ${partitionName}1
sudo mkswap ${partitionName}2
sudo mkfs.ext4 ${partitionName}3

} #&> /dev/null
