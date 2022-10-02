data "openstack_images_image_v2" "linux_image" {
  name        = var.mod_os_image_name
  most_recent = true
}

data template_file "userdata_engine" {

  template = file("${path.module}/userdata_engine.yml")
  vars = {
    ci_hostname = "${var.mod_fio_engine_name}"
    ci_instance_id = "${var.mod_fio_engine_name}"
  }
}