##############################################################################
# Secrets Manager Private Secrets Engine Module
##############################################################################

resource "ibm_sm_private_certificate_configuration_root_ca" "private_certificate_root_ca" {
  instance_id                       = var.secrets_manager_guid
  region                            = var.region
  name                              = var.root_ca_name
  common_name                       = var.root_ca_common_name
  max_ttl                           = var.root_ca_max_ttl
  crl_expiry                        = var.root_ca_crl_expiry
  crl_disable                       = var.root_ca_crl_disable
  crl_distribution_points_encoded   = var.root_ca_crl_distribution_points_encoded
  issuing_certificates_urls_encoded = var.root_ca_issuing_certificates_urls_encoded
  serial_number                     = var.root_ca_serial_number
  alt_names                         = var.alt_names
  ip_sans                           = var.ip_sans
  uri_sans                          = var.uri_sans
  ttl                               = var.ttl
  other_sans                        = var.other_sans
  format                            = var.return_format
  private_key_format                = var.private_key_format
  key_type                          = var.key_type
  exclude_cn_from_sans              = var.exclude_cn_from_sans
  permitted_dns_domains             = var.permitted_dns_domains
  ou                                = var.organizational_unit
  organization                      = var.organization
  country                           = var.country
  locality                          = var.locality
  province                          = var.province
  street_address                    = var.street_address
  postal_code                       = var.postal_code
}

resource "ibm_sm_private_certificate_configuration_intermediate_ca" "intermediate_ca" {
  instance_id                       = var.secrets_manager_guid
  name                              = var.intermediate_ca_name
  common_name                       = var.intermediate_ca_common_name
  signing_method                    = var.intermediate_ca_signing_method
  issuer                            = var.root_ca_name
  max_ttl                           = var.intermediate_ca_max_ttl
  crl_disable                       = var.intermediate_ca_crl_disable
  crl_expiry                        = var.intermediate_ca_crl_expiry
  crl_distribution_points_encoded   = var.intermediate_ca_crl_distribution_points_encoded
  issuing_certificates_urls_encoded = var.intermediate_ca_issuing_certificates_urls_encoded
  serial_number                     = var.intermediate_ca_serial_number
  alt_names                         = var.alt_names
  ip_sans                           = var.ip_sans
  uri_sans                          = var.uri_sans
  ttl                               = var.ttl
  other_sans                        = var.other_sans
  format                            = var.return_format
  private_key_format                = var.private_key_format
  key_type                          = var.key_type
  exclude_cn_from_sans              = var.exclude_cn_from_sans
  permitted_dns_domains             = var.permitted_dns_domains
  ou                                = var.organizational_unit
  organization                      = var.organization
  country                           = var.country
  locality                          = var.locality
  province                          = var.province
  street_address                    = var.street_address
  postal_code                       = var.postal_code

  depends_on = [
    ibm_sm_private_certificate_configuration_root_ca.private_certificate_root_ca
  ]
}

resource "ibm_sm_private_certificate_configuration_template" "certificate_template" {
  instance_id                        = var.secrets_manager_guid
  region                             = var.region
  name                               = var.certificate_template_name
  certificate_authority              = var.intermediate_ca_name
  max_ttl                            = var.template_max_ttl
  allow_any_name                     = var.template_allow_any_name
  enforce_hostnames                  = var.template_enforce_hostnames
  allowed_uri_sans                   = var.template_allowed_uri_sans
  allow_bare_domains                 = var.template_allow_bare_domains
  allow_glob_domains                 = var.template_allow_glob_domains
  allow_ip_sans                      = var.template_allow_ip_sans
  allow_subdomains                   = var.template_allow_subdomains
  allowed_domains                    = var.template_allowed_domains
  allowed_domains_template           = var.allowed_domains_template
  allowed_other_sans                 = var.template_allowed_other_sans
  allowed_secret_groups              = var.template_allowed_secret_groups
  basic_constraints_valid_for_non_ca = var.template_basic_constraints_valid_for_non_ca
  policy_identifiers                 = var.template_policy_identifiers
  client_flag                        = var.template_client_flag
  code_signing_flag                  = var.template_code_signing_flag
  email_protection_flag              = var.template_email_protection_flag
  ext_key_usage                      = var.template_ext_key_usage
  ext_key_usage_oids                 = var.template_ext_key_usage_oids
  key_usage                          = var.tempalate_key_usage
  require_cn                         = var.template_require_common_name
  server_flag                        = var.template_server_flag
  serial_number                      = var.template_serial_number
  use_csr_common_name                = var.template_use_csr_cn
  use_csr_sans                       = var.template_use_csr_sans
  ou                                 = var.organizational_unit
  organization                       = var.organization
  country                            = var.country
  locality                           = var.locality
  province                           = var.province
  street_address                     = var.street_address
  postal_code                        = var.postal_code

  depends_on = [
    ibm_sm_private_certificate_configuration_intermediate_ca.intermediate_ca
  ]
}
