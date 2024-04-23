#Dynamic Azure Regions
module "azure_regions" {
  source  = "Azure/regions/azurerm"
  version = "0.6.0"
}
output "azure_regions" {
  value = module.azure_regions.regions
}

#Dynamic OCI Regions
data "oci_identity_regions" "regions" {}
