resource "vcd_vapp" "fio_ctrl" {
  name                       = var.fio_ctrl_vapp
  metadata                   = {
    Tag                      = "Managed by Terraform"
                            }
}

resource "vcd_vapp_org_network" "fio_ctrl_net" {
  org                        = var.org_name
  vdc                        = var.org_vdc
  vapp_name                  = vcd_vapp.fio_ctrl.name
  # Comment below line to create an Directed existing vApp network
  org_network_name           = var.vapp_network
}

# Create VM
resource "vcd_vapp_vm" "fio_ctrl_vm" {
    vapp_name       = vcd_vapp.fio_ctrl.name
    catalog_name    = data.vcd_catalog.my_cat.name
    template_name   = var.template_vm
    memory          = var.fio_ctrl_mem* 1024
    cpus            = var.fio_ctrl_cpus
    storage_profile = var.storage_profile != "" ? var.storage_profile : null
    computer_name   = var.fio_ctrl_vm
    name            = var.fio_ctrl_vm

#  override_template_disk {
#    size_in_mb  = var.system_disk_size * 1024
#    bus_type    = var.system_disk_bus
#    bus_number  = 0
#    unit_number = 0
#  }
  network {
    type                     = "org"
    name                     = var.vapp_network
    ip_allocation_mode       = "MANUAL"
    adapter_type             = "VMXNET3"
    ip                       = var.fio_ctrl_ip
  }
  customization {
    enabled                    = true
    allow_local_admin_password = false
    auto_generate_password     = false 
  }

  guest_properties = {
    "instance-id"    = var.fio_ctrl_vm
    "hostname"       = var.fio_ctrl_vm
    "user-data"      = "${base64encode(data.template_file.userdata_ctrl.rendered)}"
  }
}

resource "vcd_vapp" "fio_engine" {
  name                       = var.fio_engine_vapp
  metadata                   = {
    Tag                      = "Managed by Terraform"
                            }
}

resource "vcd_vapp_org_network" "fio_engine_net" {
  org                        = var.org_name
  vdc                        = var.org_vdc
  vapp_name                  = vcd_vapp.fio_engine.name
  org_network_name           = var.vapp_network
}

module "engine_vm" {
  for_each = var.fio_engine_vms
  source   = "./engine_vm"
  mod_fio_engine_vapp    = vcd_vapp.fio_engine.name
  mod_catalog            = data.vcd_catalog.my_cat.name
  mod_template_vm        = var.template_vm
  mod_fio_engine_mem     = var.fio_engine_mem
  mod_fio_engine_cpus    = var.fio_engine_cpus
  mod_storage_profile    = var.storage_profile
  mod_vapp_network       = var.vapp_network
  mod_fio_engine_data_disks  = var.fio_engine_data_disks
  mod_dns                = var.dns
  mod_fio_engine_gw      = var.fio_engine_gw
  mod_vmname             = "${each.value.vmname}"
  mod_ipaddr             = "${each.value.ipaddr}"
}