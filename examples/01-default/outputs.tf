#VCN
output "vcn" {
  value = module.terratest-network-vcn.vcn
}
#Subnets
output "subnets" {
  value = module.terratest-network-vcn.subnets
}
#DNS Resolver
output "dns_resolver" {
  value = module.terratest-network-vcn.dns_resolver
}
