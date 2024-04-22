variable "vcn_compartment_id" {
  type        = string
  description = "The OCID of the compartment in which to create the VCN."
}

variable "vcn_display_name" {
  type        = string
  description = "A user-friendly name. Does not have to be unique, and it's changeable."
}

variable "vcn_cidr_blocks" {
  type        = list(string)
  description = "The list of one or more IPv4 CIDR blocks for the VCN."
}

variable "vcn_dns_label" {
  type        = string
  description = "A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet (for example, bminstance1.subnet123.vcn1.oraclevcn.com). Must be an alphanumeric string that begins with a letter. The value cannot be changed."
}
variable "vcn_defined_tags" {
  type        = map(string)
  description = "Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags."
  default     = {}
}

variable "vcn_freeform_tags" {
  type        = map(string)
  description = "Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}

}