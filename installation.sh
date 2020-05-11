
echo "Enter the swap partition"
read swapPartition

echo "Enter the filesystem partition"
read filesystemPartition

echo ${filesystemPartition} /mnt


{
mount ${filesystemPartition} /mnt
swapon ${swapPartition}


pacstrap /mnt base base-devel linux linux-firmware nano vim
genfstab -U -p /mnt >> /mnt/etc/fstab

} #&> /dev/null