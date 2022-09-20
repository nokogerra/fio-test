#Provider vars
org_user                        = ""
org_password                    = ""
org_name                        = "DR"
org_url                         = "https://iaaslab.cloud.mts.ru/api"
org_vdc                         = "dr-exam-vdc"
org_max_retry_timeout           = 1800
org_allow_unverified_ssl        = true

org_edge_gw                     = "drusov-exam-edge1"
org_catalog                     = "DR-catalogina"
template_vm                     = "focal-server-cloudimg-amd64"
os_type                         = "ubuntu64Guest"
vapp_network                    = "dr-nw01-z01"
dns                             = "8.8.8.8"
storage_profile                 = "DPLabCompSSD"

#FIO controller vars
fio_ctrl_vapp                   = "fio_ctrl"
fio_ctrl_vm                     = "fio-ctrl"
fio_ctrl_ip                     = "10.20.1.40"
fio_ctrl_gw                     = "10.20.1.1"
fio_ctrl_cpus                   = "4"
fio_ctrl_mem                    = "4"

#FIO engine vars
fio_engine_vapp                 = "fio_engine"
fio_engine_gw                   = "10.20.1.1"
fio_engine_cpus                 = "2"
fio_engine_mem                  = "2"
fio_engine_data_disks           = [
                                {
                                size = "30"    
                                },
                                {
                                size = "20"    
                                }
                            ]
fio_engine_vms                  = {
                                fio01 = {
                                    vmname = "fio01"
                                    ipaddr = "10.20.1.41"
                                }
                                fio02 = {
                                    vmname = "fio02"
                                    ipaddr = "10.20.1.42"
                                }
                                fio03 = {
                                    vmname = "fio03"
                                    ipaddr = "10.20.1.43"
                                }
                            }     

                       