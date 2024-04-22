#VCN
output "vcn" {
  value       = local.vcn
  description = "The VCN managed by this module."
}
output "vcn_name" {
  value = local.vcn_name
  description = "FOR DEVELOPMENT"
}

#Subnets
output "subnets" {
  value       = local.subnets
  description = "A map of all the subnets managed by this module."
}
output "subnet_names" {
  value = local.subnet_names
  description = "FOR DEVELOPMENT"
}

#DNS Resolver
output "dns_resolver" {
  value       = local.dns_resolver
  description = "The DNS Resolver managed by this module."
}
output "dns_resolver_name" {
  value = local.dns_resolver_name
  description = "FOR DEVELOPMENT"
}

#DNS Resolver Endpoints
output "dns_endpoints" {
  value       = local.dns_endpoints
  description = "A map of all the DNS Resolver Endpoints managed by this module."
}
