variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}
variable subnet_id {
  description = "Subnets for modules"
}

variable "resources" {
  description = "set resouces"
  type        = map
  default = {
    cores  = 2
    memory = 2
  }
}

variable "prov_enable" {
  description = "провижионер on/off"
  default     = true
}
