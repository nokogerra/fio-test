# Create VM
resource "openstack_compute_instance_v2" "fio_engine" {
  name        = var.mod_fio_engine_name
  image_name  = data.openstack_images_image_v2.linux_image.name
  flavor_name = var.mod_fio_flavor_name
  user_data   = "${base64encode(data.template_file.userdata_engine.rendered)}"
  network {
    access_network = true
    name = var.mod_fio_network_name
    fixed_ip_v4 = var.mod_fio_engine_ip
  }
}

resource "openstack_blockstorage_volume_v2" "vols" {

  count = length(var.mod_fio_engine_vols)
#  region      = "RegionOne"
#  name        = "volume_1"
#  description = "first test volume"
  size        = var.mod_fio_engine_vols[count.index].size
}

resource "openstack_compute_volume_attach_v2" "attachments" {
  count       = length(var.mod_fio_engine_vols)
  instance_id = "${openstack_compute_instance_v2.fio_engine.id}"
  volume_id   = "${openstack_blockstorage_volume_v2.vols.*.id[count.index]}"
}
