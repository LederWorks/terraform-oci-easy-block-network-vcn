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

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.3.6)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>= 3.60.0)

- <a name="requirement_oci"></a> [oci](#requirement\_oci) (>= 5.0.0)

## Providers

The following providers are used by this module:

- <a name="provider_oci"></a> [oci](#provider\_oci) (>= 5.0.0)

## Examples

### Example 1
```hcl
# Module Test
module "terratest-network-vcn" {
  source = "../../"

  vcn_compartment_id = local.compartment_id
  vcn_display_name   = "terratest-vcn"
  vcn_cidr_blocks    = ["172.20.0.0/16", "172.21.0.0/16", "172.22.0.0/16"]
  vcn_dns_label      = "terratest"
  # vcn_defined_tags = {
  #   "CreatedBy" = "Terraform"
  # }
  vcn_freeform_tags = {
    "Terraform" = "True"
  }
}
```

## Resources

The following resources are used by this module:

- [oci_core_vcn.vcn](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_vcn) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_vcn_cidr_blocks"></a> [vcn\_cidr\_blocks](#input\_vcn\_cidr\_blocks)

Description: The list of one or more IPv4 CIDR blocks for the VCN.

Type: `list(string)`

### <a name="input_vcn_compartment_id"></a> [vcn\_compartment\_id](#input\_vcn\_compartment\_id)

Description: The OCID of the compartment in which to create the VCN.

Type: `string`

### <a name="input_vcn_display_name"></a> [vcn\_display\_name](#input\_vcn\_display\_name)

Description: A user-friendly name. Does not have to be unique, and it's changeable.

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

### <a name="input_vcn_freeform_tags"></a> [vcn\_freeform\_tags](#input\_vcn\_freeform\_tags)

Description: Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags.

Type: `map(string)`

Default: `{}`

## Outputs

No outputs.

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