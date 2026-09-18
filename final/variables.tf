variable "service_account_key_file" {
  type        = string
  description = "Path to service account authorized key"
}

variable "cloud_id" {
  type        = string
  description = "Yandex Cloud ID"
}

variable "folder_id" {
  type        = string
  description = "Yandex Cloud Folder ID"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Default availability zone"
}

variable "vpc_name" {
  type        = string
  default     = "final-project"
  description = "VPC network name"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.10.0.0/24"]
  description = "Subnet CIDR"
}

variable "vms_ssh_root_key" {
  type        = string
  description = "SSH public key"
}
variable "mysql_cluster_name" {
  type        = string
  default     = "final-project-mysql"
  description = "MySQL cluster name"
}

variable "mysql_database_name" {
  type        = string
  default     = "appdb"
  description = "Application database name"
}

variable "mysql_user_name" {
  type        = string
  default     = "appuser"
  description = "Application database user"
}

