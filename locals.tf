locals {
  #Tags
  freeform_tags = merge(
    var.vcn_freeform_tags,
    {
      creation_mode = "terraform"
      terraform-oci-easy-block-network-vcn = "v0.2.0"
    },
    var.context != null ? var.context.tags : {}
  )

  defined_tags = merge(
    var.vcn_defined_tags,
    {}
  )

}