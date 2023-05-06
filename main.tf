provider "openstack" {
  user_name        = var.openstack_user_name
  tenant_name      = var.openstack_tenant_name
  user_domain_name = var.openstack_user_domain_name
  password         = var.openstack_password
  auth_url         = var.openstack_auth_url
}

module "vdc-servers" {
  source = "./modules/vdc-servers"
  ssh_pub_key = var.vdc_ssh_pub_key
  image = var.vdc_image
  vdc_lb  = var.vdc_lb
  vdc_web = var.vdc_web
  vdc_db  = var.vdc_db
  flavor_lb  = var.vdc_flavor_lb
  flavor_web = var.vdc_flavor_web
  flavor_db  = var.vdc_flavor_db
  volume_lb  = var.vdc_volume_lb
  volume_web = var.vdc_volume_web
  volume_db  = var.vdc_volume_db
}
