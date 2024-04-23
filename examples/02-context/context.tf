module "context" {
  source = "https://github.com/LederWorks/terraform-generic-easy-context.git?ref=v0.5.0"


  subsidiary  = "candy"
  cloud       = "oci"
  environment = "int"
  region      = "eu-frankfurt-1"
  project     = "form"
  department  = "pd"

  tags = {
    OwnerOU      = "pd"
    OwnerContact = "contact@lederworks.com"
    Sweetnes     = "honeypot"
  }

  custom_tags = {
    poc = "vcn"
  }
}