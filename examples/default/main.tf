module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.6.0"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

module "secrets_manager" {
  source               = "terraform-ibm-modules/secrets-manager/ibm"
  version              = "2.15.2"
  resource_group_id    = module.resource_group.resource_group_id
  region               = var.region
  secrets_manager_name = "${var.prefix}-secrets-manager"
  sm_service_plan      = "trial"
  allowed_network      = "public-and-private"
  resource_tags        = var.resource_tags
}

module "private_secret_engine" {
  source               = "../.."
  secrets_manager_guid = module.secrets_manager.secrets_manager_guid
  region               = var.region
  root_ca_name         = var.root_ca_name
  root_ca_common_name  = "*.cloud.ibm.com"
  root_ca_max_ttl      = "8760h"
  intermediate_ca_name = var.intermediate_ca_name
  certificate_templates = [
    # Template for web servers
    {
      name            = "web-server-template"
      max_ttl         = "8760h"
      allowed_domains = ["example.com", "*.example.com"]
      server_flag     = true
      client_flag     = false
      key_usage       = ["DigitalSignature", "KeyEncipherment"]
      ext_key_usage   = ["ServerAuth"]
    },
    # Template for code signing
    {
      name              = "code-signing-template"
      max_ttl           = "2190h"
      server_flag       = false
      client_flag       = false
      code_signing_flag = true
      key_usage         = ["DigitalSignature"]
      ext_key_usage     = ["CodeSigning"]
    },
    # Template for internal services with wildcard support
    {
      name               = "internal-services-template"
      max_ttl            = "8760h"
      allow_glob_domains = true
      allow_subdomains   = true
      allowed_domains    = ["*.internal.example.com", "*.svc.cluster.local"]
      server_flag        = true
      client_flag        = true
      key_usage          = ["DigitalSignature", "KeyAgreement", "KeyEncipherment"]
      ext_key_usage      = ["ServerAuth", "ClientAuth"]
    }
  ]
}
