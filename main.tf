#VCN

resource "oci_core_vcn" "vcn" {
  compartment_id = var.vcn_compartment_id
  display_name   = var.vcn_display_name
  cidr_blocks    = var.vcn_cidr_blocks
  dns_label      = var.vcn_dns_label
  defined_tags   = var.vcn_defined_tags
  freeform_tags  = var.vcn_freeform_tags
}
