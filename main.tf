# ========================
# 1. Сетевая инфраструктура
# ========================
resource "yandex_vpc_network" "network" {
  name = "lamp-network"
}

resource "yandex_vpc_subnet" "public" {
  name           = "public-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

# ========================
# 2. Сервисный аккаунт
# ========================
resource "yandex_iam_service_account" "sa" {
  name        = "lamp-sa"
  description = "Service account for LAMP instance group"
}

# ========================
# 3. KMS-ключ для бакета
# ========================
resource "yandex_kms_symmetric_key" "bucket_key" {
  name              = "lamp-bucket-key"
  description       = "KMS key for bucket encryption"
  default_algorithm = "AES_256"
  rotation_period   = "8760h" # 1 год
}

# ========================
# 4. Object Storage Bucket (с шифрованием)
# ========================
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
    error_document = "error.html"
  }
}

# Тестовый объект (картинка)
resource "yandex_storage_object" "web_image" {
  bucket = yandex_storage_bucket.web_bucket.bucket
  key    = "lamp-image.jpg"
  source = "lamp.jpg"
  acl    = "public-read"
}

# ========================
# 5. Сертификат (HTTP challenge)
# ========================
resource "yandex_cm_certificate" "site_cert" {
  name           = "lamp-site-cert"
  domains        = ["example.com"]   # ⚠️ Замени на свой домен
  challenge_type = "http"
}

# Файл с challenge
resource "local_file" "cert_challenge" {
  filename = "cert-challenge.txt"
  content  = yandex_cm_certificate.site_cert.challenges[0].http_authorization.value
}

# Challenge кладём в bucket
resource "yandex_storage_object" "cert_validation" {
  bucket = yandex_storage_bucket.web_bucket.bucket
  key    = ".well-known/acme-challenge/${yandex_cm_certificate.site_cert.challenges[0].http_authorization.key}"
  source = local_file.cert_challenge.filename
  acl    = "public-read"
}

# ========================
# 6. CDN с сертификатом
# ========================
resource "yandex_cdn_origin_group" "site_group" {
  name = "lamp-site-origin"
  origins {
    source = "${yandex_storage_bucket.web_bucket.bucket}.storage.yandexcloud.net"
  }
}

resource "yandex_cdn_resource" "site_cdn" {
  cname               = "example.com"  # ⚠️ Замени на свой домен
  origin_group_id     = yandex_cdn_origin_group.site_group.id
  secondary_hostnames = ["www.example.com"]

  ssl_certificate {
    certificate_id = yandex_cm_certificate.site_cert.id
  }
}

# ========================
# 7. Outputs
# ========================
output "bucket_url" {
  value = "https://${yandex_storage_bucket.web_bucket.bucket}.storage.yandexcloud.net/${yandex_storage_object.web_image.key}"
}

output "cdn_url" {
  value = "https://example.com" # ⚠️ твой домен
}
