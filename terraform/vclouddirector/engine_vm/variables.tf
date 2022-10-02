variable "mod_fio_engine_vapp" {
  description = ""
  default = "default"  
}

variable "mod_catalog" {
  description = ""
  default = "default"  
}

variable "mod_template_vm" {
  description = ""
  default = "default"  
}

variable "mod_fio_engine_mem" {
  description = ""
  default = "2"  
}
variable "mod_fio_engine_cpus" {
  description = ""
  default = "default"  
}

variable "mod_storage_profile" {
  description = ""
  default = "default"  
}

variable "mod_vmname" {
  description = ""
  default = "default"  
}

variable "mod_vapp_network" {
  description = ""
  default = "default"  
}

variable "mod_ipaddr" {
  description = ""
  default = "default"  
}

variable "mod_fio_engine_data_disks" {
  type = list(object({
#    mount_point     = string
#    file_system     = string
#    storage_profile = string
    size            = number
  }))

  description = "VM hard drives"
  default     = []
}

variable "mod_dns" {
  description = ""
  default     = "8.8.8.8"
}

variable "mod_fio_engine_gw" {
  description = ""
  default = "default"  
}