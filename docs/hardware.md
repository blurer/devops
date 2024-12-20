Hardware Data:
- CPU: Intel i7-7700
- Memory:  64gb
- Disk /dev/sda: 512 GB (=> 476 GiB) 
- Disk /dev/sdb: 512 GB (=> 476 GiB) 
- Disk /dev/sdc: 2000 GB (=> 1863 GiB) 
- Total capacity 2816 GiB with 3 Disks

Disk Setup:

```
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
