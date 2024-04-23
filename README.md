<!-- BEGIN_TF_DOCS -->
<!-- markdownlint-disable-file MD033 MD012 -->
# terraform-provider-easy-brick-category-purpose
LederWorks Easy Category Purpose Brick Module

This module were created by [LederWorks](https://lederworks.com) IaC enthusiasts.

## About This Module
This module implements the [SECTION](https://lederworks.com/docs/microsoft-azure/bricks/compute/#section) reference Insight.

## How to Use This Modul
- Ensure Azure credentials are [in place](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#authenticating-to-azure) (e.g. `az login` and `az account set --subscription="SUBSCRIPTION_ID"` on your workstation)
- Owner role or equivalent is required!
- Ensure pre-requisite resources are created.
- Create a Terraform configuration that pulls in this module and specifies values for the required variables.

## Disclaimer / Known Issues
- Disclaimer
- Known Issues

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.6.0)

- <a name="requirement_oci"></a> [oci](#requirement\_oci) (>= 5.0.0)

## Providers

The following providers are used by this module:

- <a name="provider_oci"></a> [oci](#provider\_oci) (>= 5.0.0)

## Examples

### Example 1 - Simple VCN and Subnet setup
```hcl
# Module Test
module "terratest-network-vcn" {
  source = "../../"

  vcn_compartment_id = local.compartment_id
  vcn_display_name   = "terratest-vcn"
  vcn_cidr_blocks    = ["172.20.0.0/16", "172.21.0.0/16", "172.22.0.0/16"]
  vcn_dns_label      = "terratest"

  vcn_defined_tags = {}

  vcn_freeform_tags = {
    "Terraform" = "True"
  }

  vcn_subnets = {
    subnet1 = {
      #Timeouts
      timeout_create = "5m"
      timeout_update = "5m"
      timeout_delete = "5m"

      #Common
      compartment_id = local.compartment_id
      display_name   = "terratest-subnet1"
      defined_tags   = {}
      freeform_tags = {
        "deployment_mode" = "terraform"
      }

      #Config
      # availability_domain        = ""
      cidr_block = "172.20.0.0/24"
      # dhcp_options_id            = ""
      dns_label = "test"
      # internet_ingress_disabled  = false
      # public_ip_on_vnic_disabled = false
      # route_table_id             = ""
      # security_list_ids          = []
    }

    subnet2 = {
      cidr_block = "172.20.1.0/24"
    }
    subnet3 = {
      cidr_block = "172.20.2.0/24"
    }
  }

  vcn_dns_manage = true
}
```

### Example 2 - VCN and Subnet setup with a context module

```hcl
module "context" {
  source = "git::https://github.com/LederWorks/terraform-generic-easy-context.git?ref=v0.5.0"


  subsidiary  = "candy"
  cloud       = "oci"
  environment = "int"
  # region      = "eu-frankfurt-1"
  region  = "westeurope"
  project     = "form"
  department  = "pd"

  tags = {
    OwnerOU      = "pd"
    OwnerContact = "contact@lederworks.com"
    Sweetness    = "honeypot"
  }

  custom_tags = {
    poc = "vcn"
  }
}
```

```hcl
#Test with context module
```

## Resources

The following resources are used by this module:

- [oci_core_subnet.subnet](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_subnet) (resource)
- [oci_core_vcn.vcn](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_vcn) (resource)
- [oci_dns_resolver.dns](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/dns_resolver) (resource)
- [oci_dns_resolver_endpoint.dns](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/dns_resolver_endpoint) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_vcn_cidr_blocks"></a> [vcn\_cidr\_blocks](#input\_vcn\_cidr\_blocks)

Description: The list of one or more IPv4 CIDR blocks for the VCN.

Type: `list(string)`

### <a name="input_vcn_compartment_id"></a> [vcn\_compartment\_id](#input\_vcn\_compartment\_id)

Description: The OCID of the compartment in which to create the VCN.

Type: `string`

### <a name="input_vcn_dns_label"></a> [vcn\_dns\_label](#input\_vcn\_dns\_label)

Description: A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet (for example, bminstance1.subnet123.vcn1.oraclevcn.com). Must be an alphanumeric string that begins with a letter. The value cannot be changed.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_context"></a> [context](#input\_context)

Description: Context Module

Type: `any`

Default: `null`

### <a name="input_vcn_defined_tags"></a> [vcn\_defined\_tags](#input\_vcn\_defined\_tags)

Description: Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags.

Type: `map(string)`

Default: `{}`

### <a name="input_vcn_display_name"></a> [vcn\_display\_name](#input\_vcn\_display\_name)

Description: (Optional) Updatable when var.context is omited. Exclusive to vcn\_name\_suffix. A user-friendly name. Does not have to be unique, and it's changeable.

Type: `string`

Default: `null`

### <a name="input_vcn_dns_attached_view_ids"></a> [vcn\_dns\_attached\_view\_ids](#input\_vcn\_dns\_attached\_view\_ids)

Description: (Optional) (Updatable) The attached views OCIDs. Views are evaluated in order.

Type: `map(string)`

Default: `{}`

### <a name="input_vcn_dns_display_name"></a> [vcn\_dns\_display\_name](#input\_vcn\_dns\_display\_name)

Description: (Optional) Updatable when var.context is omited. Exclusive to vcn\_dns\_name\_suffix. The display name of the resolver.

Type: `string`

Default: `null`

### <a name="input_vcn_dns_endpoints"></a> [vcn\_dns\_endpoints](#input\_vcn\_dns\_endpoints)

Description:   (Optional) (Updatable) The list of DNS resolver endpoints. The maximum number of endpoints allowed is 3. The maximum number of NSGs per endpoint is 5.

Type:

```hcl
map(object({
    name               = string
    subnet_id          = string
    forwarding_enabled = optional(bool, false)
    listening_enabled  = optional(bool, true)
    endpoint_type      = optional(string)
    forwarding_address = optional(string)
    listening_address  = optional(string)
    nsg_ids            = optional(set(string))
  }))
```

Default: `{}`

### <a name="input_vcn_dns_manage"></a> [vcn\_dns\_manage](#input\_vcn\_dns\_manage)

Description: (Optional) Whether to manage the DNS resolver with this module. Defaults to false.

Type: `bool`

Default: `false`

### <a name="input_vcn_dns_name_suffix"></a> [vcn\_dns\_name\_suffix](#input\_vcn\_dns\_name\_suffix)

Description: (Optional) Required when var.context is declared. Exclusive to vcn\_dns\_display\_name. The suffix to append to the DNS Resolver name.

Type: `string`

Default: `null`

### <a name="input_vcn_dns_private_scope_enabled"></a> [vcn\_dns\_private\_scope\_enabled](#input\_vcn\_dns\_private\_scope\_enabled)

Description: (Optional) Whether to create private or public DNS resolvers. Defaults to true.

Type: `bool`

Default: `true`

### <a name="input_vcn_dns_rules"></a> [vcn\_dns\_rules](#input\_vcn\_dns\_rules)

Description:

Type:

```hcl
map(object({
    action                = string #FORWARD ???
    source_addresses      = optional(set(string))
    destination_addresses = set(string)
    domain_names          = optional(set(string))
    source_endpoint_name  = string
  }))
```

Default: `{}`

### <a name="input_vcn_freeform_tags"></a> [vcn\_freeform\_tags](#input\_vcn\_freeform\_tags)

Description: Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags.

Type: `map(string)`

Default: `{}`

### <a name="input_vcn_internet_ingress_disabled"></a> [vcn\_internet\_ingress\_disabled](#input\_vcn\_internet\_ingress\_disabled)

Description: Whether the VCN has internet ingress disabled. Defaults to true.

Type: `bool`

Default: `true`

### <a name="input_vcn_name_suffix"></a> [vcn\_name\_suffix](#input\_vcn\_name\_suffix)

Description: (Optional) Required when var.context is declared. Exclusive to vcn\_display\_name. The suffix to append to the VCN name.

Type: `string`

Default: `null`

### <a name="input_vcn_public_ip_on_vnic_disabled"></a> [vcn\_public\_ip\_on\_vnic\_disabled](#input\_vcn\_public\_ip\_on\_vnic\_disabled)

Description: Whether the VCN has public IP on VNIC disabled. Defaults to true.

Type: `bool`

Default: `true`

### <a name="input_vcn_subnets"></a> [vcn\_subnets](#input\_vcn\_subnets)

Description:   A map of subnets to be created on the VCN. The vcn\_subnets supports the following:

  TIMEOUTS

  timeout\_create (Optional): The amount of time to wait for the subnet to be created. Omitting this attribute will cause the resource to use the default duration of vcn\_timeout\_create variable.  
  timeout\_update (Optional): The amount of time to wait for the subnet to be updated. Omitting this attribute will cause the resource to use the default duration of vcn\_timeout\_update variable.  
  timeout\_delete (Optional): The amount of time to wait for the subnet to be deleted. Omitting this attribute will cause the resource to use the default duration of vcn\_timeout\_delete variable.

  COMMON

  compartment\_id (Optional): The OCID of the compartment in which to create the subnet. The subnet inherits the compartment ID from the VCN if you don't provide a value.  
  display\_name (Optional): A user-friendly name. Does not have to be unique, and it's changeable.  
  defined\_tags (Optional): Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see Resource Tags.  
  freeform\_tags (Optional): Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags.

  CONFIG

  availability\_domain (Optional): The Availability Domain in which the subnet will be created. Omitting this attribute will create a regional subnet.  
  cidr\_block (Required): The CIDR block of the subnet.  
  dhcp\_options\_id (Optional): The OCID of the set of DHCP options the subnet will use. If you don't provide a value, the subnet will use the VCN's default set of DHCP options.  
  dns\_label (Optional): A DNS label for the subnet, used in conjunction with the VNIC's hostname and VCN's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet (for example, bminstance1.subnet123.vcn1.oraclevcn.com). Must be an alphanumeric string that begins with a letter. The value cannot be changed.  
  internet\_ingress\_disabled (Optional): Whether the subnet has internet ingress disabled. Defaults to true.  
  public\_ip\_on\_vnic\_disabled (Optional): Whether the subnet has public IP on VNIC disabled. Defaults to true.  
  route\_table\_id (Optional): The OCID of the route table the subnet will use. If you don't provide a value, the subnet will use the VCN's default route table.  
  security\_list\_ids (Optional): The OCIDs of the security lists the subnet will use. If you don't provide any security list OCIDs, the subnet will use the VCN's default security list. Remember that security lists are associated with the subnet, but the rules are applied to the individual VNICs in the subnet.

Type:

```hcl
map(object({
    #Timeouts
    timeout_create = optional(string)
    timeout_update = optional(string)
    timeout_delete = optional(string)
    #Common
    compartment_id = optional(string)
    display_name   = optional(string)
    defined_tags   = optional(map(string))
    freeform_tags  = optional(map(string))
    #Config
    availability_domain        = optional(string)
    cidr_block                 = string
    dhcp_options_id            = optional(string)
    dns_label                  = optional(string)
    internet_ingress_disabled  = optional(bool, true)
    public_ip_on_vnic_disabled = optional(bool, true)
    route_table_id             = optional(string)
    security_list_ids          = optional(list(string))
  }))
```

Default: `{}`

### <a name="input_vcn_timeout_create"></a> [vcn\_timeout\_create](#input\_vcn\_timeout\_create)

Description: The amount of time to wait for the VCN to be created. Defaults to 10 minutes.

Type: `string`

Default: `"10m"`

### <a name="input_vcn_timeout_delete"></a> [vcn\_timeout\_delete](#input\_vcn\_timeout\_delete)

Description: The amount of time to wait for the VCN to be deleted. Defaults to 10 minutes.

Type: `string`

Default: `"10m"`

### <a name="input_vcn_timeout_update"></a> [vcn\_timeout\_update](#input\_vcn\_timeout\_update)

Description: The amount of time to wait for the VCN to be updated. Defaults to 10 minutes.

Type: `string`

Default: `"10m"`

## Outputs

The following outputs are exported:

### <a name="output_dns_endpoint_names"></a> [dns\_endpoint\_names](#output\_dns\_endpoint\_names)

Description: FOR DEVELOPMENT

### <a name="output_dns_endpoints"></a> [dns\_endpoints](#output\_dns\_endpoints)

Description: A map of all the DNS Resolver Endpoints managed by this module.

### <a name="output_dns_resolver"></a> [dns\_resolver](#output\_dns\_resolver)

Description: The DNS Resolver managed by this module.

### <a name="output_dns_resolver_name"></a> [dns\_resolver\_name](#output\_dns\_resolver\_name)

Description: FOR DEVELOPMENT

### <a name="output_subnet_names"></a> [subnet\_names](#output\_subnet\_names)

Description: FOR DEVELOPMENT

### <a name="output_subnets"></a> [subnets](#output\_subnets)

Description: A map of all the subnets managed by this module.

### <a name="output_vcn"></a> [vcn](#output\_vcn)

Description: The VCN managed by this module.

### <a name="output_vcn_name"></a> [vcn\_name](#output\_vcn\_name)

Description: FOR DEVELOPMENT

<!-- markdownlint-disable-file MD033 MD012 -->
## Contributing

* If you think you've found a bug in the code or you have a question regarding
  the usage of this module, please reach out to us by opening an issue in
  this GitHub repository.
* Contributions to this project are welcome: if you want to add a feature or a
  fix a bug, please do so by opening a Pull Request in this GitHub repository.
  In case of feature contribution, we kindly ask you to open an issue to
  discuss it beforehand.

## License

```text
MIT License

Copyright (c) 2024 LederWorks

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
<!-- END_TF_DOCS -->