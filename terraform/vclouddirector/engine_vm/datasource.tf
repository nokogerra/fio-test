data template_file "userdata_engine" {

  template = file("${path.module}/userdata_engine.yml")
  vars = {
    ci_ipaddr = "${var.mod_ipaddr}"
    ci_hostname = "${var.mod_vmname}"
    ci_instance_id = "${var.mod_vmname}"
    ci_gw = "${var.mod_fio_engine_gw}"
    ci_dns = "${var.mod_dns}"
  }
}