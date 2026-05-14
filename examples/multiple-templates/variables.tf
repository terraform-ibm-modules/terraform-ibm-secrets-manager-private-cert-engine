##############################################################################
# Input Variables
##############################################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "IBM Cloud API key"
  sensitive   = true
}

variable "secrets_manager_guid" {
  type        = string
  description = "GUID of the Secrets Manager instance"
  default     = "52d3ce44-b7c3-4f2b-a9ee-f08001098d5e"
}

variable "region" {
  type        = string
  description = "Region where the Secrets Manager instance is located"
  default     = "us-south"
}

variable "root_ca_name" {
  type        = string
  description = "Name of the Root CA"
  default     = "example-root-ca"
}

variable "root_ca_common_name" {
  type        = string
  description = "Common name for the Root CA"
  default     = "*.cloud.ibm.com"
}

variable "root_ca_max_ttl" {
  type        = string
  description = "Maximum TTL for the Root CA"
  default     = "87600h"
}

variable "intermediate_ca_name" {
  type        = string
  description = "Name of the Intermediate CA"
  default     = "example-intermediate-ca"
}

variable "resource_tags" {
  type        = list(string)
  description = "Optional list of tags to be added to created resources"
  default     = []
}

variable "resource_group" {
  type        = string
  description = "An existing resource group name to use for this example, if unset a new resource group will be created"
  default     = null
}

variable "prefix" {
  type        = string
  description = "Prefix to be added to created resources"
  default     = "private-engine-mul"
}