# Module Test
module "terratest-network-vcn" {
  source = "../../"

  vcn_compartment_id = local.compartment_id
  vcn_display_name   = "terratest-vcn"
  vcn_cidr_blocks    = ["172.20.0.0/16", "172.21.0.0/16", "172.22.0.0/16"]
  vcn_dns_label      = "terratest"

  vcn_defined_tags = {}

  vcn_freeform_tags = {
    "Terraform" = "True"
  }

  vcn_subnets = {
    subnet1 = {
      #Timeouts
      timeout_create = "5m"
      timeout_update = "5m"
      timeout_delete = "5m"

      #Common
      compartment_id = local.compartment_id
      display_name   = "terratest-subnet1"
      defined_tags   = {}
      freeform_tags = {
        "deployment_mode" = "terraform"
      }

      #Config
      # availability_domain        = ""
      cidr_block = "172.20.0.0/24"
      # dhcp_options_id            = ""
      dns_label = "test"
      # internet_ingress_disabled  = false
      # public_ip_on_vnic_disabled = false
      # route_table_id             = ""
      # security_list_ids          = []
    }

    subnet2 = {
      cidr_block = "172.20.1.0/24"
    }
    subnet3 = {
      cidr_block = "172.20.2.0/24"
    }
  }

  vcn_dns_manage = true
}
