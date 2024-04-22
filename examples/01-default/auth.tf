#Providers
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "oci" {
  region = "eu-frankfurt-1"
}

#Versions
terraform {
  required_version = ">=1.3.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.99.0"
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
    key                  = "easy-bootstrap.01.tfstate"
    snapshot             = true
    use_azuread_auth     = true
  }
}
