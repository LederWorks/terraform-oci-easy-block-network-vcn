#DNS Resolver Endpoints
locals {
  dns_endpoint_shortname = "dnse"

  dns_endpoint_names = var.context != null && var.vcn_dns_manage ? { for endpoint_key, endpoint in var.vcn_dns_endpoints :
    endpoint_key => lower("${local.dns_endpoint_shortname}-${var.context.short_region}-${var.context.environment}-${var.context.project}-${endpoint.name_suffix}")
  } : {}

  dns_endpoints = var.vcn_dns_manage ? {
    for endpoint_key, endpoint in oci_dns_resolver_endpoint.dns :
    "${endpoint_key}" => {
      ocid               = endpoint.id,
      self               = endpoint.self,
      state              = endpoint.state,
      name               = endpoint.name,
      endpoint_type      = endpoint.endpoint_type,
      compartment_id     = endpoint.compartment_id,
      resolver_id        = endpoint.resolver_id,
      subnet_id          = endpoint.subnet_id,
      scope              = endpoint.scope,
      is_forwarding      = endpoint.is_forwarding,
      forwarding_address = endpoint.forwarding_address,
      is_listening       = endpoint.is_listening,
      listening_address  = endpoint.listening_address,
    }
  } : {}
}

#DNS resolver endpoint resources
resource "oci_dns_resolver_endpoint" "dns" {
  for_each = var.vcn_dns_endpoints != {} && var.vcn_dns_manage ? var.vcn_dns_endpoints : {}

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