provider "vcd" {
  user                 = var.org_user
  password             = var.org_password
  org                  = var.org_name
  vdc                  = var.org_vdc
  url                  = var.org_url
  allow_unverified_ssl = var.org_allow_unverified_ssl
  max_retry_timeout    = var.org_max_retry_timeout
}
