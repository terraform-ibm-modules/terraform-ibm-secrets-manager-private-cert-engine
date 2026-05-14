##############################################################################
# Secrets Manager Private Secrets Engine Module
##############################################################################

resource "ibm_sm_private_certificate_configuration_root_ca" "private_certificate_root_ca" {
  instance_id                       = var.secrets_manager_guid
  region                            = var.region
  endpoint_type                     = var.endpoint_type
  name                              = var.root_ca_name
  common_name                       = var.root_ca_common_name
  max_ttl                           = var.root_ca_max_ttl
  crl_expiry                        = var.root_ca_crl_expiry
  crl_disable                       = var.root_ca_crl_disable
  crl_distribution_points_encoded   = var.root_ca_crl_distribution_points_encoded
  issuing_certificates_urls_encoded = var.root_ca_issuing_certificates_urls_encoded
  alt_names                         = var.alt_names
  ip_sans                           = var.ip_sans
  uri_sans                          = var.uri_sans
  ttl                               = var.ttl
  other_sans                        = var.other_sans
  format                            = var.return_format
  private_key_format                = var.private_key_format
  key_type                          = var.key_type
  key_bits                          = var.key_bits
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
  endpoint_type                     = var.endpoint_type
  region                            = var.region
  common_name                       = var.intermediate_ca_common_name
  signing_method                    = var.intermediate_ca_signing_method
  issuer                            = var.root_ca_name
  max_ttl                           = var.intermediate_ca_max_ttl
  crl_disable                       = var.intermediate_ca_crl_disable
  crl_expiry                        = var.intermediate_ca_crl_expiry
  crl_distribution_points_encoded   = var.intermediate_ca_crl_distribution_points_encoded
  issuing_certificates_urls_encoded = var.intermediate_ca_issuing_certificates_urls_encoded
  alt_names                         = var.alt_names
  ip_sans                           = var.ip_sans
  uri_sans                          = var.uri_sans
  ttl                               = var.ttl
  other_sans                        = var.other_sans
  format                            = var.return_format
  private_key_format                = var.private_key_format
  key_type                          = var.key_type
  key_bits                          = var.key_bits
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
  for_each                           = var.certificate_templates
  instance_id                        = var.secrets_manager_guid
  region                             = var.region
  name                               = each.value.name
  endpoint_type                      = var.endpoint_type
  certificate_authority              = var.intermediate_ca_name
  max_ttl                            = each.value.max_ttl
  allow_any_name                     = each.value.allow_any_name
  enforce_hostnames                  = each.value.enforce_hostnames
  allowed_uri_sans                   = each.value.allowed_uri_sans
  allow_bare_domains                 = each.value.allow_bare_domains
  allow_glob_domains                 = each.value.allow_glob_domains
  allow_ip_sans                      = each.value.allow_ip_sans
  allow_subdomains                   = each.value.allow_subdomains
  allowed_domains                    = each.value.allowed_domains
  allowed_domains_template           = each.value.allowed_domains_template
  allowed_other_sans                 = each.value.allowed_other_sans
  allowed_secret_groups              = each.value.allowed_secret_groups
  basic_constraints_valid_for_non_ca = each.value.basic_constraints_valid_for_non_ca
  policy_identifiers                 = each.value.policy_identifiers
  client_flag                        = each.value.client_flag
  code_signing_flag                  = each.value.code_signing_flag
  email_protection_flag              = each.value.email_protection_flag
  ext_key_usage                      = each.value.ext_key_usage
  ext_key_usage_oids                 = each.value.ext_key_usage_oids
  key_usage                          = each.value.key_usage
  require_cn                         = each.value.require_common_name
  server_flag                        = each.value.server_flag
  use_csr_common_name                = each.value.use_csr_cn
  use_csr_sans                       = each.value.use_csr_sans
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
