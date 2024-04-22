locals {
  #Tags
  freeform_tags = merge(
    var.vcn_freeform_tags,
    {}
  )

  defined_tags = merge(
    var.vcn_defined_tags,
    {}
  )

  #VCN
  vcn = {
    ocid = oci_core_vcn.vcn.id,
    state = oci_core_vcn.vcn.state,
    cidr_blocks = oci_core_vcn.vcn.cidr_blocks,
    display_name = oci_core_vcn.vcn.display_name,
    dns_label = oci_core_vcn.vcn.dns_label,
    domain_name = oci_core_vcn.vcn.vcn_domain_name,
    compartment_id = oci_core_vcn.vcn.compartment_id,
    dhcp_options_id = oci_core_vcn.vcn.default_dhcp_options_id,
    route_table_id = oci_core_vcn.vcn.default_route_table_id,
    security_list_id = oci_core_vcn.vcn.default_security_list_id,
    defined_tags = oci_core_vcn.vcn.defined_tags,
    freeform_tags = oci_core_vcn.vcn.freeform_tags,
  }

  #Subnets
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

  #DNS Resolver
  dns_resolver = {
    ocid = oci_dns_resolver.dns.id,
    self = oci_dns_resolver.dns.self,
    state = oci_dns_resolver.dns.state,
    is_protected = oci_dns_resolver.dns.is_protected,
    display_name = oci_dns_resolver.dns.display_name,
    scope = oci_dns_resolver.dns.scope,
    endpoints = oci_dns_resolver.dns.endpoints,
    attached_vcn_id = oci_dns_resolver.dns.attached_vcn_id,
    compartment_id = oci_dns_resolver.dns.compartment_id,
    default_view_id = oci_dns_resolver.dns.default_view_id,
    attached_views = oci_dns_resolver.dns.attached_views,
    rules = oci_dns_resolver.dns.rules,
    defined_tags = oci_dns_resolver.dns.defined_tags,
    freeform_tags = oci_dns_resolver.dns.freeform_tags,
  }

}