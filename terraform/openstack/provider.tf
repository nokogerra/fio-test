provider "openstack" {
  user_name   = var.os_user
  tenant_name = var.os_tenant
  password    = var.os_password
  auth_url    = var.os_url
  region      = var.os_region
}