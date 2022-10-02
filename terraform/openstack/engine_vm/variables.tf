variable "mod_fio_engine_name" {
  type        = string
  description = "FIO engine name"
  default     = "none"
}

variable "mod_fio_flavor_name" {
  type        = string
  description = "Flavor name"
  default     = "none"
}

variable "mod_fio_network_name" {
  type        = string
  description = "FIO engine network name"
  default     = "none"
}

variable "mod_os_image_name" {
  type        = string
  description = "FIO engine network name"
  default     = "none"
}

variable "mod_fio_engine_ip" {
  type        = string
  description = "FIO engine IP address"
  default     = "none"
}

variable "mod_fio_engine_vols" {
  type = list(object({
    size            = number
  }))

  description = "VM volumes"
  default     = []
}

