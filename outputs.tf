output "out_floating_ips" {
  value       = module.vdc-servers.public_ips
  description = "LB Public IPs"
}

output "storage_ips" {
  value       = module.vdc-servers.storage_ips
  description = "Storage IPs"
}
