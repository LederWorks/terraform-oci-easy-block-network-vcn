module "context" {
  source = "git::https://github.com/LederWorks/terraform-generic-easy-context.git?ref=3e2b1db8939a5038dea6a9c0811e916c23eafe8a"


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