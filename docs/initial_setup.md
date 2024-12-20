# Initial Setup

Run post-pve-install
- https://community-scripts.github.io/ProxmoxVE/scripts?id=post-pve-install 

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

