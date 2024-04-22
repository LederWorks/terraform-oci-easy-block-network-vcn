#VCN
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
  display_name   = var.vcn_display_name
  defined_tags   = var.vcn_defined_tags
  freeform_tags  = var.vcn_freeform_tags

  #Config
  cidr_blocks = var.vcn_cidr_blocks
  dns_label   = var.vcn_dns_label
}

#Subnets
resource "oci_core_subnet" "subnet" {
  for_each = var.vcn_subnets != {} ? var.vcn_subnets : {}

  vcn_id = oci_core_vcn.vcn.id

  #Timeouts
  timeouts {
    create = coalesce(each.value.timeout_create, var.vcn_timeout_create)
    update = coalesce(each.value.timeout_update, var.vcn_timeout_update)
    delete = coalesce(each.value.timeout_delete, var.vcn_timeout_delete)
  }

  #Common
  compartment_id = coalesce(each.value.compartment_id, oci_core_vcn.vcn.compartment_id)
  display_name   = coalesce(each.value.display_name, "subnet-${each.key}")
  defined_tags   = merge(each.value.defined_tags, oci_core_vcn.vcn.defined_tags)
  freeform_tags  = merge(each.value.freeform_tags, oci_core_vcn.vcn.freeform_tags)

  #Config
  availability_domain        = each.value.availability_domain
  cidr_block                 = each.value.cidr_block
  dhcp_options_id            = each.value.dhcp_options_id
  dns_label                  = coalesce(each.value.dns_label, oci_core_vcn.vcn.dns_label)
  prohibit_internet_ingress  = coalesce(each.value.internet_ingress_disabled, var.vcn_internet_ingress_disabled)
  prohibit_public_ip_on_vnic = coalesce(each.value.public_ip_on_vnic_disabled, var.vcn_public_ip_on_vnic_disabled)
  route_table_id             = each.value.route_table_id #!!!!
  security_list_ids          = each.value.security_list_ids
}