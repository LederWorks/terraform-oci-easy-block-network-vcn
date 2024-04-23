module "context" {
  source = "git::https://github.com/LederWorks/terraform-generic-easy-context.git?ref=8671c05fa1162c46cacb25259f6ba251d8819973"


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