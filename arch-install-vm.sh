#!/bin/bash

# --- System Installation ---

# Set hostname
echo "node-1" > /etc/hostname

# Update system clock
timedatectl set-ntp true
timedatectl set-timezone America/New_York

# Partition the disk
sgdisk --zap-all /dev/sda
sgdisk --new=1:0:+2G --typecode=1:ef00 /dev/sda
sgdisk --new=2:0:+16G --typecode=2:8200 /dev/sda
sgdisk --new=3:0:0 --typecode=3:8300 /dev/sda

# Format partitions
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
mkfs.ext4 /dev/sda3

# Mount partitions
mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
swapon /dev/sda2

# Install base system with parallel downloads
pacstrap -i /mnt base base-devel linux linux-firmware vim git curl dhcpcd htop openssh sudo --parallel-downloads=25

# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# --- User Setup ---

# Chroot into the new system
arch-chroot /mnt

# Set up swap
echo "/dev/sda2 none swap defaults 0 0" >> /etc/fstab

# Set a random root password
root_password=$(openssl rand -base64 32)
echo "root:$root_password" | chpasswd
echo "Root password: $root_password"

# Create user 'bl' with random password and passwordless sudo
useradd -m -G wheel bl
bl_password=$(openssl rand -base64 32)
echo "bl:$bl_password" | chpasswd
echo "User 'bl' password: $bl_password"

# Configure sudoers for passwordless sudo for 'bl'
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

# Generate SSH keys for user 'bl'
su - bl -c "ssh-keygen -t ed25519 -C node-1 -f ~/.ssh/id_ed25519 -N ''"

# Add authorized keys for user 'bl'
mkdir -p /home/bl/.ssh
curl https://raw.githubusercontent.com/blurer/myBS/refs/heads/main/authorized_keys >> /home/bl/.ssh/authorized_keys
chown bl:bl /home/bl/.ssh/authorized_keys
chmod 600 /home/bl/.ssh/authorized_keys

# Download and set .bashrc and .vimrc for user 'bl'
curl https://raw.githubusercontent.com/blurer/myBS/refs/heads/main/.bashrc > /home/bl/.bashrc
curl https://raw.githubusercontent.com/blurer/myBS/refs/heads/main/.vimrc > /home/bl/.vimrc
chown bl:bl /home/bl/.bashrc /home/bl/.vimrc

# Enable and start dhcpcd
systemctl enable dhcpcd
systemctl start dhcpcd

# Enable and start sshd
systemctl enable sshd
systemctl start sshd

# Disable root login via SSH
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config

# Exit chroot
exit

# Unmount partitions
umount -R /mnt

# Reboot the system
reboot
