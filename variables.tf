# $$\    $$\  $$$$$$\  $$\   $$\ 
# $$ |   $$ |$$  __$$\ $$$\  $$ |
# $$ |   $$ |$$ /  \__|$$$$\ $$ |
# \$$\  $$  |$$ |      $$ $$\$$ |
#  \$$\$$  / $$ |      $$ \$$$$ |
#   \$$$  /  $$ |  $$\ $$ |\$$$ |
#    \$  /   \$$$$$$  |$$ | \$$ |
#     \_/     \______/ \__|  \__|

#Common
variable "vcn_compartment_id" {
  type        = string
  description = "(Required) The OCID of the compartment in which to create the VCN."
}

variable "vcn_name_suffix" {
  type        = string
  default     = null
  description = "(Optional) Required when var.context is declared. Exclusive to vcn_display_name. The suffix to append to the VCN name."
}

variable "vcn_display_name" {
  type        = string
  default     = null
  description = "(Optional) Updatable when var.context is omited. Exclusive to vcn_name_suffix. A user-friendly name. Does not have to be unique, and it's changeable."
}

#Tags
variable "vcn_defined_tags" {
  type        = map(string)
  description = "(Optional) Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags."
  default     = {}
}

variable "vcn_freeform_tags" {
  type        = map(string)
  description = "(Optional) Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  default     = {}

}

#Timeouts
variable "vcn_timeout_create" {
  type        = string
  description = "(Optional) The amount of time to wait for the VCN to be created. Defaults to 10 minutes."
  default     = "10m"
}

variable "vcn_timeout_update" {
  type        = string
  description = "(Optional) The amount of time to wait for the VCN to be updated. Defaults to 10 minutes."
  default     = "10m"
}

variable "vcn_timeout_delete" {
  type        = string
  description = "(Optional) The amount of time to wait for the VCN to be deleted. Defaults to 10 minutes."
  default     = "10m"
}

#Config
variable "vcn_cidr_blocks" {
  type        = list(string)
  description = "The list of one or more IPv4 CIDR blocks for the VCN."
}

variable "vcn_dns_label" {
  type        = string
  description = "A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet (for example, bminstance1.subnet123.vcn1.oraclevcn.com). Must be an alphanumeric string that begins with a letter. The value cannot be changed."
}

#  $$$$$$\  $$\   $$\ $$$$$$$\  $$\   $$\ $$$$$$$$\ $$$$$$$$\ 
# $$  __$$\ $$ |  $$ |$$  __$$\ $$$\  $$ |$$  _____|\__$$  __|
# $$ /  \__|$$ |  $$ |$$ |  $$ |$$$$\ $$ |$$ |         $$ |   
# \$$$$$$\  $$ |  $$ |$$$$$$$\ |$$ $$\$$ |$$$$$\       $$ |   
#  \____$$\ $$ |  $$ |$$  __$$\ $$ \$$$$ |$$  __|      $$ |   
# $$\   $$ |$$ |  $$ |$$ |  $$ |$$ |\$$$ |$$ |         $$ |   
# \$$$$$$  |\$$$$$$  |$$$$$$$  |$$ | \$$ |$$$$$$$$\    $$ |   
#  \______/  \______/ \_______/ \__|  \__|\________|   \__|   
#Subnets
variable "vcn_internet_ingress_disabled" {
  type        = bool
  description = "(Optional) Whether the Subnets has internet ingress disabled. Defaults to true."
  default     = true
}

variable "vcn_public_ip_on_vnic_disabled" {
  type        = bool
  description = "(Optional) Whether the Subnets has public IP on VNIC disabled. Defaults to true."
  default     = true
}

variable "vcn_dhcp_options_id" {
  type        = string
  default     = null
  description = "(Optional) The OCID of the set of DHCP options the VCN will use. If you don't provide a value, the VCN will use the default set of DHCP options for the VCN's region."
}

variable "vcn_route_table_id" {
  type = string
  default = null
  description = "(Optional) The OCID of the route table the Subnets will use. If you don't provide a value, the VCN will use the default route table."
}

variable "vcn_security_list_ids" {
  type = list(string)
  default     = []
  description = "(Optional) The OCIDs of the security lists the Subnets will use. If you don't provide any security list OCIDs, the VCN will use the default security list. Remember that security lists are associated with the VCN, but the rules are applied to the individual VNICs in the VCN."
}

variable "vcn_subnets" {
  type = map(object({
    #Timeouts
    timeout_create = optional(string)
    timeout_update = optional(string)
    timeout_delete = optional(string)
    #Common
    compartment_id = optional(string)
    name_suffix    = optional(string)
    display_name   = optional(string)
    defined_tags   = optional(map(string))
    freeform_tags  = optional(map(string))
    #Config
    availability_domain        = optional(string)
    cidr_block                 = string
    dhcp_options_id            = optional(string)
    dns_label                  = optional(string)
    internet_ingress_disabled  = optional(bool)
    public_ip_on_vnic_disabled = optional(bool)
    route_table_id             = optional(string)
    security_list_ids          = optional(list(string), [])
  }))
  default     = {}
  description = <<EOT
  A map of subnets to be created on the VCN. The vcn_subnets supports the following:

  TIMEOUTS

  timeout_create (Optional): The amount of time to wait for the subnet to be created. Omitting this attribute will cause the resource to use the default duration of vcn_timeout_create variable.
  timeout_update (Optional): The amount of time to wait for the subnet to be updated. Omitting this attribute will cause the resource to use the default duration of vcn_timeout_update variable.
  timeout_delete (Optional): The amount of time to wait for the subnet to be deleted. Omitting this attribute will cause the resource to use the default duration of vcn_timeout_delete variable.

  COMMON

  compartment_id (Optional): The OCID of the compartment in which to create the subnet. The subnet inherits the compartment ID from the VCN if you don't provide a value.
  display_name (Optional): A user-friendly name. Does not have to be unique, and it's changeable.
  defined_tags (Optional): Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags.
  freeform_tags (Optional): Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags.

  CONFIG

  availability_domain (Optional): The Availability Domain in which the subnet will be created. Omitting this attribute will create a regional subnet.
  cidr_block (Required): The CIDR block of the subnet.
  dhcp_options_id (Optional): The OCID of the set of DHCP options the subnet will use. If you don't provide a value, the subnet will use the VCN's default set of DHCP options.
  dns_label (Optional): A DNS label for the subnet, used in conjunction with the VNIC's hostname and VCN's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet (for example, bminstance1.subnet123.vcn1.oraclevcn.com). Must be an alphanumeric string that begins with a letter. The value cannot be changed.
  internet_ingress_disabled (Optional): Whether the subnet has internet ingress disabled. Defaults to true.
  public_ip_on_vnic_disabled (Optional): Whether the subnet has public IP on VNIC disabled. Defaults to true.
  route_table_id (Optional): The OCID of the route table the subnet will use. If you don't provide a value, the subnet will use the VCN's default route table.
  security_list_ids (Optional): The OCIDs of the security lists the subnet will use. If you don't provide any security list OCIDs, the subnet will use the VCN's default security list. Remember that security lists are associated with the subnet, but the rules are applied to the individual VNICs in the subnet.

  EOT

  #Validation that dns_label must be unique across all subnets
  validation {
    condition     = length(var.vcn_subnets) == 0 || length(distinct([for subnet in var.vcn_subnets : subnet.dns_label if subnet.dns_label != null])) == length([for subnet in var.vcn_subnets : subnet.dns_label if subnet.dns_label != null])
    error_message = "The dns_label must be unique across all subnets.\n"
  }

}

# $$$$$$$\  $$\   $$\  $$$$$$\  
# $$  __$$\ $$$\  $$ |$$  __$$\ 
# $$ |  $$ |$$$$\ $$ |$$ /  \__|
# $$ |  $$ |$$ $$\$$ |\$$$$$$\  
# $$ |  $$ |$$ \$$$$ | \____$$\ 
# $$ |  $$ |$$ |\$$$ |$$\   $$ |
# $$$$$$$  |$$ | \$$ |\$$$$$$  |
# \_______/ \__|  \__| \______/ 
#DNS
variable "vcn_dns_manage" {
  type        = bool
  default     = false
  description = "(Optional) Whether to manage the DNS resolver with this module. Defaults to false."
}

variable "vcn_dns_name_suffix" {
  type        = string
  default     = null
  description = "(Optional) Required when var.context is declared. Exclusive to vcn_dns_display_name. The suffix to append to the DNS Resolver name."
}
variable "vcn_dns_display_name" {
  type        = string
  default     = null
  description = "(Optional) Updatable when var.context is omited. Exclusive to vcn_dns_name_suffix. The display name of the resolver."
}

variable "vcn_dns_private_scope_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Whether to create private or public DNS resolvers. Defaults to true."
}

variable "vcn_dns_attached_view_ids" {
  type        = map(string)
  default     = {}
  description = "(Optional) (Updatable) The attached views OCIDs. Views are evaluated in order."
}

variable "vcn_dns_endpoints" {
  type = map(object({
    subnet_id          = string
    name               = optional(string)
    name_suffix        = optional(string)
    forwarding_enabled = optional(bool, false)
    listening_enabled  = optional(bool, true)
    endpoint_type      = optional(string)
    forwarding_address = optional(string)
    listening_address  = optional(string)
    nsg_ids            = optional(set(string))
  }))
  default     = {}
  description = <<EOT
  (Optional) (Updatable) The list of DNS resolver endpoints. The maximum number of endpoints allowed is 3. The maximum number of NSGs per endpoint is 5.

  EOT
}


variable "vcn_dns_rules" {
  type = map(object({
    action                = string #FORWARD ???
    source_addresses      = optional(set(string))
    destination_addresses = set(string)
    domain_names          = optional(set(string))
    source_endpoint_name  = string
  }))
  default     = {}
  description = <<EOT

  EOT
}

