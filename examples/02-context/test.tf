#Module Test with Context module
module "terratest-network-vcn" {
  source = "../../"

  context = module.context.context

  vcn_compartment_id = local.compartment_id
  vcn_name_suffix    = "terratest"
  vcn_cidr_blocks    = ["172.20.0.0/16", "172.21.0.0/16", "172.22.0.0/16"]
  vcn_dns_label      = "terratest"

  vcn_defined_tags = {}

  vcn_freeform_tags = {
    Terraform = "True"
    Context   = "True"
  }

  vcn_subnets = {
    subnet1 = {
      name_suffix = "subnet1"
      cidr_block  = "172.20.0.0/24"
      dns_label   = "snet1"

      freeform_tags = {
        deployment_mode = "terraform"
      }
    }
    subnet2 = {
      name_suffix = "subnet2"
      cidr_block  = "172.20.1.0/24"
      dns_label   = "snet2"

      freeform_tags = {
        poc = "form"
      }
    }
    subnet3 = {
      name_suffix = "subnet3"
      cidr_block  = "172.20.2.0/24"
      dns_label   = "snet3"

      freeform_tags = {
        deployment_mode = "terraform"
        poc             = "form"
      }
    }
  }

  # vcn_dns_manage = true #Default false
}
