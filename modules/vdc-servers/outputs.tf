output "public_ips" {
  value = openstack_networking_floatingip_v2.fip[*].address
}

output "storage_ips" {
  value = local.storage_ips
}
