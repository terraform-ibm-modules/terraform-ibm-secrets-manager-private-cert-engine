##############################################################################
# Common
##############################################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API key used to provision resources."
  sensitive   = true
}

variable "provider_visibility" {
  description = "Set the visibility value for the IBM terraform provider. Supported values are `public`, `private`, `public-and-private`. [Learn more](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/guides/custom-service-endpoints)."
  type        = string
  default     = "private"

  validation {
    condition     = contains(["public", "private", "public-and-private"], var.provider_visibility)
    error_message = "Invalid visibility option. Allowed values are 'public', 'private', or 'public-and-private'."
  }
}

variable "existing_secrets_manager_crn" {
  type        = string
  description = "The CRN of secrets manager instance to create the secret engine in."
  nullable    = false
}

variable "prefix" {
  type        = string
  description = "The prefix to be added to all resources created by this solution. To skip using a prefix, set this value to null or an empty string. The prefix must begin with a lowercase letter and may contain only lowercase letters, digits, and hyphens '-'. It should not exceed 16 characters, must not end with a hyphen('-'), and can not contain consecutive hyphens ('--'). Example: prod-us-south."

  validation {
    condition = (var.prefix == null ? true :
      alltrue([
        can(regex("^[a-z]{0,1}[-a-z0-9]{0,14}[a-z0-9]{0,1}$", var.prefix)),
        length(regexall("^.*--.*", var.prefix)) == 0
      ])
    )
    error_message = "Prefix must begin with a lowercase letter, contain only lowercase letters, numbers, and '-' characters. It must end with a lowercase letter or number, and be 16 or fewer characters long."
  }

  validation {
    # must not exceed 16 characters in length
    condition     = var.prefix == null || var.prefix == "" ? true : length(var.prefix) <= 16
    error_message = "Prefix must not exceed 16 characters."
  }
}

variable "endpoint_type" {
  type        = string
  description = "The endpoint type to communicate with the provided secrets manager instance. Possible values are `public` or `private`"
  default     = "private"
}

variable "organizational_unit" {
  type        = list(string)
  description = "The Organizational Unit (OU) values that are defined in the subject field of the resulting certificate.[Learn More](https://cloud.ibm.com/docs/secrets-manager?topic=secrets-manager-secrets-manager-cli#secrets-manager-configurations-cli)"
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
  description = "The Organization (O) values that are defined in the subject field of the resulting certificate. [Learn More](https://cloud.ibm.com/docs/secrets-manager?topic=secrets-manager-secrets-manager-cli#secrets-manager-configurations-cli)"
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
  description = "The Country (C) values that are defined in the subject field of the resulting certificate. [Learn More](https://cloud.ibm.com/docs/secrets-manager?topic=secrets-manager-secrets-manager-cli#secrets-manager-configurations-cli)"
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
  description = "The Locality (L) values that are defined in the subject field of the resulting certificate. [Learn More](https://cloud.ibm.com/docs/secrets-manager?topic=secrets-manager-secrets-manager-cli#secrets-manager-configurations-cli)"
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
  description = "The Province (ST) values that are defined in the subject field of the resulting certificate. [Learn More](https://cloud.ibm.com/docs/secrets-manager?topic=secrets-manager-secrets-manager-cli#secrets-manager-configurations-cli)"
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
  description = "The Street Address values that are defined in the subject field of the resulting certificate. [Learn More](https://cloud.ibm.com/docs/secrets-manager?topic=secrets-manager-secrets-manager-cli#secrets-manager-configurations-cli)"
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
  description = "The Street Address values that are defined in the subject field of the resulting certificate. [Learn More](https://cloud.ibm.com/docs/secrets-manager?topic=secrets-manager-secrets-manager-cli#secrets-manager-configurations-cli)"
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
  description = "The custom Object Identifier (OID) or UTF8-string Subject Alternative Names (SANs) to define for the CA certificate. The alternative names must match the values that are specified in the 'allowed_other_sans' field in the associated certificate template. [Learn More](https://cloud.ibm.com/docs/secrets-manager?topic=secrets-manager-secrets-manager-cli#secrets-manager-configurations-cli)"
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
  description = "The IP Subject Alternative Names (SANs) to define for the CA certificate, in a comma-delimited list. [Learn More](https://cloud.ibm.com/docs/secrets-manager?topic=secrets-manager-secrets-manager-cli#secrets-manager-configurations-cli)"
  default     = null

  validation {
    condition     = var.ip_sans == null ? true : length(var.ip_sans) >= 2 && length(var.ip_sans) <= 2048
    error_message = "length of ip_sans must >= 2 and <= 2048"
  }
}

variable "uri_sans" {
  type        = string
  description = "The URI Subject Alternative Names (SANs) to define for the CA certificate, in a comma-delimited list. [Learn More](https://cloud.ibm.com/docs/secrets-manager?topic=secrets-manager-secrets-manager-cli#secrets-manager-configurations-cli)"
  default     = null

  validation {
    condition     = var.uri_sans == null ? true : length(var.uri_sans) >= 2 && length(var.uri_sans) <= 2048
    error_message = "length of uri_sans must be >= 2 and <= 2048"
  }
}

variable "return_format" {
  type        = string
  description = "The format in which the data is returned."
  default     = "pem"
  validation {
    condition     = contains(["pem", "pem_bundle"], var.return_format)
    error_message = "The specified return_format is not valid. Allowed values are: pem, pem_bundle"
  }
}

variable "private_key_format" {
  type        = string
  description = "The format in which the private key is generated."
  default     = "der"
  validation {
    condition     = contains(["der", "pkcs8"], var.private_key_format)
    error_message = "The specified return_format is not valid. Allowed values are: der, pkcs8. [Learn More](https://cloud.ibm.com/docs/secrets-manager?topic=secrets-manager-secrets-manager-cli#secrets-manager-configurations-cli)"
  }
}

variable "key_type" {
  type        = string
  description = "The type of private key which is to be generated."
  default     = "rsa"
  validation {
    condition     = contains(["rsa", "ec"], var.key_type)
    error_message = "The specified key_type is not valid. Allowed values are: rsa, ec. [Learn More](https://cloud.ibm.com/docs/secrets-manager?topic=secrets-manager-secrets-manager-cli#secrets-manager-configurations-cli)"
  }
}

variable "permitted_dns_domains" {
  type        = list(string)
  description = "The Allowed DNS domains or subdomains for the certificates which is to be signed and issued by the CA certificate."
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
  description = "The alternate names of the certificate which is to be created."
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
  description = "The Time-to-live (TTL) which is to be assigned to a private certificate. [Learn More](https://cloud.ibm.com/docs/secrets-manager?topic=secrets-manager-secrets-manager-cli#secrets-manager-configurations-cli)"
  default     = null
  validation {
    condition     = var.ttl == null ? true : can(regex("^[0-9]+[s,m,h,d]{0,1}$", var.ttl))
    error_message = "ttl must match regular expression /^[0-9]+[s,m,h,d]{0,1}$/"
  }
}

variable "exclude_cn_from_sans" {
  type        = bool
  description = "Whether the common name is excluded from Subject Alternative Names (SANs). If set to true, the common name is not included in DNS or Email SANs if they apply"
  default     = false
}

##############################################################################
# ROOT CA
##############################################################################

variable "root_ca_name" {
  type        = string
  description = "The name of the Root CA to be created for a private_cert secret engine. If a prefix input variable is specified, it is added to the value in the `<prefix>-value` format."
  default     = "root-ca"

  validation {
    condition     = length(var.root_ca_name) >= 2
    error_message = "length of root_ca_name must be >= 2"
  }
}

variable "root_ca_max_ttl" {
  type        = string
  description = "Maximum TTL value for the root CA"
  default     = "87600h"

  validation {
    condition     = can(regex("^[0-9]+[s,m,h,d]{0,1}$", var.root_ca_max_ttl))
    error_message = "root_ca_max_ttl must match regular expression /^[0-9]+[s,m,h,d]{0,1}$/"
  }
}

variable "root_ca_common_name" {
  type        = string
  description = "Fully qualified domain name or host domain name for the certificate which is to be created"
  default     = "terraform-modules.ibm.com"

  validation {
    condition     = length(var.root_ca_common_name) >= 4 && length(var.root_ca_common_name) <= 128
    error_message = "length of root_ca_common_name must be >= 4 and <= 128"
  }

  validation {
    condition     = can(regex("(.*?)", var.root_ca_common_name))
    error_message = "root_ca_common_name must match regular expression /(.*?)/"
  }
}

variable "root_ca_crl_expiry" {
  type        = string
  description = "The expiry time for root CA Certificate Revocation List (CRL)"
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
  description = "Name of the Intermediate CA to create for a private_cert secret engine. If a prefix input variable is specified, it is added to the value in the `<prefix>-value` format."
  default     = "intermediate-ca"
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
  description = "The signing method to use with this certificate authority to generate private certificates"
  default     = "internal"

  validation {
    condition     = contains(["internal", "external"], var.intermediate_ca_signing_method)
    error_message = "specified signing_method is not valid. Allowed values are: internal, external"
  }
}

##############################################################################
# Template
##############################################################################

variable "certificate_template_name" {
  type        = string
  description = "Name of the Certificate Template to create for a private_cert secret engine. If a prefix input variable is specified, it is added to the value in the `<prefix>-value` format."
  default     = "default-cert-template"
}

variable "template_max_ttl" {
  type        = string
  description = "Max TTL for the certificate template"
  default     = "8760h"
}

variable "template_allow_any_name" {
  type        = bool
  description = "Allow clients to request a private certificate that matches any common name"
  default     = true
}

variable "template_allow_bare_domains" {
  type        = bool
  description = "Allow clients to request private certificates that match the value of the actual domains on the final certificate"
  default     = false
}

variable "template_allow_glob_domains" {
  type        = bool
  description = "Allow glob patterns in the names that are specified in the allowed_domains field"
  default     = false
}

variable "template_allow_ip_sans" {
  type        = bool
  description = "Allow clients to request a private certificate with IP Subject Alternative Names"
  default     = true
}

variable "template_allow_subdomains" {
  type        = bool
  description = "Allow clients to request private certificates with common names (CN) that are subdomains of the CNs that are allowed by the other certificate template options"
  default     = false
}

variable "template_allowed_domains" {
  type        = list(string)
  description = "Domains to define for the certificate template"
  default     = []

  validation {
    condition     = length(var.template_allowed_domains) <= 100
    error_message = "length of template_allowed_domains must be <= 100"
  }

  validation {
    condition = alltrue([
      for subdomain in var.template_allowed_domains : can(regex("(.*?)", subdomain))
    ])
    error_message = "list items must match regular expression /(.*?)/"
  }
}

variable "allowed_domains_template" {
  type        = bool
  description = "Allow the domains that are supplied in the allowed_domains field to contain access control list (ACL) templates"
  default     = false
}

variable "template_allowed_other_sans" {
  type        = list(string)
  description = "The custom Object Identifier (OID) or UTF8-string Subject Alternative Names (SANs) to allow for private certificates"
  default     = []

  validation {
    condition     = length(var.template_allowed_other_sans) <= 100
    error_message = "length of template_allowed_other_sans must be <= 100"
  }

  validation {
    condition = alltrue([
      for template_allowed_other_san in var.template_allowed_other_sans : can(regex("^(.*?)", template_allowed_other_san))
    ])
    error_message = "list items must match regular expression /^(.*?)/"
  }
}

variable "template_allowed_secret_groups" {
  type        = string
  description = "Allowed secrets group Ids as a comma-delimited list"
  default     = null

  validation {
    condition     = var.template_allowed_secret_groups == null ? true : length(var.template_allowed_secret_groups) >= 2 && length(var.template_allowed_secret_groups) <= 1024
    error_message = "length of template_allowed_secret_groups must be >= 2 and <= 1024"
  }

  validation {
    condition = var.template_allowed_secret_groups == null ? true : alltrue([
      for secret_group in var.template_allowed_secret_groups : can(regex("^(.*?)", secret_group))
    ])
    error_message = "list items must match regular expression /^(.*?)/"
  }
}

variable "template_allowed_uri_sans" {
  type        = list(string)
  description = "Allowed URI SANs for the certificate template"
  default     = ["example.com/test"]

  validation {
    condition     = var.template_allowed_uri_sans == null ? true : length(var.template_allowed_uri_sans) <= 100
    error_message = "length of template_allowed_uri_sans must be <= 100"
  }

  validation {
    condition = var.template_allowed_uri_sans == null ? true : alltrue([
      for template_allowed_uri_san in var.template_allowed_uri_sans : can(regex("^(.*?)", template_allowed_uri_san))
    ])
    error_message = "list items must match regular expression /^(.*?)/"
  }
}

variable "template_basic_constraints_valid_for_non_ca" {
  type        = bool
  description = "Mark the Basic Constraints extension of an issued private certificate as valid for non-CA certificates"
  default     = false
}

variable "template_client_flag" {
  type        = bool
  description = "Set whether private certificates are flagged for client use"
  default     = true
}

variable "template_code_signing_flag" {
  type        = bool
  description = "Set whether private certificates are flagged for code signing use"
  default     = false
}

variable "template_email_protection_flag" {
  type        = bool
  description = "Set whether private certificates are flagged for email protection use"
  default     = false
}

variable "template_enforce_hostnames" {
  type        = bool
  description = "Set whether to enforce only valid host names for common names, DNS Subject Alternative Names, and the host section of email addresses"
  default     = true
}

variable "template_ext_key_usage" {
  type        = list(string)
  description = "List of allowed extended key usage constraint on private certificates"
  default     = []

  validation {
    condition     = length(var.template_ext_key_usage) <= 100
    error_message = "length of template_ext_key_usage must be <= 100"
  }

  validation {
    condition = alltrue([
      for ext_key_usage in var.template_ext_key_usage : can(regex("^[a-zA-Z]+$", ext_key_usage))
    ])
    error_message = "list items must match regular expression /^[a-zA-Z]+$/"
  }

}

variable "template_ext_key_usage_oids" {
  type        = list(string)
  description = "List of extended key usage Object Identifiers (OIDs)"
  default     = []

  validation {
    condition     = length(var.template_ext_key_usage_oids) <= 100
    error_message = "length of template_ext_key_usage_oids must be <= 100"
  }

  validation {
    condition = alltrue([
      for ext_key_usage_oid in var.template_ext_key_usage_oids : can(regex("^(.*?)", ext_key_usage_oid))
    ])
    error_message = "list items must match regular expression /^(.*?)/"
  }
}

variable "tempalate_key_usage" {
  type        = list(string)
  description = "List of allowed key usage constraint to define for private certificates"
  default     = ["DigitalSignature", "KeyAgreement", "KeyEncipherment"]

  validation {
    condition     = length(var.tempalate_key_usage) <= 100
    error_message = "length of tempalate_key_usage must be <= 100"
  }

  validation {
    condition = alltrue([
      for key_usage in var.tempalate_key_usage : can(regex("^[a-zA-Z]+$", key_usage))
    ])
    error_message = "list items must match regular expression /^[a-zA-Z]+$/"
  }
}

variable "template_policy_identifiers" {
  type        = list(string)
  description = "List of policy Object Identifiers (OIDs)"
  default     = []
}

variable "template_require_common_name" {
  type        = bool
  description = "Set whether to require a common name to create a private certificate"
  default     = true
}

variable "template_server_flag" {
  type        = bool
  description = "Set whether private certificates are flagged for server use"
  default     = true
}

variable "template_serial_number" {
  type        = string
  description = "Serial number to assign to the generated certificate"
  default     = null

  validation {
    condition     = var.template_serial_number == null ? true : length(var.template_serial_number) >= 32 && length(var.template_serial_number) <= 64
    error_message = "length of template_serial_number >= 32 and <= 64"
  }

  validation {
    condition     = var.template_serial_number == null ? true : can(regex("[^a-fA-F0-9]", var.template_serial_number)) #verify regex
    error_message = "template_serial_number must match regular expression /[^a-fA-F0-9]/"
  }
}

variable "template_use_csr_cn" {
  type        = bool
  description = "Set whether to use the common name (CN) from a certificate signing request (CSR) instead of the CN that's included in the data of the certificate"
  default     = true
}

variable "template_use_csr_sans" {
  type        = bool
  description = "Set whether to use the Subject Alternative Names(SANs) from a certificate signing request (CSR) instead of the SANs that are included in the data of the certificate"
  default     = true
}

##############################################################################
