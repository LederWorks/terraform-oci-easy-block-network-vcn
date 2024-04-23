#Subnets
locals {
  #Naming
  subnet_shortname = "snet"

  subnet_names = var.context != null ? { for subnet_key, subnet in var.vcn_subnets :
    subnet_key => lower("${local.subnet_shortname}-${var.context.short_region}-${var.context.environment}-${var.context.project}-${subnet.name_suffix}")
  } : {}

  #Output
  subnets = {
    for subnet_key, subnet in oci_core_subnet.subnet :
    "${subnet_key}" => {
      ocid              = subnet.id,
      state             = subnet.state,
      cidr_block        = subnet.cidr_block,
      display_name      = subnet.display_name,
      dns_label         = subnet.dns_label,
      domain_name       = subnet.subnet_domain_name,
      compartment_id    = subnet.compartment_id,
      vcn_id            = subnet.vcn_id,
      gateway_ip        = subnet.virtual_router_ip,
      gateway_mac       = subnet.virtual_router_mac,
      dhcp_options_id   = subnet.dhcp_options_id,
      route_table_id    = subnet.route_table_id,
      security_list_ids = subnet.security_list_ids,
      defined_tags      = subnet.defined_tags,
      freeform_tags     = subnet.freeform_tags,
    }
  }
}

#Resource
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
  dns_label                  = each.value.dns_label
  prohibit_internet_ingress  = coalesce(each.value.internet_ingress_disabled, var.vcn_internet_ingress_disabled)
  prohibit_public_ip_on_vnic = coalesce(each.value.public_ip_on_vnic_disabled, var.vcn_public_ip_on_vnic_disabled)

  #Attachments
  dhcp_options_id   = each.value.dhcp_options_id
  route_table_id    = try(coalesce(each.value.route_table_id, var.vcn_route_table_id), null)
  security_list_ids = length(concat(each.value.security_list_ids, var.vcn_security_list_ids)) > 0 ? concat(each.value.security_list_ids, var.vcn_security_list_ids) : null
}
