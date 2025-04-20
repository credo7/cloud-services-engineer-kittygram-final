# Authentication and Cloud Configuration
variable "yc_token" {
  description = "API token for accessing Yandex Cloud. Store securely (e.g., as a secret in CI/CD)."
  type        = string
  sensitive   = true  # Hides the token in Terraform output
  default     = ""
}

variable "yc_cloud_id" {
  description = "The Cloud ID in Yandex Cloud for the project."
  type        = string
  default     = ""
}

variable "yc_folder_id" {
  description = "The Folder ID in Yandex Cloud within the cloud."
  type        = string
  default     = ""
}

# Cloud Resources Configuration
variable "yc_zone" {
  description = "Availability zone in Yandex Cloud, e.g., 'ru-central1-a'."
  type        = string
  default     = "ru-central1-a"
  validation {
    condition     = contains(["ru-central1-a", "ru-central1-b", "ru-central1-c"], var.yc_zone)
    error_message = "The availability zone must be one of 'ru-central1-a', 'ru-central1-b', or 'ru-central1-c'."
  }
}

# Network Configuration
variable "network_name" {
  description = "Name for the VPC network."
  type        = string
  default     = "kittygram-network"
}

variable "subnet_name" {
  description = "Name for the subnet."
  type        = string
  default     = "kittygram-subnet"
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet. E.g., '192.168.10.0/24'."
  type        = list(string)
  default     = ["192.168.10.0/24"]
  validation {
    condition     = length(var.subnet_cidr) > 0
    error_message = "At least one CIDR block must be provided for the subnet."
  }
}

# Virtual Machine Configuration
variable "vm_image_id" {
  description = "The image ID for the boot disk of the virtual machine. Find it using 'yc compute image list'."
  type        = string
  default     = "fd85m9q2qspfnsv055rh"
  validation {
    condition     = length(var.vm_image_id) > 0
    error_message = "Image ID must be specified."
  }
}

variable "vm_cores" {
  description = "Number of CPU cores for the virtual machine."
  type        = number
  default     = 2
}

variable "vm_memory" {
  description = "Amount of memory (GB) for the virtual machine."
  type        = number
  default     = 2
}

variable "core_fraction" {
  description = "Core performance fraction (e.g., 100 for full, 20 for burstable)."
  type        = number
  default     = 20 # Повысить до 100 на production
}

variable "vm_disk_size" {
  description = "Size of the VM boot disk in GB."
  type        = number
  default     = 15
}

variable "vm_preemptible" {
  description = "Whether the VM should be preemptible (spot instance)."
  type        = bool
  default     = false
}

# Security Configuration
variable "security_group_name" {
  description = "Name for the security group."
  type        = string
  default     = "kittygram-sg"
}

variable "ssh_allowed_cidr" {
  description = "CIDR from which SSH access is allowed (e.g., '0.0.0.0/0' or your IP)."
  type        = string
  default     = "0.0.0.0/0"
}

# SSH and Key Configuration
variable "ssh_pub_key_path" {
  description = "Path to the public SSH key used to authenticate to the virtual machine."
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
  validation {
    condition     = fileexists(var.ssh_pub_key_path)
    error_message = "The provided SSH public key path does not exist. Ensure the key is at the specified path."
  }
}
