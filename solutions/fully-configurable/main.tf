########################################################################################################################
# Secrets Manager Private Cert Engine
########################################################################################################################

locals {
  prefix = var.prefix != null ? trimspace(var.prefix) != "" ? "${var.prefix}-" : "" : ""

  # Transform certificate_templates list to add prefix to each template name
  certificate_templates_with_prefix = [
    for template in var.certificate_templates : merge(
      template,
      {
        name = "${local.prefix}${template.name}"
      }
    )
  ]
}

module "crn_parser" {
  source  = "terraform-ibm-modules/common-utilities/ibm//modules/crn-parser"
  version = "1.6.0"
  crn     = var.existing_secrets_manager_crn
}

locals {
  existing_secrets_manager_guid   = module.crn_parser.service_instance
  existing_secrets_manager_region = module.crn_parser.region
}

module "secrets_manager_private_cert_engine" {
  source                = "../.."
  secrets_manager_guid  = local.existing_secrets_manager_guid
  region                = local.existing_secrets_manager_region
  endpoint_type         = var.endpoint_type
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
  key_bits              = var.key_bits
  permitted_dns_domains = var.permitted_dns_domains
  alt_names             = var.alt_names
  ttl                   = var.ttl
  exclude_cn_from_sans  = var.exclude_cn_from_sans

  root_ca_name                              = "${local.prefix}${var.root_ca_name}"
  root_ca_max_ttl                           = var.root_ca_max_ttl
  root_ca_common_name                       = var.root_ca_common_name
  root_ca_crl_expiry                        = var.root_ca_crl_expiry
  root_ca_crl_disable                       = var.root_ca_crl_disable
  root_ca_crl_distribution_points_encoded   = var.root_ca_crl_distribution_points_encoded
  root_ca_issuing_certificates_urls_encoded = var.root_ca_issuing_certificates_urls_encoded

  intermediate_ca_name                              = "${local.prefix}${var.intermediate_ca_name}"
  intermediate_ca_max_ttl                           = var.intermediate_ca_max_ttl
  intermediate_ca_common_name                       = var.intermediate_ca_common_name
  intermediate_ca_crl_expiry                        = var.intermediate_ca_crl_expiry
  intermediate_ca_crl_disable                       = var.intermediate_ca_crl_disable
  intermediate_ca_crl_distribution_points_encoded   = var.intermediate_ca_crl_distribution_points_encoded
  intermediate_ca_issuing_certificates_urls_encoded = var.intermediate_ca_issuing_certificates_urls_encoded
  intermediate_ca_signing_method                    = var.intermediate_ca_signing_method
  certificate_templates                             = local.certificate_templates_with_prefix
}
