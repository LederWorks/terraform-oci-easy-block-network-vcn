#DNS Resolver
locals {
  dns_resolver_shortname = "dnsr"
  dns_resolver_name      = var.context != null && var.vcn_dns_manage ? lower("${local.dns_resolver_shortname}-${var.context.short_region}-${var.context.environment}-${var.context.project}-${var.vcn_dns_name_suffix}") : null

  dns_resolver = var.vcn_dns_manage ? {
    ocid            = oci_dns_resolver.dns.id,
    self            = oci_dns_resolver.dns.self,
    state           = oci_dns_resolver.dns.state,
    is_protected    = oci_dns_resolver.dns.is_protected,
    display_name    = oci_dns_resolver.dns.display_name,
    scope           = oci_dns_resolver.dns.scope,
    endpoints       = oci_dns_resolver.dns.endpoints,
    attached_vcn_id = oci_dns_resolver.dns.attached_vcn_id,
    compartment_id  = oci_dns_resolver.dns.compartment_id,
    default_view_id = oci_dns_resolver.dns.default_view_id,
    attached_views  = oci_dns_resolver.dns.attached_views,
    rules           = oci_dns_resolver.dns.rules,
    defined_tags    = oci_dns_resolver.dns.defined_tags,
    freeform_tags   = oci_dns_resolver.dns.freeform_tags,
  } : {}
}

#Data for DNS resolver ID
data "oci_core_vcn_dns_resolver_association" "dns" {
  count = var.vcn_dns_manage ? 1 : 0
  lifecycle {
    precondition {
      condition     = oci_core_vcn.vcn.state == "AVAILABLE"
      error_message = "The VCN must be in the AVAILABLE state to fetch its DNS resolver association data."
    }
  }
  vcn_id = oci_core_vcn.vcn.id
}

#DNS resolver resource
resource "oci_dns_resolver" "dns" {
  count = var.vcn_dns_manage ? 1 : 0
  lifecycle {
    ignore_changes = [defined_tags]
  }

  resolver_id = data.oci_core_vcn_dns_resolver_association.dns.dns_resolver_id

  compartment_id = oci_core_vcn.vcn.compartment_id
  display_name   = var.context != null ? local.dns_resolver_name : var.vcn_dns_display_name
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
