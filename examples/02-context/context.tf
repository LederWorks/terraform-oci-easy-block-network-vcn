module "context" {
  source = "git::https://github.com/LederWorks/terraform-generic-easy-context.git?ref=v0.6"

  subsidiary  = "candy"
  cloud       = "oci"
  environment = "int"
  region      = "eu-frankfurt-1"
  project     = "form"
  department  = "pd"

  tags = {
    OwnerOU      = "pd"
    OwnerContact = "contact@lederworks.com"
    Sweetness    = "honeypot"
  }

  custom_tags = {
    poc = "vcn"
  }

  #Regions
  azure_regions = module.azure_regions.regions
  oci_regions   = data.oci_identity_regions.regions.regions
}