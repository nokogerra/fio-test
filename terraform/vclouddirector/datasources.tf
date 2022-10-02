data "vcd_catalog" "my_cat" {
  org                        = var.org_name
  name                       = var.org_catalog
}

data template_file "userdata_ctrl" {

  template = file("${path.module}/userdata_ctrl.yml")
  vars = {
    ci_ipaddr = "${var.fio_ctrl_ip}"
    ci_hostname = "${var.fio_ctrl_vm}"
    ci_instance_id = "${var.fio_ctrl_vm}"
    ci_gw = "${var.fio_ctrl_gw}"
    ci_dns = "${var.dns}"
  }
}
