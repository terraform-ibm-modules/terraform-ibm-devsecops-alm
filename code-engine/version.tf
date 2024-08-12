
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "=1.67.1"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.1, < 4.0.0"
    }

    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.2"
    }
  }
}
