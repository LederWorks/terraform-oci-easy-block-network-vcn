#VCN
output "vcn" {
  value = module.terratest-network-vcn.vcn
}
#Subnets
output "subnets" {
  value = module.terratest-network-vcn.subnets
}
