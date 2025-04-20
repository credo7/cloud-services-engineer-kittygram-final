output "kittygram_vm_public_ip" {
  value       = yandex_compute_instance.kittygram_vm.network_interface[0].nat_ip_address
  description = "Public IP address"
}
