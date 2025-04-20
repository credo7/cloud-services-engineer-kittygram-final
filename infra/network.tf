# Создание виртуальной сети (VPC) для приложения Kittygram
resource "yandex_vpc_network" "kittygram_network" {
  name        = var.network_name
  description = "Primary virtual private cloud (VPC) for the Kittygram application infrastructure."
}

# Создание подсети в ранее созданной сети
resource "yandex_vpc_subnet" "kittygram_subnet" {
  name           = var.subnet_name
  network_id     = yandex_vpc_network.kittygram_network.id
  zone           = var.yc_zone
  v4_cidr_blocks = var.subnet_cidr
}

# Настройка Security Group для управления доступом
resource "yandex_vpc_security_group" "kittygram_sg" {
  name        = var.security_group_name
  description = "Defines security rules for Kittygram: allows inbound SSH (22) and HTTP (80) traffic"
  network_id  = yandex_vpc_network.kittygram_network.id

  # Разрешаем подключения по SSH
  ingress {
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = [var.ssh_allowed_cidr]  # Restrict SSH access to trusted sources
  }

  # Разрешаем HTTP соединения
  ingress {
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]  # Public access to HTTP, but HTTPS is recommended for security
  }

  # Исходящие соединения разрешены для всех адресов
  egress {
    protocol       = "ANY"
    from_port      = 0
    to_port        = 65535
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

}
