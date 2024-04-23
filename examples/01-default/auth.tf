#Providers
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "oci" {
  tenancy_ocid = var.TENANCY_OCID
  user_ocid    = var.USER_OCID
  private_key  = var.PRIVATE_KEY
  fingerprint  = var.FINGERPRINT
  region       = "eu-frankfurt-1"
}

#Versions
terraform {
  required_version = ">=1.3.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.100.0"
    }
    oci = {
      source  = "oracle/oci"
      version = "5.38.0"
    }
  }
}

#Backend
terraform {
  backend "azurerm" {
    resource_group_name  = "rgrp-pde3-it-terratest"
    storage_account_name = "saccpde3itterratest001"
    container_name       = "terratest-github"
    key                  = "easy-block-network-vcn.default.tfstate"
    snapshot             = true
    use_azuread_auth     = true
  }
}
