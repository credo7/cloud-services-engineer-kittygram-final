resource "yandex_compute_instance" "kittygram_vm" {
  name        = "kittygram-vm"
  hostname    = "kittygram-vm"
  zone        = var.yc_zone
  platform_id = "standard-v1"

  resources {
    cores         = var.vm_cores       # e.g., 2
    memory        = var.vm_memory      # e.g., 2 (GB)
    core_fraction = var.core_fraction  # e.g., 100 for full, 20 for burstable
  }

  boot_disk {
    initialize_params {
      image_id = var.vm_image_id
      size     = var.vm_disk_size      # e.g., 15 (GB)
      type     = "network-ssd"         # optional, but better for performance
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.kittygram_subnet.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.kittygram_sg.id]
  }

  metadata = {
    ssh-keys  = "ubuntu:${file(var.ssh_pub_key_path)}"
    user-data = file("${path.module}/cloud-init.yaml")
  }

  scheduling_policy {
    preemptible = var.vm_preemptible  # Optional: spot instance savings
  }

  allow_stopping_for_update = true

  lifecycle {
    create_before_destroy = true
  }

}
