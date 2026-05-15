##############################################################################
# Common
##############################################################################

variable "secrets_manager_guid" {
  type        = string
  description = "GUID of secrets manager instance to create the secret engine in"
}

variable "region" {
  type        = string
  description = "Region of the secrets manager instance"
}

variable "endpoint_type" {
  type        = string
  description = "The endpoint type to communicate with the provided secrets manager instance. Possible values are `public` or `private`"
  default     = "public"
  validation {
    condition     = contains(["public", "private"], var.endpoint_type)
    error_message = "The specified endpoint_type is not a valid selection!"
  }
}

variable "organizational_unit" {
  type        = list(string)
  description = "Organizational Unit (OU) values to define in the subject field of the resulting certificate"
  default     = null

  validation {
    condition     = var.organizational_unit == null ? true : length(var.organizational_unit) <= 10
    error_message = "length of organizational_unit must be <= 10"
  }

  validation {
    condition = var.organizational_unit == null ? true : alltrue([
      for ou in var.organizational_unit : can(regex("^(.*?)$", ou))
    ])
    error_message = "list items must match regular expression /(.*?)/"
  }
}

variable "organization" {
  type        = list(string)
  description = "Organization (O) values to define in the subject field of the resulting certificate"
  default     = null

  validation {
    condition     = var.organization == null ? true : length(var.organization) <= 10
    error_message = "length of organization must be <= 10"
  }

  validation {
    condition = var.organization == null ? true : alltrue([
      for o in var.organization : can(regex("^(.*?)$", o))
    ])
    error_message = "list items must match regular expression /(.*?)/"
  }
}

variable "country" {
  type        = list(string)
  description = "Country (C) values to define in the subject field of the resulting certificate"
  default     = null

  validation {
    condition     = var.country == null ? true : length(var.country) <= 10
    error_message = "length of country must be <= 10"
  }

  validation {
    condition = var.country == null ? true : alltrue([
      for c in var.country : can(regex("^(.*?)$", c))
    ])
    error_message = "list items must match regular expression /(.*?)/"
  }
}

variable "locality" {
  type        = list(string)
  description = "Locality (L) values to define in the subject field of the resulting certificate"
  default     = null

  validation {
    condition     = var.locality == null ? true : length(var.locality) <= 10
    error_message = "length of locality must be <= 10"
  }

  validation {
    condition = var.locality == null ? true : alltrue([
      for l in var.locality : can(regex("^(.*?)$", l))
    ])
    error_message = "list items must match regular expression /(.*?)/"
  }
}

variable "province" {
  type        = list(string)
  description = "Province (ST) values to define in the subject field of the resulting certificate"
  default     = null

  validation {
    condition     = var.province == null ? true : length(var.province) <= 10
    error_message = "length of province must be <= 10"
  }

  validation {
    condition = var.province == null ? true : alltrue([
      for st in var.province : can(regex("^(.*?)$", st))
    ])
    error_message = "list items must match regular expression /(.*?)/"
  }
}

variable "street_address" {
  type        = list(string)
  description = "Street Address values in the subject field of the resulting certificate"
  default     = null

  validation {
    condition     = var.street_address == null ? true : length(var.street_address) <= 10
    error_message = "length of street_address must be <= 10"
  }

  validation {
    condition = var.street_address == null ? true : alltrue([
      for s in var.street_address : can(regex("^(.*?)$", s))
    ])
    error_message = "list items must match regular expression /(.*?)/"
  }
}

variable "postal_code" {
  type        = list(string)
  description = "Street Address values in the subject field of the resulting certificate"
  default     = null

  validation {
    condition     = var.postal_code == null ? true : length(var.postal_code) <= 10
    error_message = "length of postal_code must be <= 10"
  }

  validation {
    condition = var.postal_code == null ? true : alltrue([
      for p in var.postal_code : can(regex("^(.*?)$", p))
    ])
    error_message = "list items must match regular expression /(.*?)/"
  }
}

variable "other_sans" {
  type        = list(string)
  description = "The custom Object Identifier (OID) or UTF8-string Subject Alternative Names (SANs) to define for the CA certificate. The alternative names must match the values that are specified in the 'allowed_other_sans' field in the associated certificate template"
  default     = null

  validation {
    condition     = var.other_sans == null ? true : length(var.other_sans) <= 100
    error_message = "length of other_sans must be <= 100"
  }

  validation {
    condition = var.other_sans == null ? true : alltrue([
      for other_san in var.other_sans : can(regex("^(.*?)$", other_san))
    ])
    error_message = "list items must match regular expression /(.*?)/"
  }
}

variable "ip_sans" {
  type        = string
  description = "IP Subject Alternative Names (SANs) to define for the CA certificate, in a comma-delimited list"
  default     = null

  validation {
    condition     = var.ip_sans == null ? true : length(var.ip_sans) >= 2 && length(var.ip_sans) <= 2048
    error_message = "length of ip_sans must >= 2 and <= 2048"
  }
}

variable "uri_sans" {
  type        = string
  description = "URI Subject Alternative Names (SANs) to define for the CA certificate, in a comma-delimited list"
  default     = null

  validation {
    condition     = var.uri_sans == null ? true : length(var.uri_sans) >= 2 && length(var.uri_sans) <= 2048
    error_message = "length of uri_sans must be >= 2 and <= 2048"
  }
}

variable "return_format" {
  type        = string
  description = "Format of the returned data"
  default     = "pem"
  validation {
    condition     = contains(["pem", "pem_bundle"], var.return_format)
    error_message = "The specified return_format is not valid. Allowed values are: pem, pem_bundle"
  }
}

variable "private_key_format" {
  type        = string
  description = "Format of the generated private key"
  default     = "der"
  validation {
    condition     = contains(["der", "pkcs8"], var.private_key_format)
    error_message = "The specified return_format is not valid. Allowed values are: der, pkcs8"
  }
}

variable "key_type" {
  type        = string
  description = "Type of private key to generate"
  default     = "rsa"
  validation {
    condition     = contains(["rsa", "ec"], var.key_type)
    error_message = "The specified key_type is not valid. Allowed values are: rsa, ec"
  }
}

variable "key_bits" {
  type        = number
  description = "The number of bits for the generated private key. Required for RSA/EC algorithms."
  default     = 2048

  validation {
    condition = (
      (var.key_type == "rsa" && contains([2048, 4096], var.key_bits)) || (var.key_type == "ec" && contains([256, 384, 521], var.key_bits))
    )
    error_message = "key_bits must be one of [2048, 4096] for RSA, or [256, 384, 521] for EC."
  }
}

variable "permitted_dns_domains" {
  type        = list(string)
  description = "Allowed DNS domains or subdomains for the certificates to be signed and issued by the CA certificate"
  default     = null

  validation {
    condition     = var.permitted_dns_domains == null ? true : length(var.permitted_dns_domains) <= 10
    error_message = "length of permitted_dns_domains must be <= 100"
  }

  validation {
    condition = var.permitted_dns_domains == null ? true : alltrue([
      for permitted_dns_domain in var.permitted_dns_domains : can(regex("^(.*?)$", permitted_dns_domain))
    ])
    error_message = "list items must match regular expression /(.*?)/"
  }
}

variable "alt_names" {
  type        = list(string)
  description = "Alternate names for the certificate to be created"
  default     = null

  validation {
    condition     = var.alt_names == null ? true : length(var.alt_names) < 100
    error_message = "length of alt_names must be < 100"
  }

  validation {
    condition = var.alt_names == null ? true : alltrue([
      for alt_name in var.alt_names : can(regex("^(.*?)$", alt_name))
    ])
    error_message = "list items must match regular expression /^(.*?)$/"
  }
}

variable "ttl" {
  type        = string
  description = "Time-to-live (TTL) to assign to a private certificate"
  default     = null
  validation {
    condition     = var.ttl == null ? true : can(regex("^[0-9]+[s,m,h,d]{0,1}$", var.ttl))
    error_message = "ttl must match regular expression /^[0-9]+[s,m,h,d]{0,1}$/"
  }
}

variable "exclude_cn_from_sans" {
  type        = bool
  description = "Set whether the common name is excluded from Subject Alternative Names (SANs). If set to true, the common name is not included in DNS or Email SANs if they apply"
  default     = false
}

##############################################################################
# ROOT CA
##############################################################################

variable "root_ca_name" {
  type        = string
  description = "Name of the Root CA to create for a private_cert secret engine"
  validation {
    condition     = length(var.root_ca_name) >= 2
    error_message = "length of root_ca_name must be >= 2"
  }
}

variable "root_ca_max_ttl" {
  type        = string
  description = "Maximum TTL value for the root CA"
  validation {
    condition     = can(regex("^[0-9]+[s,m,h,d]{0,1}$", var.root_ca_max_ttl))
    error_message = "root_ca_max_ttl must match regular expression /^[0-9]+[s,m,h,d]{0,1}$/"
  }
}

variable "root_ca_common_name" {
  type        = string
  description = "Fully qualified domain name or host domain name for the certificate to be created"

  validation {
    condition     = length(var.root_ca_common_name) >= 4 && length(var.root_ca_common_name) <= 128
    error_message = "length of root_ca_common_name must be >= 4 and <= 128"
  }

  validation {
    condition     = can(regex("(.*?)", var.root_ca_common_name))
    error_message = "root_ca_common_name must match regular expression /(.*?)/"
  }

  validation {
    condition     = var.root_ca_common_name != var.intermediate_ca_common_name
    error_message = "The values for 'root_ca_common_name' and 'intermediate_ca_common_name' must be different."
  }
}

variable "root_ca_crl_expiry" {
  type        = string
  description = "Expiry time for root CA Certificate Revocation List (CRL)"
  default     = null
  validation {
    condition     = var.root_ca_crl_expiry == null ? true : can(regex("^[0-9]+[s,m,h,d]{0,1}$", var.root_ca_crl_expiry))
    error_message = "root_ca_crl_expiry must match regular expression /^[0-9]+[s,m,h,d]{0,1}$/"
  }
}

variable "root_ca_crl_disable" {
  type        = bool
  description = "crl_disable flag for the root CA"
  default     = false
}

variable "root_ca_crl_distribution_points_encoded" {
  type        = bool
  description = "crl_distribution_points_encoded flag for the root CA"
  default     = true
}

variable "root_ca_issuing_certificates_urls_encoded" {
  type        = bool
  description = "issuing_certificates_urls_encoded flag for the root CA"
  default     = true
}

##############################################################################
# Intermediate CA
##############################################################################

variable "intermediate_ca_name" {
  type        = string
  description = "Name of the Intermediate CA to create for a private_cert secret engine"
}

variable "intermediate_ca_max_ttl" {
  type        = string
  description = " for the intermediate CA"
  default     = "26300h"
}

variable "intermediate_ca_common_name" {
  type        = string
  description = "Common name for the intermediate CA"
  default     = "cloud.ibm.com"
}

variable "intermediate_ca_crl_expiry" {
  type        = string
  description = "crl_expiry for the intermediate CA"
  default     = "72h"
}

variable "intermediate_ca_crl_disable" {
  type        = bool
  description = "crl_disable for the intermediate CA"
  default     = false
}

variable "intermediate_ca_crl_distribution_points_encoded" {
  type        = bool
  description = "crl_distribution_points_encoded flag for the intermediate CA"
  default     = true
}

variable "intermediate_ca_issuing_certificates_urls_encoded" {
  type        = bool
  description = "issuing_certificates_urls_encoded flag for the intermediate CA"
  default     = true
}

variable "intermediate_ca_signing_method" {
  type        = string
  description = "Signing method to use with this certificate authority to generate private certificates"
  default     = "internal"

  validation {
    condition     = contains(["internal", "external"], var.intermediate_ca_signing_method)
    error_message = "specified signing_method is not valid. Allowed values are: internal, external"
  }
}

##############################################################################
# Templates (Multiple)
##############################################################################

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
  description = "List of certificate templates to create. Each template must have a unique name."

  validation {
    condition     = length(var.certificate_templates) > 0 && length(var.certificate_templates) <= 10
    error_message = "Number of certificate templates must be between 1 and 10. You can add up to 10 templates per certificate authority."
  }

  validation {
    condition     = length(var.certificate_templates) == length(distinct([for t in var.certificate_templates : t.name]))
    error_message = "All certificate template names must be unique. Duplicate names found in the list."
  }

  validation {
    condition = alltrue([
      for template in var.certificate_templates : length(template.allowed_domains) <= 100
    ])
    error_message = "length of allowed_domains must be <= 100 for all templates"
  }

  validation {
    condition = alltrue([
      for template in var.certificate_templates : length(template.allowed_other_sans) <= 100
    ])
    error_message = "length of allowed_other_sans must be <= 100 for all templates"
  }

  validation {
    condition = alltrue([
      for template in var.certificate_templates : template.allowed_secret_groups == null ? true : length(template.allowed_secret_groups) >= 2 && length(template.allowed_secret_groups) <= 1024
    ])
    error_message = "length of allowed_secret_groups must be >= 2 and <= 1024 for all templates"
  }

  validation {
    condition = alltrue([
      for template in var.certificate_templates : length(template.allowed_uri_sans) <= 100
    ])
    error_message = "length of allowed_uri_sans must be <= 100 for all templates"
  }

  validation {
    condition = alltrue([
      for template in var.certificate_templates : length(template.ext_key_usage) <= 100
    ])
    error_message = "length of ext_key_usage must be <= 100 for all templates"
  }

  validation {
    condition = alltrue([
      for template in var.certificate_templates : length(template.ext_key_usage_oids) <= 100
    ])
    error_message = "length of ext_key_usage_oids must be <= 100 for all templates"
  }

  validation {
    condition = alltrue([
      for template in var.certificate_templates : length(template.key_usage) <= 100
    ])
    error_message = "length of key_usage must be <= 100 for all templates"
  }

  validation {
    condition = alltrue([
      for template in var.certificate_templates : template.serial_number == null ? true : length(template.serial_number) >= 32 && length(template.serial_number) <= 64
    ])
    error_message = "length of serial_number must be >= 32 and <= 64 for all templates"
  }
}

##############################################################################
