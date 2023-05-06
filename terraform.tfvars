#
# VDC connect variables
openstack_user_name        = "<change_me>"
openstack_tenant_name      = "<change_me>"
openstack_user_domain_name = "Default"
openstack_password         = "<change_me>"
openstack_auth_url         = "https://cloud.websupport.sk:5000/v3"

#
# VDC VMs variables
vdc_ssh_pub_key            = "<change_me>"
# OS image
vdc_image                  = "Ubuntu 22.04 LTS"
# Number of VMs (minimum is 1/2/3 for HA setup)
vdc_lb                     = 1
vdc_web                    = 3
vdc_db                     = 3
# HW configuration of VM (cpu + ram) // pulic.c4m4 / public.c4m8
vdc_flavor_lb              = "public.c4m4"
vdc_flavor_web             = "public.c4m4"
vdc_flavor_db              = "public.c4m8"
# Size of Root volumes in GB
vdc_volume_lb              = 10
vdc_volume_web             = 10
vdc_volume_db              = 20
