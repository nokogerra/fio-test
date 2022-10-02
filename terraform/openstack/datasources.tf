data "openstack_networking_network_v2" "external_net" {
  name = var.os_external_net_name
}

data "openstack_images_image_v2" "linux_image" {
  name        = var.os_image_name
  most_recent = true
}

data template_file "userdata_ctrl" {

  template = file("${path.module}/userdata_ctrl.yml")
  vars = {
#    ci_ipaddr = "${var.os_fio_ctrl_ip}"
    ci_hostname = "${var.os_fio_ctrl_name}"
    ci_instance_id = "${var.os_fio_ctrl_name}"
#    ci_gw = "${var.os_fio_ctrl_gw}"
#    ci_dns = "${var.os_dns}"
  }
}