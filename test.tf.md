terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://your-proxmox-host:8006/api2/json"
  # pm_api_token_id = "terraform@pam!terraform"
  # pm_api_token_secret = "your-token"
  pm_tls_insecure = true
}

resource "proxmox_lxc" "debian_test" {
  target_node  = "your-node-name"
  hostname     = "debian-test"
  ostemplate   = "local:vztmpl/debian-12-standard_12.0-1_amd64.tar.gz"
  password     = "ChangeMe123"
  unprivileged = true

  // Resource configuration
  cores    = 2
  memory   = 2048
  swap     = 512
  rootfs {
    storage = "local"
    size    = "8G"
  }

  // Network configuration
  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "10.10.10.5/24"
    gw     = "10.10.10.1"
  }

  features {
    nesting = true
  }

  // Cloud-init config
  startup = true
  onboot  = true
  searchdomain = "your-domain"
  ssh_public_keys = <<-EOT
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJdjRk5kPNMk/jMmQiTkBzQcOGgY199YLABaiKu2MfDB bl-m4-mbp
  EOT
}