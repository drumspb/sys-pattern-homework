# provider.tf
terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.85"  # Пример версии, укажите актуальную
    }
  }
}

provider "yandex" {
  service_account_key_file = "${path.module}/key.json"
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = "ru-central1-a"
}