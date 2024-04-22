#VCN
output "vcn" {
  value = local.vcn
  description = "The VCN managed by this module."
}

#Subnets
output "subnets" {
  value = local.subnets
  description = "A map of all the subnets managed by this module."
}
