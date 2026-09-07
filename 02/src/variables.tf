###cloud vars


variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "<your_ssh_ed25519_key>"
  description = "ssh-keygen -t ed25519"
}



# Переменные для формирования имени ВМ через интерполяцию
variable "project_prefix" {
  type        = string
  description = "Общий префикс для всех ВМ"
  default     = "netology-develop-platform"
}

variable "role_web" {
  type        = string
  description = "Роль для веб-ВМ"
  default     = "web"
}

variable "role_db" {
  type        = string
  description = "Роль для БД-ВМ"
  default     = "db"
}


variable "test" {
  type = list(map(list(string)))
  description = "Список карт с данными для SSH-подключения"
}
