########################################################################################################################
# Secrets Manager Private Cert Engine
########################################################################################################################

module "crn_parser" {
  source  = "terraform-ibm-modules/common-utilities/ibm//modules/crn-parser"
  version = "1.1.0"
  crn     = var.existing_secrets_manager_crn
}

locals {
  existing_secrets_manager_guid = module.crn_parser.service_instance
}

module "secrets_manager_private_cert_engine" {
  source                = "../.."
  secrets_manager_guid  = local.existing_secrets_manager_guid
  region                = var.region
  endpoint_type         = "private"
  organizational_unit   = var.organizational_unit
  organization          = var.organization
  country               = var.country
  locality              = var.locality
  province              = var.province
  street_address        = var.street_address
  postal_code           = var.postal_code
  other_sans            = var.other_sans
  ip_sans               = var.ip_sans
  uri_sans              = var.uri_sans
  return_format         = var.return_format
  private_key_format    = var.private_key_format
  key_type              = var.key_type
  permitted_dns_domains = var.permitted_dns_domains
  alt_names             = var.alt_names
  ttl                   = var.ttl
  exclude_cn_from_sans  = var.exclude_cn_from_sans

  root_ca_name                              = var.root_ca_name
  root_ca_max_ttl                           = var.root_ca_max_ttl
  root_ca_common_name                       = var.root_ca_common_name
  root_ca_crl_expiry                        = var.root_ca_crl_expiry
  root_ca_crl_disable                       = var.root_ca_crl_disable
  root_ca_crl_distribution_points_encoded   = var.root_ca_crl_distribution_points_encoded
  root_ca_issuing_certificates_urls_encoded = var.root_ca_issuing_certificates_urls_encoded

  intermediate_ca_name                              = var.intermediate_ca_name
  intermediate_ca_max_ttl                           = var.intermediate_ca_max_ttl
  intermediate_ca_common_name                       = var.intermediate_ca_common_name
  intermediate_ca_crl_expiry                        = var.intermediate_ca_crl_expiry
  intermediate_ca_crl_disable                       = var.intermediate_ca_crl_disable
  intermediate_ca_crl_distribution_points_encoded   = var.intermediate_ca_crl_distribution_points_encoded
  intermediate_ca_issuing_certificates_urls_encoded = var.intermediate_ca_issuing_certificates_urls_encoded
  intermediate_ca_signing_method                    = var.intermediate_ca_signing_method

  certificate_template_name                   = var.certificate_template_name
  template_max_ttl                            = var.template_max_ttl
  template_allow_any_name                     = var.template_allow_any_name
  template_allow_bare_domains                 = var.template_allow_bare_domains
  template_allow_glob_domains                 = var.template_allow_glob_domains
  template_allow_ip_sans                      = var.template_allow_ip_sans
  template_allow_subdomains                   = var.template_allow_subdomains
  template_allowed_domains                    = var.template_allowed_domains
  allowed_domains_template                    = var.allowed_domains_template
  template_allowed_other_sans                 = var.template_allowed_other_sans
  template_allowed_secret_groups              = var.template_allowed_secret_groups
  template_allowed_uri_sans                   = var.template_allowed_uri_sans
  template_basic_constraints_valid_for_non_ca = var.template_basic_constraints_valid_for_non_ca
  template_client_flag                        = var.template_client_flag
  template_code_signing_flag                  = var.template_code_signing_flag
  template_email_protection_flag              = var.template_email_protection_flag
  template_enforce_hostnames                  = var.template_enforce_hostnames
  template_ext_key_usage                      = var.template_ext_key_usage
  template_ext_key_usage_oids                 = var.template_ext_key_usage_oids
  tempalate_key_usage                         = var.tempalate_key_usage
  template_policy_identifiers                 = var.template_policy_identifiers
  template_require_common_name                = var.template_require_common_name
  template_server_flag                        = var.template_server_flag
  template_serial_number                      = var.template_serial_number
  template_use_csr_cn                         = var.template_use_csr_cn
  template_use_csr_sans                       = var.template_use_csr_sans
}
