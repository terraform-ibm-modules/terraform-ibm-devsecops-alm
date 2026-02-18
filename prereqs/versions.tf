terraform {
  required_version = ">= 1.0.0"
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = ">= 1.82.1, < 2.0.0"
    }

    external = {
      source  = "hashicorp/external"
      version = "2.3.3"
    }

    time = {
      source  = "hashicorp/time"
      version = ">= 0.9.1"
    }
  }
}
