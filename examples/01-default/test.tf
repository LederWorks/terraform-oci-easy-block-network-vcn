# Module Test
module "terratest-network-vcn" {
  source = "../../"

  vcn_compartment_id = local.compartment_id
  vcn_display_name   = "terratest-vcn"
  vcn_cidr_blocks    = ["172.20.0.0/16", "172.21.0.0/16"]
  vcn_dns_label      = "terratest"
  # vcn_defined_tags = {
  #   "CreatedBy" = "Terraform"
  # }
  vcn_freeform_tags = {
    "Terraform" = "True"
  }
}
