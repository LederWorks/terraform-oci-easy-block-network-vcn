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

  #Subnets
  subnet_list = {
    for subnet in oci_core_subnet.subnet :
    subnet.key => {
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