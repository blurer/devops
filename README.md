# Toplology

Terrible network diagram

![terrible_diagram](n25.drawio.png)

# Hardware

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

# VMs

```
| name             | service           | subtype      | virt-type | os       | vcpu | memory | rootfs | data-path                  | data-quota | ip         | internal-dns                | service-dns             | service-role | vrrp | vrrp-ip   | host dns  | service_ip |
| ---------------- | ----------------- | ------------ | --------- | -------- | ---- | ------ | ------ | -------------------------- | ---------- | ---------- | --------------------------- | ----------------------- | ------------ | ---- | --------- | --------- | ---------- |
| db-102           | postgres          | db           | lxc       | debian12 | 0.5  | 1024   | 8      | /mnt/data/postres          | 80         | 10.2.2.102 | db-102.blurer.net           | db.blurer.net           | primary      | 100  | 10.2.2.12 | 10.2.2.10 | 102        |
| db-103           | postgres          | db           | lxc       | debian12 | 0.5  | 1024   | 8      | /mnt/data/postres          | 80         | 10.2.2.103 | db-103.blurer.net           | db.blurer.net           | standby      | 50   | 10.2.2.12 | 10.2.2.10 | 103        |
| dns-100          | pihole            | dns          | lxc       | debian12 | 0.5  | 512    | 8      | /mnt/data/dns-100          | 16         | 10.2.2.100 | dns-100.blurer.net          | dns.blurer.net          | primary      | 100  | 10.2.2.10 | 1.1.1.1   | 100        |
| dns-101          | pihole            | dns          | lxc       | debian12 | 0.5  | 512    | 8      | /mnt/data/dns-101          | 16         | 10.2.2.101 | dns-101.blurer.net          | dns.blurer.net          | secondary    | 50   | 10.2.2.10 | 8.8.8.8   | 101        |
| bind-104         | bind              | bind         | lxc       | debian12 | 0.5  | 512    | 8      | /mnt/data/bind-104         | 16         | 10.2.2.104 | bind-104.blurer.net         | bind.blurer.net         | primary      | 100  | 10.2.2.11 | 10.2.2.10 | 104        |
| bind-105         | bind              | bind         | lxc       | debian12 | 0.5  | 512    | 8      | /mnt/data/bind-105         | 16         | 10.2.2.105 | bind-105.blurer.net         | bind.blurer.net         | secondary    | 50   | 10.2.2.11 | 10.2.2.10 | 105        |
| dash-106         | grafana           | dash         | lxc       | debian12 | 0.5  | 1024   | 8      | /mnt/data/dash-106         | 16         | 10.2.2.106 | dash-106.blurer.net         | dash.blurer.net         | n/a          | n/a  | n/a       | 10.2.2.12 | 106        |
| proxy-107        | nginxproxymanager | proxy        | lxc       | debian12 | 0.5  | 1024   | 8      | /mnt/data/proxy-107        | 16         | 10.2.2.107 | proxy-107.blurer.net        | proxy.blurer.net        | primary      | 100  | 10.2.2.13 | 10.2.2.10 | 107        |
| proxy-108        | nginxproxymanager | proxy        | lxc       | debian12 | 0.5  | 1024   | 8      | /mnt/data/proxy-108        | 16         | 10.2.2.108 | proxy-108.blurer.net        | proxy.blurer.net        | secondary    | 50   | 10.2.2.13 | 10.2.2.10 | 108        |
| k3s-master-109   | k3s               | k3s-master   | lxc       | debian12 | 2    | 2048   | 16     | /mnt/data/k3s-master-109   | 16         | 10.2.2.109 | k3s-master-109.blurer.net   | k3s-master.blurer.net   | n/a          | n/a  | n/a       | 10.2.2.10 | 109        |
| k3s-worker-1-110 | k3s               | k3s-worker-1 | lxc       | debian12 | 1    | 1024   | 8      | /mnt/data/k3s-worker-1-110 | 8          | 10.2.2.110 | k3s-worker-1-110.blurer.net | k3s-worker-1.blurer.net | n/a          | n/a  | n/a       | 10.2.2.10 | 110        |
| k3s-worker-2-111 | k3s               | k3s-worker-2 | lxc       | debian12 | 1    | 1024   | 8      | /mnt/data/k3s-worker-2-111 | 8          | 10.2.2.111 | k3s-worker-2-111.blurer.net | k3s-worker-2.blurer.net | n/a          | n/a  | n/a       | 10.2.2.10 | 111        |
```

# Containers

```
| container name      | hostname                   | host           | function               | ports          |
|---|---|---|---|---|
| TBD|TBD|TBD|TBD|TBD|
```

# To Do:
- [ ] Automate VM creation (terraform)
- [ ] Autommate VM provision (ansible)
- [ ] Grafana
- [ ] Postgres
- [ ] HomeWAN Monitoring (externally)
- [ ] Push stats from home network to svr