Build DNS
- bash -c "$(wget -qLO - https://github.com/community-scripts/ProxmoxVE/raw/main/ct/pihole.sh)"

```
  🧩  Using Advanced Settings on node vm
  🖥️  Operating System: debian
  🌟  Version: 12
  📦  Container Type: Unprivileged
  🔐  Root Password: ********
  🆔  Container ID: 100
  🏠  Hostname: pihole
  💾  Disk Size: 2
  🧠  CPU Cores: 1
  🛠️  RAM Size: 512
  🌉  Bridge: vmbr0
  📡  IP Address: 10.10.10.10/24
  🌐  Gateway IP Address: 10.10.10.1
  📡  APT-Cacher IP Address: Default
  🚫  Disable IPv6: yes
  ⚙️  Interface MTU Size: Default
  🔍  DNS Search Domain: dns.lurer.dev
  📡  DNS Server IP Address: 1.1.1.1
  🏷️  Vlan: Default
  🔑  Root SSH Access: yes
  🔍  Verbose Mode: yes
  🚀  Creating a Pihole LXC using the above advanced settings
  ```

Build apt-cacher-ng
- bash -c "$(wget -qLO - https://github.com/community-scripts/ProxmoxVE/raw/main/ct/apt-cacher-ng.sh)"

```
  🧩  Using Advanced Settings on node vm
  🖥️  Operating System: debian
  🌟  Version: 12
  📦  Container Type: Unprivileged
  🔐  Root Password: ********
  🆔  Container ID: 101
  🏠  Hostname: apt-cacher-ng
  💾  Disk Size: 2
  🧠  CPU Cores: 1
  🛠️  RAM Size: 512
  🌉  Bridge: vmbr0
  📡  IP Address: 10.10.10.11/24
  🌐  Gateway IP Address: 10.10.10.1
  📡  APT-Cacher IP Address: 10.10.10.11
  🚫  Disable IPv6: yes
  ⚙️  Interface MTU Size: Default
  🔍  DNS Search Domain: apt-cache.lurer.dev
  📡  DNS Server IP Address: 10.10.10.10
  🏷️  Vlan: Default
  🔑  Root SSH Access: yes
  🔍  Verbose Mode: yes
  🚀  Creating a Apt-Cacher-NG LXC using the above advanced settings
  ```

http://10.10.10.11:3142/acng-report.html

Build nginx proxy manager
- bash -c "$(wget -qLO - https://github.com/community-scripts/ProxmoxVE/raw/main/ct/nginxproxymanager.sh)"
```
  🧩  Using Advanced Settings on node vm
  🖥️  Operating System: debian
  🌟  Version: 12
  📦  Container Type: Unprivileged
  🔐  Root Password: ********
  🆔  Container ID: 102
  🏠  Hostname: nginxproxymanager
  💾  Disk Size: 4
  🧠  CPU Cores: 2
  🛠️  RAM Size: 1024
  🌉  Bridge: vmbr0
  📡  IP Address: 10.10.10.12/24
  🌐  Gateway IP Address: 10.10.10.1
  📡  APT-Cacher IP Address: 10.10.10.11
  🚫  Disable IPv6: yes
  ⚙️  Interface MTU Size: Default
  🔍  DNS Search Domain: proxy.lurer.dev
  📡  DNS Server IP Address: 10.10.10.10
  🏷️  Vlan: Default
  🔑  Root SSH Access: yes
  🔍  Verbose Mode: yes
  🚀  Creating a Nginx Proxy Manager LXC using the above advanced settings
  ```

Build postgresql
- bash -c "$(wget -qLO - https://github.com/community-scripts/ProxmoxVE/raw/main/ct/postgresql.sh)"

```
  🧩  Using Advanced Settings on node vm
  🖥️  Operating System: debian
  🌟  Version: 12
  📦  Container Type: Unprivileged
  🔐  Root Password: ********
  🆔  Container ID: 103
  🏠  Hostname: postgresql
  💾  Disk Size: 4
  🧠  CPU Cores: 1
  🛠️  RAM Size: 1024
  🌉  Bridge: vmbr0
  📡  IP Address: 10.10.10.13/24
  🌐  Gateway IP Address: 10.10.10.1
  📡  APT-Cacher IP Address: 10.10.10.11
  🚫  Disable IPv6: yes
  ⚙️  Interface MTU Size: Default
  🔍  DNS Search Domain: db.lurer.dev
  📡  DNS Server IP Address: 10.10.10.10
  🏷️  Vlan: Default
  🔑  Root SSH Access: yes
  🔍  Verbose Mode: yes
  🚀  Creating a PostgreSQL LXC using the above advanced settings
```

Build pocketbase
- bash -c "$(wget -qLO - https://github.com/community-scripts/ProxmoxVE/raw/main/ct/pocketbase.sh)"

```
  🧩  Using Advanced Settings on node vm
  🖥️  Operating System: debian
  🌟  Version: 12
  📦  Container Type: Unprivileged
  🔐  Root Password: ********
  🆔  Container ID: 104
  🏠  Hostname: pocketbase
  💾  Disk Size: 8
  🧠  CPU Cores: 1
  🛠️  RAM Size: 512
  🌉  Bridge: vmbr0
  📡  IP Address: 10.10.10.14/24
  🌐  Gateway IP Address: 10.10.10.1
  📡  APT-Cacher IP Address: 10.10.10.11
  🚫  Disable IPv6: yes
  ⚙️  Interface MTU Size: Default
  🔍  DNS Search Domain: pocketbase.lurer.dev
  📡  DNS Server IP Address: 10.10.10.10
  🏷️  Vlan: Default
  🔑  Root SSH Access: yes
  🔍  Verbose Mode: yes
  🚀  Creating a Pocketbase LXC using the above advanced settings
  ```
