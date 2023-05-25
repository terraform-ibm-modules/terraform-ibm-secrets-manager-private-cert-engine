module "resource_group" {
  source = "git::https://github.com/terraform-ibm-modules/terraform-ibm-resource-group.git?ref=v1.0.5"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

resource "ibm_resource_instance" "secrets_manager" {
  name              = "${var.prefix}-secrets-manager"
  service           = "secrets-manager"
  plan              = var.sm_service_plan
  location          = var.region
  tags = var.resource_tags
  sm_service_plan      = "trial"
  resource_group_id = module.resource_group.resource_group_id
  timeouts {
    create = "20m" # Extending provisioning time to 20 minutes
  }
}

module "private_secret_engine" {
  source                    = "../.."
  secrets_manager_guid      = ibm_resource_instance.secrets_manager.guid
  region                    = var.region
  root_ca_name              = var.root_ca_name
  root_ca_common_name       = "cloud.ibm.com"
  root_ca_max_ttl           = "8760h"
  intermediate_ca_name      = var.intermediate_ca_name
  certificate_template_name = var.certificate_template_name
}
