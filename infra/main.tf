terraform {
  required_version = ">= 1.3.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.139.0"
    }
  }

  backend "s3" {
    endpoint                     = "https://storage.yandexcloud.net"
    bucket                       = "kitty-bucket"
    region                       = "ru-central1"
    key                          = "tf-state/terraform.tfstate"
    skip_region_validation       = true
    skip_credentials_validation  = true
  }
}

provider "yandex" {
  # service_account_key_file = "key.json"
  token      = var.yc_token
  cloud_id   = var.yc_cloud_id
  folder_id  = var.yc_folder_id
  zone       = var.yc_zone
}
