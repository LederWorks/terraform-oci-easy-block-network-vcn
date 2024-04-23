module "context" {
  source = "git::https://github.com/LederWorks/terraform-generic-easy-context.git?ref=2a97cf2075dc3acca90d2ed3cd6335147d3b2f70"


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
}