# 1. Сетевая инфраструктура
resource "yandex_vpc_network" "network" {
  name = "lamp-network"
}

resource "yandex_vpc_subnet" "public" {
  name           = "public-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

# 2. Сервисный аккаунт
resource "yandex_iam_service_account" "sa" {
  name        = "lamp-sa"
  description = "Service account for LAMP instance group"
}

resource "yandex_kms_symmetric_key" "bucket_key" {
  name              = "lamp-bucket-key"
  description       = "KMS key for bucket encryption"
  default_algorithm = "AES_256"
  rotation_period   = "8760h" # 1 год
}

# 3. Бакет Object Storage
resource "yandex_storage_bucket" "web_bucket" {
  bucket = "${var.bucket_name}-${formatdate("YYYYMMDD", timestamp())}"
  acl    = "public-read"

    server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.bucket_key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }

  website {
    index_document = "index.html"
  }
}

resource "yandex_storage_object" "web_image" {
  bucket = yandex_storage_bucket.web_bucket.bucket
  key    = "lamp-image.jpg"
  source = "lamp.jpg"
  acl    = "public-read"
}


# 4. Instance Group с LAMP (прерываемые инстансы)
resource "yandex_compute_instance_group" "lamp_group" {
  name               = "lamp-group-preemptible"
  folder_id          = var.yc_folder_id
  service_account_id = yandex_iam_service_account.sa.id

  instance_template {
    platform_id = "standard-v2"
    
    resources {
      cores         = 2
      core_fraction = 5  # 5% vCPU
      memory        = 2  # GB
    }

    scheduling_policy {
      preemptible = true  # Прерываемые инстансы
    }

    boot_disk {
      initialize_params {
        image_id = var.vm_image_id
        size     = 10  # GB
      }
    }

    network_interface {
      network_id = yandex_vpc_network.network.id
      subnet_ids = [yandex_vpc_subnet.public.id]
      nat        = true
    }

    metadata = {
      user-data = <<-EOF
        #cloud-config
        users:
          - name: ${var.vm_username}
            groups: sudo
            shell: /bin/bash
            sudo: ['ALL=(ALL) NOPASSWD:ALL']
            ssh-authorized-keys:
              - ${file(var.ssh_public_key_path)}
        
        packages:
          - apache2
          - mysql-server
          - php
          - php-mysql
          - libapache2-mod-php
        
        runcmd:
          - systemctl enable apache2
          - systemctl start apache2
          - echo "<html><body><h1>LAMP on Yandex Cloud</h1><img src='https://${yandex_storage_bucket.web_bucket.bucket}.storage.yandexcloud.net/${yandex_storage_object.web_image.key}' width='500'></body></html>" > /var/www/html/index.html
      EOF
    }
  }

  scale_policy {
    fixed_scale {
      size = var.instance_count
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {  # Правильное имя блока вместо deployment_policy
    max_unavailable = 1
    max_expansion   = 1
  }

  health_check {
    interval = 30
    timeout  = 5
    http_options {
      port = 80
      path = "/"
    }
  }

  application_load_balancer {
    target_group_name = "lamp-tg"
  }
}

# 5. Сетевой балансировщик
resource "yandex_lb_network_load_balancer" "nlb" {
  name = "lamp-network-lb"

  listener {
    name = "http-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.lamp_tg.id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}

resource "yandex_lb_target_group" "lamp_tg" {
  name      = "lamp-target-group"
  region_id = "ru-central1"

  dynamic "target" {
    for_each = yandex_compute_instance_group.lamp_group.instances
    content {
      subnet_id = yandex_vpc_subnet.public.id
      address   = target.value.network_interface[0].ip_address
    }
  }
}

# 6. Outputs
output "bucket_url" {
  value = "https://${yandex_storage_bucket.web_bucket.bucket}.storage.yandexcloud.net/${yandex_storage_object.web_image.key}"
}

output "load_balancer_ip" {
  value = one([
    for listener in yandex_lb_network_load_balancer.nlb.listener : 
    one([for spec in listener.external_address_spec : spec.address])
  ])
}
output "ssh_connection_command" {
  value = "ssh -i ${replace(var.ssh_public_key_path, ".pub", "")} ${var.vm_username}@<PUBLIC_IP>"
}