terraform {
  required_version = ">= 1.0.0"
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.65.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.2"
    }

    external = {
      source  = "hashicorp/external"
      version = "2.3.3"
    }
  }
}
