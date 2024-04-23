#VCN
locals {
  vcn_shortname = "vnet"
  vcn_name      = var.context != null ? lower("${local.vcn_shortname}-${var.context.short_region}-${var.context.environment}-${var.context.project}-${var.vcn_name_suffix}") : null

  vcn = {
    ocid             = oci_core_vcn.vcn.id,
    state            = oci_core_vcn.vcn.state,
    cidr_blocks      = oci_core_vcn.vcn.cidr_blocks,
    display_name     = oci_core_vcn.vcn.display_name,
    dns_label        = oci_core_vcn.vcn.dns_label,
    domain_name      = oci_core_vcn.vcn.vcn_domain_name,
    compartment_id   = oci_core_vcn.vcn.compartment_id,
    dhcp_options_id  = oci_core_vcn.vcn.default_dhcp_options_id,
    route_table_id   = oci_core_vcn.vcn.default_route_table_id,
    security_list_id = oci_core_vcn.vcn.default_security_list_id,
    defined_tags     = oci_core_vcn.vcn.defined_tags,
    freeform_tags    = oci_core_vcn.vcn.freeform_tags,
  }
}

resource "oci_core_vcn" "vcn" {
  lifecycle {
    ignore_changes = [defined_tags]
  }

  #Timeouts
  timeouts {
    create = var.vcn_timeout_create
    update = var.vcn_timeout_update
    delete = var.vcn_timeout_delete
  }

  #Common
  compartment_id = var.vcn_compartment_id
  display_name   = var.context != null ? local.vcn_name : var.vcn_display_name
  defined_tags   = local.defined_tags
  freeform_tags  = local.freeform_tags

  #Config
  cidr_blocks = var.vcn_cidr_blocks
  dns_label   = var.vcn_dns_label
}

#Check VCN AVAILABLE state
check "vcn_state" {
  data "oci_core_vcn" "vcn" {
    # depends_on = [oci_core_vcn.vcn]
    vcn_id = oci_core_vcn.vcn.id
  }

  assert {
    condition     = data.oci_core_vcn.vcn.state == "AVAILABLE"
    error_message = "The VCN must be in the AVAILABLE state before oci_core_vcn_dns_resolver_association can be created."
  }
}
