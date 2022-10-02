#Provider vars

variable "os_user" {
  type        = string
  description = "OS user name"
  default     = "none"
}

variable "os_tenant" {
  type        = string
  description = "OS tenant name"
  default     = "none"
}

variable "os_password" {
  type        = string
  description = "OS password"
  default     = "none"
}

variable "os_url" {
  type        = string
  description = "OS auth URL (port 5000/v3)"
  default     = "http://fqdn:5000/v3/"
}

variable "os_region" {
  type        = string
  description = "OS region"
  default     = "none"
}

variable "os_router_name" {
  type        = string
  description = "Router name"
  default     = "fio-router"
}

variable "os_external_net_name" {
  type        = string
  description = "External network name"
  default     = "none"
}

variable "os_dns" {
  type    = list(string)
  default = ["8.8.8.8", "8.8.8.4"]
}

variable "os_generic_net_name" {
  type        = string
  description = "Generic network name"
  default     = "generic-net"
}

variable "os_fio_net_name" {
  type        = string
  description = "FIO network name"
  default     = "fio-net"
}

variable "os_fio_cidr" {
  type        = string
  description = "FIO network CIDR"
  default     = "10.215.252.0/24"
}

variable "os_image_name" {
  type        = string
  description = "Ubuntu image"
  default     = "Ubuntu-20.04"
}

variable "os_fio_flavor_name" {
  type        = string
  description = "FIO custom flavor name"
  default     = "fio-flavor"
}

#FIO ctrl vars
variable "os_fio_ctrl_name" {
  type        = string
  description = "FIO controller name"
  default     = "fio-ctrl"
}

variable "os_fio_ctrl_ip" {
  description = "FIO controller VM"
  default = "fio_ctrl"
}

variable "os_fio_ctrl_gw" {
  description = "FIO controller gateway"
  default = "none"  
}

variable "os_fio_engine_vols" {
  type = list(object({
    size            = number
  }))

  description = "VM volumes"
  default     = []
}

variable "os_fio_engine_vms" {
    type = map(object({
        vmname = string
        ipaddr = string
    }))
    default = {}
}