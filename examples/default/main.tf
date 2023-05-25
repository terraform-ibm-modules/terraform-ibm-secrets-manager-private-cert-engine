module "resource_group" {
  source = "git::https://github.com/terraform-ibm-modules/terraform-ibm-resource-group.git?ref=v1.0.5"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

module "secrets_manager" {
  source               = "git::https://github.ibm.com/GoldenEye/secrets-manager-module.git?ref=3.0.0"
  resource_group_id    = module.resource_group.resource_group_id
  region               = var.region
  secrets_manager_name = "${var.prefix}-secrets-manager" #tfsec:ignore:general-secrets-no-plaintext-exposure
  sm_service_plan      = "trial"
  sm_tags              = var.resource_tags
}

module "private_secret_engine" {
  source                    = "../.."
  secrets_manager_guid      = module.secrets_manager.secrets_manager_guid
  region                    = var.region
  root_ca_name              = var.root_ca_name
  root_ca_common_name       = "cloud.ibm.com"
  root_ca_max_ttl           = "8760h"
  intermediate_ca_name      = var.intermediate_ca_name
  certificate_template_name = var.certificate_template_name
}
