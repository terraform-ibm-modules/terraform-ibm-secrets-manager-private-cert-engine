variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API token this account authenticates to"
  sensitive   = true
}

variable "region" {
  type        = string
  description = "Region of the secrets manager instance"
  default     = "us-south"
}

variable "root_ca_name" {
  type        = string
  description = "Name of the Root CA to create for a private_cert secret engine"
  default     = "root-ca"
}

variable "intermediate_ca_name" {
  type        = string
  description = "Name of the Intermediate CA to create for a private_cert secret engine"
  default     = "intermediate-ca"
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
  default     = "private-engine-test"
}

variable "certificate_templates" {
  type = list(object({
    name                               = string
    max_ttl                            = optional(string, "8760h")
    allow_any_name                     = optional(bool, true)
    allow_bare_domains                 = optional(bool, false)
    allow_glob_domains                 = optional(bool, false)
    allow_ip_sans                      = optional(bool, true)
    allow_subdomains                   = optional(bool, false)
    allowed_domains                    = optional(list(string), [])
    allowed_domains_template           = optional(bool, false)
    allowed_other_sans                 = optional(list(string), [])
    allowed_secret_groups              = optional(string, null)
    allowed_uri_sans                   = optional(list(string), ["example.com/test"])
    basic_constraints_valid_for_non_ca = optional(bool, false)
    client_flag                        = optional(bool, true)
    code_signing_flag                  = optional(bool, false)
    email_protection_flag              = optional(bool, false)
    enforce_hostnames                  = optional(bool, true)
    ext_key_usage                      = optional(list(string), [])
    ext_key_usage_oids                 = optional(list(string), [])
    key_usage                          = optional(list(string), ["DigitalSignature", "KeyAgreement", "KeyEncipherment"])
    policy_identifiers                 = optional(list(string), [])
    require_common_name                = optional(bool, true)
    server_flag                        = optional(bool, true)
    serial_number                      = optional(string, null)
    use_csr_cn                         = optional(bool, true)
    use_csr_sans                       = optional(bool, true)
  }))
  description = "List of certificate templates to create. Each template must have a unique name. You can add up to 10 templates per certificate authority."
  default = [
    {
      name = "my-template"
    }
  ]
}
