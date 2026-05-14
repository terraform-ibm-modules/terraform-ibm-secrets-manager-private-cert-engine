# Multiple Certificate Templates Example

<!-- BEGIN SCHEMATICS DEPLOY HOOK -->
<p>
  <a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=secrets-manager-private-cert-engine-multiple-templates-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-secrets-manager-private-cert-engine/tree/main/examples/multiple-templates">
    <img src="https://img.shields.io/badge/Deploy%20with%20IBM%20Cloud%20Schematics-0f62fe?style=flat&logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics">
  </a><br>
  ℹ️ Ctrl/Cmd+Click or right-click on the Schematics deploy button to open in a new tab.
</p>
<!-- END SCHEMATICS DEPLOY HOOK -->


This example demonstrates how to create multiple certificate templates under a single intermediate CA using the Secrets Manager Private Certificate Engine module.

## Overview

This example creates:
- 1 Root CA
- 1 Intermediate CA
- 4 Certificate Templates with different configurations:
  - **web-server-template**: For web server certificates with specific domain restrictions
  - **client-cert-template**: For client authentication certificates
  - **code-signing-template**: For code signing certificates
  - **internal-services-template**: For internal services with wildcard domain support

## Usage

### Basic Usage

```hcl
module "private_secret_engine" {
  source               = "terraform-ibm-modules/secrets-manager-private-cert-engine/ibm"
  version              = "X.X.X"
  secrets_manager_guid = "your-secrets-manager-guid"
  region               = "us-south"
  root_ca_name         = "example-root-ca"
  root_ca_common_name  = "*.cloud.ibm.com"
  root_ca_max_ttl      = "87600h"
  intermediate_ca_name = "example-intermediate-ca"

  certificate_templates = {
    web_server = {
      name               = "web-server-template"
      max_ttl            = "8760h"
      allow_any_name     = false
      enforce_hostnames  = true
      allow_subdomains   = true
      allowed_domains    = ["example.com", "*.example.com"]
      server_flag        = true
      client_flag        = false
      key_usage          = ["DigitalSignature", "KeyEncipherment"]
      ext_key_usage      = ["ServerAuth"]
    }
    
    client_cert = {
      name               = "client-cert-template"
      max_ttl            = "4380h"
      allow_any_name     = true
      server_flag        = false
      client_flag        = true
      key_usage          = ["DigitalSignature", "KeyAgreement"]
      ext_key_usage      = ["ClientAuth"]
    }
  }
}
```

## Template Configuration Options

Each template in the `certificate_templates` map supports the following options:

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `name` | string | Yes | - | Unique name for the certificate template |
| `max_ttl` | string | No | "8760h" | Maximum TTL for certificates issued from this template |
| `allow_any_name` | bool | No | true | Allow any common name |
| `allow_bare_domains` | bool | No | false | Allow bare domains |
| `allow_glob_domains` | bool | No | false | Allow glob patterns in domains |
| `allow_ip_sans` | bool | No | true | Allow IP SANs |
| `allow_subdomains` | bool | No | false | Allow subdomains |
| `allowed_domains` | list(string) | No | [] | List of allowed domains |
| `server_flag` | bool | No | true | Flag for server use |
| `client_flag` | bool | No | true | Flag for client use |
| `code_signing_flag` | bool | No | false | Flag for code signing |
| `key_usage` | list(string) | No | ["DigitalSignature", "KeyAgreement", "KeyEncipherment"] | Key usage constraints |
| `ext_key_usage` | list(string) | No | [] | Extended key usage constraints |

## Outputs

The module provides the following outputs:

- `template_ids`: Map of template keys to their IDs
- `template_names`: Map of template keys to their names
- `templates`: Complete information about all templates including ID, name, and status

### Example Output Access

```hcl
# Access specific template ID
output "web_server_template_id" {
  value = module.private_secret_engine.template_ids["web_server"]
}

# Access all template IDs
output "all_template_ids" {
  value = module.private_secret_engine.template_ids
}
```

## Prerequisites

- IBM Cloud account
- Secrets Manager instance
- IBM Cloud API key with appropriate permissions

## Running the Example

1. Set your IBM Cloud API key:
   ```bash
   export TF_VAR_ibmcloud_api_key="your-api-key"
   ```

2. Update the `secrets_manager_guid` in `variables.tf` or pass it as a variable

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Review the plan:
   ```bash
   terraform plan
   ```

5. Apply the configuration:
   ```bash
   terraform apply
   ```

## Clean Up

To remove all resources:
```bash
terraform destroy
