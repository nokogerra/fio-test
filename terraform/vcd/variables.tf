# Provider vars
variable "org_user" {
  default     = "administrator"
  description = "vCD Tenant User"
}

variable "org_password" {
  default     = "password"
  description = "vCD Tenant Password"
}

variable "org_name" {
  default     = "def_org"
  description = "vCD Tenant Org"
}

variable "org_url" {
  default     = "https://vcd.vmcloud.reg.ru/api"
  description = "vCD Tenant URL"
}

variable "org_vdc" {
  default     = "def_org_vdc"
  description = "vCD Tenant VDC"
}

variable "org_max_retry_timeout" {
  description = "Retry Timeout"
  default     = "240"
}

variable "org_allow_unverified_ssl" {
  description = "vCD allow unverified SSL"
  default     = "true"
}

variable "org_edge_gw" {
  description = "vCD edge name"
  default     = "none"
}

variable "org_catalog" {
  description = "vCD Catalog Name"
  default = "DR-catalogina"
}

variable "template_vm" {
  description = "template vm"
  default = "focal-server-cloudimg-amd64"
}

variable "os_type" {
  description = "OS Type"
  default = "ubuntu64Guest"
  
}

variable "vapp_network" {
  description = ""
  default     = "dr-nw01-z01"
}

variable "dns" {
  description = ""
  default     = "8.8.8.8"
}

variable "storage_profile" {
  description = ""
  default     = "DPLabCompSSD"
}

#FIO controller vars
variable "fio_ctrl_vapp" {
  description = "FIO controller vAPP"
  default = "fio_ctrl"
}

variable "fio_ctrl_vm" {
  description = "FIO controller VM"
  default = "fio_ctrl"
}

variable "fio_ctrl_ip" {
  description = "FIO controller VM"
  default = "fio_ctrl"
}

variable "fio_ctrl_gw" {
  description = "FIO controller gateway"
  default = ""  
}

variable "fio_ctrl_cpus" {
  description = ""
  default = "2"  
}

variable "fio_ctrl_mem" {
  description = ""
  default = "2"  
}

#FIO engine vars
variable "fio_engine_vapp" {
  description = ""
  default = "default"  
}

variable "mod_catalog" {
  description = ""
  default = "default"  
}

variable "fio_engine_mem" {
  description = ""
  default = "default"  
}
variable "fio_engine_cpus" {
  description = ""
  default = "default"  
}

variable "fio_engine_gw" {
  description = ""
  default = "default"  
}

variable "mod_vmname" {
  description = ""
  default = "default"  
}

variable "mod_ipaddr" {
  description = ""
  default = "default"  
}

variable "fio_engine_data_disks" {
  type = list(object({
#    mount_point     = string
#    file_system     = string
#    storage_profile = string
    size            = number
  }))

  description = "VM hard drives"
  default     = []
}

variable "fio_engine_vms" {
    type = map(object({
        vmname = string
        ipaddr = string
    }))
    default = {}
}