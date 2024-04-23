locals {
  #Tags
  freeform_tags = merge(
    var.vcn_freeform_tags,
    {},
    var.context != null ? var.context.oci_freeform_tags : {}
  )

  defined_tags = merge(
    var.vcn_defined_tags,
    {},
    var.context != null ? var.context.oci_defined_tags : {}
  )

}