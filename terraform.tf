terraform {

  required_version = ">= 1.3.6"

  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.60.0"
    }

    oci = {
      source  = "oracle/oci"
      version = ">= 5.0.0"
    }
  }
}
