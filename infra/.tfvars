# .tfvars file for Yandex Cloud setup

# Authentication and Cloud Configuration
# yc_token            = только в local.tfvars
# yc_cloud_id         = только в local.tfvars
# yc_folder_id        = только в local.tfvars

# Cloud Resources Configuration
yc_zone             = "ru-central1-a"  # You can change this to your desired zone (e.g., 'ru-central1-b')

# Network Configuration
network_name        = "kittygram-network"
subnet_name         = "kittygram-subnet"
subnet_cidr         = ["192.168.10.0/24"]

# Virtual Machine Configuration
vm_image_id         = "fd85m9q2qspfnsv055rh"  # Ubuntu image ID
vm_cores            = 2
vm_memory           = 1
core_fraction       = 20
vm_disk_size        = 10  # Size in GB
vm_preemptible      = false

# Security Configuration
security_group_name = "kittygram-sg"
ssh_allowed_cidr    = "0.0.0.0/0"  # You can specify your IP here, e.g., '192.168.1.1/32' for tighter security

# SSH and Key Configuration
ssh_pub_key_path    = "~/.ssh/id_ed25519.pub"
