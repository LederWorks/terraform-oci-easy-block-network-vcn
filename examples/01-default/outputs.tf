#VCN
output "vcn" {
  value = module.terratest-network-vcn.vcn
}
output "vcn_name" {
  value = module.terratest-network-vcn.vcn_name
}

#Subnets
output "subnets" {
  value = module.terratest-network-vcn.subnets
}
output "subnet_names" {
  value = module.terratest-network-vcn.subnet_names
}

#DNS Resolver
output "dns_resolver" {
  value = module.terratest-network-vcn.dns_resolver
}
output "dns_resolver_name" {
  value = module.terratest-network-vcn.dns_resolver_name
}

#DNS Resolver Endpoints
output "dns_endpoints" {
  value = module.terratest-network-vcn.dns_endpoints
}
output "dns_endpoint_names" {
  value = module.terratest-network-vcn.dns_endpoint_names
}
