#VCN
# output "name" {
  
# }

#Subnets
output "subnets" {
  value = local.subnet_list
  description = "A map of all the subnets managed by this module."
}
