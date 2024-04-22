check "vcn_state" {
  data "oci_core_vcn" "vcn" {
    # depends_on = [oci_core_vcn.vcn]
    vcn_id     = oci_core_vcn.vcn.id
  }

  assert {
    condition     = data.oci_core_vcn.vcn.state == "AVAILABLE"
    error_message = "The VCN must be in the AVAILABLE state before oci_core_vcn_dns_resolver_association can be created."
  }
}

data "oci_core_vcn_dns_resolver_association" "dns" {
  lifecycle {
    precondition {
      condition = oci_core_vcn.vcn.state == "AVAILABLE"
      error_message = "The VCN must be in the AVAILABLE state to fetch its DNS resolver association data."
    }
  }
  
  vcn_id     = oci_core_vcn.vcn.id
}

resource "oci_dns_resolver" "dns" {
  lifecycle {
    ignore_changes = [defined_tags]
  }

  resolver_id = data.oci_core_vcn_dns_resolver_association.dns.dns_resolver_id

  compartment_id = oci_core_vcn.vcn.compartment_id
  display_name   = var.vcn_dns_display_name
  scope          = var.vcn_dns_private_scope_enabled ? "PRIVATE" : null
  defined_tags   = local.defined_tags
  freeform_tags  = local.freeform_tags

  dynamic "attached_views" {
    for_each = var.vcn_dns_attached_view_ids != {} ? var.vcn_dns_attached_view_ids : {}
    content {
      view_id = attached_views.value
    }
  }

  dynamic "rules" {
    for_each = var.vcn_dns_rules != {} ? var.vcn_dns_rules : {}
    content {
      action                    = rules.value.action
      client_address_conditions = rules.value.source_addresses
      destination_addresses     = rules.value.destination_addresses
      qname_cover_conditions    = rules.value.domain_names
      source_endpoint_name      = rules.value.source_endpoint_name
    }
  }
}

resource "oci_dns_resolver_endpoint" "dns" {
  for_each = var.vcn_dns_endpoints != {} ? var.vcn_dns_endpoints : {}

  name          = each.value.name
  resolver_id   = oci_dns_resolver.dns.id
  subnet_id     = each.value.subnet_id
  scope         = var.vcn_dns_private_scope_enabled ? "PRIVATE" : null
  is_forwarding = each.value.forwarding_enabled
  is_listening  = each.value.listening_enabled

  endpoint_type      = each.value.endpoint_type
  forwarding_address = each.value.forwarding_address
  listening_address  = each.value.listening_address
  nsg_ids            = each.value.nsg_ids

}