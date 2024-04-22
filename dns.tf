data "oci_core_vcn_dns_resolver_association" "dns" {
  vcn_id = oci_core_vcn.vcn.id
}

resource "oci_dns_resolver" "dns" {
  resolver_id = data.oci_core_vcn_dns_resolver_association.dns.dns_resolver_id

  compartment_id = oci_core_vcn.vcn.compartment_id
  display_name   = var.vcn_dns_display_name
  scope          = var.vcn_dns_private_scope_enabled ? "PRIVATE" : null
  defined_tags = local.defined_tags
  freeform_tags = local.freeform_tags

  dynamic "attached_views" {
    for_each = var.vcn_dns_attached_view_ids != {} ? var.vcn_dns_attached_view_ids : {}
    content {
      view_id = attached_views.value
    }
  }

  dynamic "rules" {
      for_each = var.vcn_dns_rules != {} ? var.vcn_dns_rules : {}
      content {
        action = rules.value.action
        client_address_conditions = rules.value.source_addresses
        destination_addresses = rules.value.destination_addresses
        qname_cover_conditions = rules.value.domain_names
        source_endpoint_name = rules.value.source_endpoint_name
      }
    }
}
