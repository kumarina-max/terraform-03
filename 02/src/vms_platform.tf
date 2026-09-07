# Переменные для образа и платформы (не заменяются на map)
variable "vm_web_image_family" {
  type        = string
  description = "Семейство образа для веб-ВМ"
  default     = "ubuntu-2004-lts"
}

variable "vm_web_platform_id" {
  type        = string
  description = "Идентификатор платформы для веб-ВМ"
  default     = "standard-v1"
}

variable "vm_web_preemptible" {
  type        = bool
  description = "Флаг, делающий ВМ прерываемой"
  default     = true
}

variable "vm_db_platform_id" {
  type        = string
  description = "Идентификатор платформы для БД-ВМ"
  default     = "standard-v1"
}

variable "vm_db_preemptible" {
  type        = bool
  description = "Флаг, делающий ВМ прерываемой"
  default     = true
}

variable "vm_db_zone" {
  type        = string
  description = "Зона для БД-ВМ"
  default     = "ru-central1-b"
}

# Новая map-переменная для ресурсов (cores, memory, core_fraction)
variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  description = "Ресурсы для каждой ВМ (web, db)"
  default = {
    web = {
      cores         = 2
      memory        = 1
      core_fraction = 5
    }
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
}

# Общая map-переменная для metadata
variable "metadata_common" {
  type        = map(string)
  description = "Общие метаданные для всех ВМ"
  default = {
    "serial-port-enable" = "1"
  }
}

# ============================================================
# СТАРЫЕ ПЕРЕМЕННЫЕ (закомментированы, больше не используются)
# ============================================================

# variable "vm_web_cores" {
#   type        = number
#   default     = 2
# }
# variable "vm_web_memory" {
#   type        = number
#   default     = 1
# }
# variable "vm_web_core_fraction" {
#   type        = number
#   default     = 5
# }
# variable "vm_db_cores" {
#   type        = number
#   default     = 2
# }
# variable "vm_db_memory" {
#   type        = number
#   default     = 2
# }
# variable "vm_db_core_fraction" {
#   type        = number
#   default     = 20
# }
