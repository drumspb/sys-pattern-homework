# Домашнее задание к занятию "Безопасность в облачных провайдерах" - `дромашко Кирилл Сергеевич`


## Задание 1. Yandex Cloud   

1. С помощью ключа в KMS необходимо зашифровать содержимое бакета:

 - создать ключ в KMS;
 - с помощью ключа зашифровать содержимое бакета, созданного ранее.

 ```
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
 ```