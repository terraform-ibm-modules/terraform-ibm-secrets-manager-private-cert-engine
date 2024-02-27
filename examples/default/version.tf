terraform {
  required_version = ">= v1.3.0, <1.7.0"
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "= 1.56.1"
    }
  }
}
