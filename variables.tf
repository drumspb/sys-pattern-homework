# variables.tf
variable "yc_cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "yc_folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "bucket_name" {
  description = "Имя бакета в Object Storage"
  type        = string
  default     = "drum-lamp-bucket"
}

variable "vm_image_id" {
  description = "ID образа для виртуальных машин"
  type        = string
  default     = "fd8vsghfu10ev5gdatkh" # Ubuntu 22.04 LTS
}

variable "instance_count" {
  description = "Количество ВМ в группе"
  type        = number
  default     = 3
}

variable "vm_username" {
  description = "Имя пользователя для доступа по SSH"
  type        = string
  default     = "ubuntu"
}

variable "ssh_public_key_path" {
  description = "Путь к публичному SSH-ключу"
  type        = string
  default     = "~/.ssh/yandex_cloud.pub"
}