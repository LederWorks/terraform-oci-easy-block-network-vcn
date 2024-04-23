module "context" {
  source = "git::https://github.com/LederWorks/terraform-generic-easy-context.git?ref=5e3e6954c1f795d99dab861199f42dc091aad53b"


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