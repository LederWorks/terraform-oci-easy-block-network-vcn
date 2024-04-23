module "context" {
  source = "git::https://github.com/LederWorks/terraform-generic-easy-context.git?ref=v0.5.0"


  subsidiary  = "candy"
  cloud       = "oci"
  environment = "int"
  # region      = "eu-frankfurt-1"
  region  = "westeurope"
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
}