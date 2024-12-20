# Initial Setup

## Proxmox Setup

Run post-pve-install
- https://community-scripts.github.io/ProxmoxVE/scripts?id=post-pve-install 

## Tailscale

Add to tailscale
- ``curl -fsSL https://tailscale.com/install.sh | sh``
- ``tailscale up --accept-dns=false --advertise-exit-node --ssh --advertise-routes 10.10.10.0/24``

Enable routing
```
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.d/99-tailscale.conf
sysctl -p /etc/sysctl.d/99-tailscale.conf
NETDEV=$(ip -o route get 8.8.8.8 | cut -f 5 -d " ")
ethtool -K $NETDEV rx-udp-gro-forwarding on rx-gro-list off
```

## Disk setup

Extend vg0 to the remaining space on /dev/md1 and mount ``/mnt/vm_data``

```bash
pvcreate /dev/md1
vgextend vg0 /dev/md1
lvcreate -l 100%FREE -n vm_data vg0
mkfs.ext4 /dev/vg0/vm_data
mkdir /mnt/vm_data
mount /dev/vg0/vm_data /mnt/vm_data
```

Create ``/dev/md1``  and mount to ``/mnt/data``

```
```bash
fdisk /dev/sdc
{create the }
mount /dev/sdc1 /mnt/data
```

Ensure it is added and mounted

```
/dev/mapper/vg0-root      15G  3.5G   11G  26% /
/dev/sdc1                1.8T  276M  1.7T   1% /mnt/data
/dev/mapper/vg0-vm_data  447G   36K  424G   1% /mnt/vm_data
```

Add to ``/etc/fstab``

```
proc /proc proc defaults 0 0
# /dev/md/0
UUID=562c26f1-8e43-4820-b13d-a1e023b322ce /boot ext3 defaults 0 0
# /dev/md/1 belongs to LVM volume group 'vg0'
/dev/mapper/vg0-root  /            ext3    defaults        0 1
/dev/mapper/vg0-swap  swap         swap    defaults        0 0
/dev/mapper/vg0-vm_data /mnt/vm_data ext4 defaults 0 2
/dev/sdc1 /mnt/data ext4 defaults 0 2
```

Reboot the system, run ``lsblk`` to confirm they're mapped after reboot

```
# root @ vm in ~ [13:42:30] 
$ lsblk
NAME              MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
sda                 8:0    0 476.9G  0 disk  
├─sda1              8:1    0     1G  0 part  
│ └─md0             9:0    0  1022M  0 raid1 /boot
└─sda2              8:2    0 475.9G  0 part  
  └─md1             9:1    0 475.8G  0 raid1 
    ├─vg0-root    252:0    0    15G  0 lvm   /
    ├─vg0-swap    252:1    0     6G  0 lvm   [SWAP]
    └─vg0-vm_data 252:2    0 454.8G  0 lvm   /mnt/vm_data
sdb                 8:16   0 476.9G  0 disk  
├─sdb1              8:17   0     1G  0 part  
│ └─md0             9:0    0  1022M  0 raid1 /boot
└─sdb2              8:18   0 475.9G  0 part  
  └─md1             9:1    0 475.8G  0 raid1 
    ├─vg0-root    252:0    0    15G  0 lvm   /
    ├─vg0-swap    252:1    0     6G  0 lvm   [SWAP]
    └─vg0-vm_data 252:2    0 454.8G  0 lvm   /mnt/vm_data
sdc                 8:32   0   1.8T  0 disk  
└─sdc1              8:33   0   1.8T  0 part  /mnt/data
```

Add to Proxmox host
- Login to webui
- Datacenter > Storage > Add > Directory
	- ID: data
	- Directory: /mnt/data
	- Content: disk image, container template, iso image
- Datacenter > Storage > Add > Directory
	- ID: vm_data
	- Directory: /mnt/vm_data
	- Content: disk image, vzdump backup file, container

![[attachments/proxmox-storage.png]]

