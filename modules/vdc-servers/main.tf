#
# Local variables 
locals {
  storage_ips             = concat(openstack_compute_instance_v2.lb_instance[*].network[1].fixed_ip_v4, openstack_compute_instance_v2.web_instance[*].network[1].fixed_ip_v4)
}

###
# General
###

resource "openstack_networking_floatingip_v2" "fip" {
  count                   = var.vdc_lb
  pool                    = "public-vdc-1-v2"
}

#
# Create SSH PUB KEY
resource "openstack_compute_keypair_v2" "vdc-key" {
  name                    = "vdc-key"
  public_key              = var.ssh_pub_key
}

#
# Get UUID of image
data "openstack_images_image_v2" "vdc_image" {
  name                    = var.image
  most_recent             = true
}

###
# Load-balancer
###

#
# Create volume
resource "openstack_blockstorage_volume_v2" "lb_volume" {
  count                   = var.vdc_lb
  name                    = format("lb_%d.root", count.index + 1)
  size                    = var.volume_lb
  description             = format("Root volume for Loadbalancer (lb_%d)", count.index + 1)
  image_id                = data.openstack_images_image_v2.vdc_image.id
  availability_zone       = "customer-v2"
}

#
# Create instance
resource "openstack_compute_instance_v2" "lb_instance" {
  count                   = var.vdc_lb
  name                    = format("lb_%d", count.index + 1)
  image_name              = var.image
  flavor_name             = var.flavor_lb
  key_pair                = openstack_compute_keypair_v2.vdc-key.name
  availability_zone       = "customer-v2"
  network {
    name                  = "default-network"
    fixed_ip_v4           = "10.1.1.${count.index + 10 + 1}"
  }
  network {
    name                  = "storage-v2"
  }
  block_device {
    uuid                  = openstack_blockstorage_volume_v2.lb_volume[count.index].id
    source_type           = "volume"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = true
  }
}

#
# Assign floating IP
resource "openstack_compute_floatingip_associate_v2" "lb_fip" {
  count                   = var.vdc_lb
  floating_ip             = openstack_networking_floatingip_v2.fip[count.index].address
  instance_id             = openstack_compute_instance_v2.lb_instance[count.index].id
}

###
# Web-servers
###

#
# Create volume
resource "openstack_blockstorage_volume_v2" "web_volume" {
  count                   = var.vdc_web
  name                    = format("web_%d.root", count.index + 1)
  size                    = var.volume_web
  description             = format("Root volume for Webserver (web_%d)", count.index + 1)
  image_id                = data.openstack_images_image_v2.vdc_image.id
  availability_zone       = "customer-v2"
}

#
# Create instance
resource "openstack_compute_instance_v2" "web_instance" {
  count                   = var.vdc_web
  name                    = format("web_%d", count.index + 1)
  image_name              = var.image
  flavor_name             = var.flavor_web
  key_pair                = openstack_compute_keypair_v2.vdc-key.name
  availability_zone       = "customer-v2"
  network {
    name                  = "default-network"
    fixed_ip_v4           = "10.1.1.${count.index + 20 + 1}"
  }
  network {
    name = "storage-v2"
  }
  block_device {
    uuid                  = openstack_blockstorage_volume_v2.web_volume[count.index].id
    source_type           = "volume"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = true
  }
}

###
# Db-servers
###

#
# Create volume
resource "openstack_blockstorage_volume_v2" "db_volume" {
  count                   = var.vdc_db
  name                    = format("db_%d.root", count.index + 1)
  size                    = var.volume_db
  description             = format("Root volume for DBserver (db_%d)", count.index + 1)
  image_id                = data.openstack_images_image_v2.vdc_image.id
  availability_zone       = "customer-v2"
}

#
# Create instance
resource "openstack_compute_instance_v2" "db_instance" {
  count                   = var.vdc_db
  name                    = format("db_%d", count.index + 1)
  image_name              = var.image
  flavor_name             = var.flavor_db
  key_pair                = openstack_compute_keypair_v2.vdc-key.name
  availability_zone       = "customer-v2"
  network {
    name                  = "default-network"
    fixed_ip_v4           = "10.1.1.${count.index + 30 + 1}"
  }
  block_device {
    uuid                  = openstack_blockstorage_volume_v2.db_volume[count.index].id
    source_type           = "volume"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = true
  }
}
