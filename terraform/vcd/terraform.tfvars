#Provider vars
org_user                        = ""
org_password                    = ""
org_name                        = "akopylov_org"
org_url                         = "https://iaaslab.cloud.mts.ru/api"
org_vdc                         = "akopylov-org-vdc-t"
org_max_retry_timeout           = 1800
org_allow_unverified_ssl        = true

org_edge_gw                     = "akopylov-t1-edge"
org_catalog                     = "akopylov-lab"
template_vm                     = "Ubuntu-20.04-cloud-init"
os_type                         = "ubuntu64Guest"
vapp_network                    = "fio-test-network"
dns                             = "8.8.8.8"
storage_profile                 = "DPLabCompNonSSD"

#FIO controller vars
fio_ctrl_vapp                   = "fio_ctrl"
fio_ctrl_vm                     = "fio-ctrl"
fio_ctrl_ip                     = "10.215.252.50"
fio_ctrl_gw                     = "10.215.252.1"
fio_ctrl_cpus                   = "4"
fio_ctrl_mem                    = "4"

#FIO engine vars
fio_engine_vapp                 = "fio_engine"
fio_engine_gw                   = "10.215.252.1"
fio_engine_cpus                 = "2"
fio_engine_mem                  = "4"
fio_engine_data_disks           = [
                                {
                                size = "20"    
                                },
                                {
                                size = "20"    
                                }
                            ]
fio_engine_vms                  = {
                                fio01 = {
                                    vmname = "fio01"
                                    ipaddr = "10.215.252.51"
                                }
                                fio02 = {
                                    vmname = "fio02"
                                    ipaddr = "10.215.252.52"
                                }
                                fio03 = {
                                    vmname = "fio03"
                                    ipaddr = "10.215.252.53"
                                }
                                fio04 = {
                                    vmname = "fio04"
                                    ipaddr = "10.215.252.54"
                                }
                                fio05 = {
                                    vmname = "fio05"
                                    ipaddr = "10.215.252.55"
                                }
                            }     

                       