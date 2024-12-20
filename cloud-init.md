hostname: ${hostname}

# System configuration
timezone: America/New_York
package_update: true
package_upgrade: true

# User configuration
users:
  - name: bl
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /usr/bin/zsh
    ssh_authorized_keys:
      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJdjRk5kPNMk/jMmQiTkBzQcOGgY199YLABaiKu2MfDB bl-m4-mbp

# Package installation
packages:
  - python3
  - python3-pip
  - zsh
  - curl
  - git
  - vim

# Configuration setup
runcmd:
  # Install oh-my-zsh
  - su - bl -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'
  
  # Download dotfiles
  - su - bl -c 'curl -o ~/.zshrc https://raw.githubusercontent.com/blurer/myBS/refs/heads/main/zshrc'
  - su - bl -c 'curl -o ~/.vimrc https://raw.githubusercontent.com/blurer/myBS/refs/heads/main/vimrc'
  - su - bl -c 'curl -o ~/.ssh/authorized_keys https://raw.githubusercontent.com/blurer/myBS/refs/heads/main/authorized_keys'
  - chown bl:bl /home/bl/.ssh/authorized_keys
  - chmod 600 /home/bl/.ssh/authorized_keys

# SSH configuration
ssh_pwauth: false
disable_root: true

ssh:
  install-server: true