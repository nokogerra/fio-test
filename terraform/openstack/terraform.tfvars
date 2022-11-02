#Provider vars
os_user = "user"
os_password = "password"
os_region = "RegionOne"
os_tenant = "tenant"
os_url = "http://api.fqdn:5000/v3/"
os_router_name = "fio-router"

#Networking vars
os_external_net_name = "ExternalNet-1"
os_generic_net_name = "generic-net"
os_fio_net_name = "fio-net"
os_fio_cidr = "10.215.252.0/24"
os_dns = ["8.8.8.8", "8.8.8.4"]

#Flavor and image
os_image_name = "Ubuntu-20.04"
os_fio_flavor_name = "Main-2-4"

#FIO controller vars
os_fio_ctrl_name = "fio-ctrl"
os_fio_ctrl_ip = "10.215.252.50"
os_fio_ctrl_gw = "10.215.252.1"

#FIO engine vars
os_fio_engine_vols              = [
                                {
                                size = "20"    
                                },
                                {
                                size = "20"    
                                }
                            ]
os_fio_engine_vms               = {
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
#                                fio04 = {
#                                    vmname = "fio04"
#                                    ipaddr = "10.215.252.54"
#                                }
#                                fio05 = {
#                                    vmname = "fio05"
#                                    ipaddr = "10.215.252.55"
#                                }
                            }     