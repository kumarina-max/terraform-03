variable "env_name" {
  type        = string
  description = "Environment and network name"
}

variable "zone" {
  type        = string
  description = "Availability zone"
}

variable "cidr" {
  type        = string
  description = "IPv4 CIDR block for subnet"
}
