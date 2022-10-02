resource "openstack_networking_router_v2" "fio_router" {
  name                = var.os_router_name
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.external_net.id
}

resource "openstack_networking_network_v2" "generic_net" {
  name = var.os_generic_net_name
  admin_state_up = true
}

resource "openstack_networking_subnet_v2" "fio_net" {
  name            = var.os_fio_net_name
  network_id      = openstack_networking_network_v2.generic_net.id
  cidr = var.os_fio_cidr
  dns_nameservers = var.os_dns
}

resource "openstack_networking_router_interface_v2" "router_interface_1" {
  router_id = openstack_networking_router_v2.fio_router.id
  subnet_id = openstack_networking_subnet_v2.fio_net.id
}

resource "openstack_compute_instance_v2" "fio-ctrl" {
  name        = var.os_fio_ctrl_name
  image_name  = data.openstack_images_image_v2.linux_image.name
  flavor_name = var.os_fio_flavor_name
#  key_pair    = openstack_compute_keypair_v2.user_key.name
  user_data   = "${base64encode(data.template_file.userdata_ctrl.rendered)}"
  network {
    access_network = true
    name = resource.openstack_networking_network_v2.generic_net.name
    fixed_ip_v4 = var.os_fio_ctrl_ip
  }
}

module "engine_vm" {
  for_each = var.os_fio_engine_vms
  source   = "./engine_vm"
  mod_os_image_name      = var.os_image_name
  mod_fio_engine_name    = "${each.value.vmname}"
  mod_fio_flavor_name    = var.os_fio_flavor_name
  mod_fio_network_name   = resource.openstack_networking_network_v2.generic_net.name
  mod_fio_engine_ip      = "${each.value.ipaddr}"
  mod_fio_engine_vols    = var.os_fio_engine_vols
}