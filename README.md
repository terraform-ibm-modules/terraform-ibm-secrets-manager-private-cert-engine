# Secrets Manager Private Certificates Secrets Engine module

[![Graduated (Supported)](https://img.shields.io/badge/Status-Graduated%20(Supported)-brightgreen)](https://terraform-ibm-modules.github.io/documentation/#/badge-status)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![latest release](https://img.shields.io/github/v/release/terraform-ibm-modules/terraform-ibm-secrets-manager-private-cert-engine?logo=GitHub&sort=semver)](https://github.com/terraform-ibm-modules/terraform-ibm-secrets-manager-private-cert-engine/releases/latest)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)
[![Terraform Registry](https://img.shields.io/badge/terraform-registry-623CE4?logo=terraform)](https://registry.terraform.io/modules/terraform-ibm-modules/secrets-manager-private-cert-engine/ibm/latest)

This module configures a private certificates engine for a Secrets Manager instance. For more information about enabling Secrets Manager for private certificates, see [Preparing to create private certificates](https://cloud.ibm.com/docs/secrets-manager?topic=secrets-manager-prepare-order-certificates).

The module handles the following components:

- [Root certificate authorities](https://cloud.ibm.com/docs/secrets-manager?topic=secrets-manager-root-certificate-authorities) configuration
- [Intermediate certificate authorities](https://cloud.ibm.com/docs/secrets-manager?topic=secrets-manager-intermediate-certificate-authorities) configuration
- [Certificate templates](https://cloud.ibm.com/docs/secrets-manager?topic=secrets-manager-certificate-templates)

These components make up the `private_cert` secrets type. The module also signs the intermediate certificate authority (CA) when the engine is created.

<!-- Below content is automatically populated via pre-commit hook -->
<!-- BEGIN OVERVIEW HOOK -->
## Overview
<ul>
  <li><a href="#terraform-ibm-secrets-manager-private-cert-engine">terraform-ibm-secrets-manager-private-cert-engine</a></li>
  <li><a href="./examples">Examples</a>
    <ul>
      <li>
        <a href="./examples/default">Example with Secrets Manager and the private certificates engine</a>
        <a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=secrets-manager-private-cert-engine-default-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-secrets-manager-private-cert-engine/tree/main/examples/default"><img src="https://img.shields.io/badge/Deploy%20with%20IBM%20Cloud%20Schematics-0f62fe?style=flat&logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics" style="height: 16px; vertical-align: text-bottom; margin-left: 5px;"></a>
      </li>
      <li>
        <a href="./examples/multiple-templates">Example with Secrets Manager and the private certificates engine with multiple templates</a>
        <a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=secrets-manager-private-cert-engine-multiple-templates-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-secrets-manager-private-cert-engine/tree/main/examples/multiple-templates"><img src="https://img.shields.io/badge/Deploy%20with%20IBM%20Cloud%20Schematics-0f62fe?style=flat&logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics" style="height: 16px; vertical-align: text-bottom; margin-left: 5px;"></a>
      </li>
      <li>
        <a href="./examples/private">Example with Private-Only Secrets Manager and the private certificates engine</a>
        <a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=secrets-manager-private-cert-engine-private-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-secrets-manager-private-cert-engine/tree/main/examples/private"><img src="https://img.shields.io/badge/Deploy%20with%20IBM%20Cloud%20Schematics-0f62fe?style=flat&logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics" style="height: 16px; vertical-align: text-bottom; margin-left: 5px;"></a>
      </li>
    </ul>
    ℹ️ Ctrl/Cmd+Click or right-click on the Schematics deploy button to open in a new tab.
  </li>
  <li><a href="./solutions">Deployable Architectures</a>
    <ul>
      <li><a href="./solutions/fully-configurable">Cloud automation for Secrets Manager private certificates engine (Fully configurable)</a></li>
    </ul>
  </li>
  <li><a href="#contributing">Contributing</a></li>
</ul>
<!-- END OVERVIEW HOOK -->

## terraform-ibm-secrets-manager-private-cert-engine

### Usage

```hcl
module "private_secret_engine" {
  source                = "terraform-ibm-modules/secrets-manager-private-cert-engine/ibm"
  version               = "X.X.X" # Replace "X.X.X" with a release version to lock into a specific release
  secrets_manager_guid  = "<secrets_manager_instance_id>"
  region                = "us-south"
  root_ca_name          = "My Root CA"
  root_ca_common_name   = "cloud.ibm.com"
  root_ca_max_ttl       = "8760h"
  intermediate_ca_name  = "My Intermediate CA"
  certificate_templates = [
    {
      name = "my-certificate-template"
    }
  ]
}
```

### Required IAM access policies
You need the following permissions to run this module.

- IAM Services
    - **Secrets Manager** service
        - `Administrator` platform access
        - `Manager` service access

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.89.0, < 3.0.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [ibm_sm_private_certificate_configuration_intermediate_ca.intermediate_ca](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/sm_private_certificate_configuration_intermediate_ca) | resource |
| [ibm_sm_private_certificate_configuration_root_ca.private_certificate_root_ca](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/sm_private_certificate_configuration_root_ca) | resource |
| [ibm_sm_private_certificate_configuration_template.certificate_template](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/sm_private_certificate_configuration_template) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alt_names"></a> [alt\_names](#input\_alt\_names) | Alternate names for the certificate to be created | `list(string)` | `null` | no |
| <a name="input_certificate_templates"></a> [certificate\_templates](#input\_certificate\_templates) | List of certificate templates to create. Each template must have a unique name. | <pre>list(object({<br/>    name                               = string<br/>    max_ttl                            = optional(string, "8760h")<br/>    allow_any_name                     = optional(bool, true)<br/>    allow_bare_domains                 = optional(bool, false)<br/>    allow_glob_domains                 = optional(bool, false)<br/>    allow_ip_sans                      = optional(bool, true)<br/>    allow_subdomains                   = optional(bool, false)<br/>    allowed_domains                    = optional(list(string), [])<br/>    allowed_domains_template           = optional(bool, false)<br/>    allowed_other_sans                 = optional(list(string), [])<br/>    allowed_secret_groups              = optional(string, null)<br/>    allowed_uri_sans                   = optional(list(string), ["example.com/test"])<br/>    basic_constraints_valid_for_non_ca = optional(bool, false)<br/>    client_flag                        = optional(bool, true)<br/>    code_signing_flag                  = optional(bool, false)<br/>    email_protection_flag              = optional(bool, false)<br/>    enforce_hostnames                  = optional(bool, true)<br/>    ext_key_usage                      = optional(list(string), [])<br/>    ext_key_usage_oids                 = optional(list(string), [])<br/>    key_usage                          = optional(list(string), ["DigitalSignature", "KeyAgreement", "KeyEncipherment"])<br/>    policy_identifiers                 = optional(list(string), [])<br/>    require_common_name                = optional(bool, true)<br/>    server_flag                        = optional(bool, true)<br/>    serial_number                      = optional(string, null)<br/>    use_csr_cn                         = optional(bool, true)<br/>    use_csr_sans                       = optional(bool, true)<br/>  }))</pre> | n/a | yes |
| <a name="input_country"></a> [country](#input\_country) | Country (C) values to define in the subject field of the resulting certificate | `list(string)` | `null` | no |
| <a name="input_endpoint_type"></a> [endpoint\_type](#input\_endpoint\_type) | The endpoint type to communicate with the provided secrets manager instance. Possible values are `public` or `private` | `string` | `"public"` | no |
| <a name="input_exclude_cn_from_sans"></a> [exclude\_cn\_from\_sans](#input\_exclude\_cn\_from\_sans) | Set whether the common name is excluded from Subject Alternative Names (SANs). If set to true, the common name is not included in DNS or Email SANs if they apply | `bool` | `false` | no |
| <a name="input_intermediate_ca_common_name"></a> [intermediate\_ca\_common\_name](#input\_intermediate\_ca\_common\_name) | Common name for the intermediate CA | `string` | `"cloud.ibm.com"` | no |
| <a name="input_intermediate_ca_crl_disable"></a> [intermediate\_ca\_crl\_disable](#input\_intermediate\_ca\_crl\_disable) | crl\_disable for the intermediate CA | `bool` | `false` | no |
| <a name="input_intermediate_ca_crl_distribution_points_encoded"></a> [intermediate\_ca\_crl\_distribution\_points\_encoded](#input\_intermediate\_ca\_crl\_distribution\_points\_encoded) | crl\_distribution\_points\_encoded flag for the intermediate CA | `bool` | `true` | no |
| <a name="input_intermediate_ca_crl_expiry"></a> [intermediate\_ca\_crl\_expiry](#input\_intermediate\_ca\_crl\_expiry) | crl\_expiry for the intermediate CA | `string` | `"72h"` | no |
| <a name="input_intermediate_ca_issuing_certificates_urls_encoded"></a> [intermediate\_ca\_issuing\_certificates\_urls\_encoded](#input\_intermediate\_ca\_issuing\_certificates\_urls\_encoded) | issuing\_certificates\_urls\_encoded flag for the intermediate CA | `bool` | `true` | no |
| <a name="input_intermediate_ca_max_ttl"></a> [intermediate\_ca\_max\_ttl](#input\_intermediate\_ca\_max\_ttl) | for the intermediate CA | `string` | `"26300h"` | no |
| <a name="input_intermediate_ca_name"></a> [intermediate\_ca\_name](#input\_intermediate\_ca\_name) | Name of the Intermediate CA to create for a private\_cert secret engine | `string` | n/a | yes |
| <a name="input_intermediate_ca_signing_method"></a> [intermediate\_ca\_signing\_method](#input\_intermediate\_ca\_signing\_method) | Signing method to use with this certificate authority to generate private certificates | `string` | `"internal"` | no |
| <a name="input_ip_sans"></a> [ip\_sans](#input\_ip\_sans) | IP Subject Alternative Names (SANs) to define for the CA certificate, in a comma-delimited list | `string` | `null` | no |
| <a name="input_key_bits"></a> [key\_bits](#input\_key\_bits) | The number of bits for the generated private key. Required for RSA/EC algorithms. | `number` | `2048` | no |
| <a name="input_key_type"></a> [key\_type](#input\_key\_type) | Type of private key to generate | `string` | `"rsa"` | no |
| <a name="input_locality"></a> [locality](#input\_locality) | Locality (L) values to define in the subject field of the resulting certificate | `list(string)` | `null` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Organization (O) values to define in the subject field of the resulting certificate | `list(string)` | `null` | no |
| <a name="input_organizational_unit"></a> [organizational\_unit](#input\_organizational\_unit) | Organizational Unit (OU) values to define in the subject field of the resulting certificate | `list(string)` | `null` | no |
| <a name="input_other_sans"></a> [other\_sans](#input\_other\_sans) | The custom Object Identifier (OID) or UTF8-string Subject Alternative Names (SANs) to define for the CA certificate. The alternative names must match the values that are specified in the 'allowed\_other\_sans' field in the associated certificate template | `list(string)` | `null` | no |
| <a name="input_permitted_dns_domains"></a> [permitted\_dns\_domains](#input\_permitted\_dns\_domains) | Allowed DNS domains or subdomains for the certificates to be signed and issued by the CA certificate | `list(string)` | `null` | no |
| <a name="input_postal_code"></a> [postal\_code](#input\_postal\_code) | Street Address values in the subject field of the resulting certificate | `list(string)` | `null` | no |
| <a name="input_private_key_format"></a> [private\_key\_format](#input\_private\_key\_format) | Format of the generated private key | `string` | `"der"` | no |
| <a name="input_province"></a> [province](#input\_province) | Province (ST) values to define in the subject field of the resulting certificate | `list(string)` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | Region of the secrets manager instance | `string` | n/a | yes |
| <a name="input_return_format"></a> [return\_format](#input\_return\_format) | Format of the returned data | `string` | `"pem"` | no |
| <a name="input_root_ca_common_name"></a> [root\_ca\_common\_name](#input\_root\_ca\_common\_name) | Fully qualified domain name or host domain name for the certificate to be created | `string` | n/a | yes |
| <a name="input_root_ca_crl_disable"></a> [root\_ca\_crl\_disable](#input\_root\_ca\_crl\_disable) | crl\_disable flag for the root CA | `bool` | `false` | no |
| <a name="input_root_ca_crl_distribution_points_encoded"></a> [root\_ca\_crl\_distribution\_points\_encoded](#input\_root\_ca\_crl\_distribution\_points\_encoded) | crl\_distribution\_points\_encoded flag for the root CA | `bool` | `true` | no |
| <a name="input_root_ca_crl_expiry"></a> [root\_ca\_crl\_expiry](#input\_root\_ca\_crl\_expiry) | Expiry time for root CA Certificate Revocation List (CRL) | `string` | `null` | no |
| <a name="input_root_ca_issuing_certificates_urls_encoded"></a> [root\_ca\_issuing\_certificates\_urls\_encoded](#input\_root\_ca\_issuing\_certificates\_urls\_encoded) | issuing\_certificates\_urls\_encoded flag for the root CA | `bool` | `true` | no |
| <a name="input_root_ca_max_ttl"></a> [root\_ca\_max\_ttl](#input\_root\_ca\_max\_ttl) | Maximum TTL value for the root CA | `string` | n/a | yes |
| <a name="input_root_ca_name"></a> [root\_ca\_name](#input\_root\_ca\_name) | Name of the Root CA to create for a private\_cert secret engine | `string` | n/a | yes |
| <a name="input_secrets_manager_guid"></a> [secrets\_manager\_guid](#input\_secrets\_manager\_guid) | GUID of secrets manager instance to create the secret engine in | `string` | n/a | yes |
| <a name="input_street_address"></a> [street\_address](#input\_street\_address) | Street Address values in the subject field of the resulting certificate | `list(string)` | `null` | no |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | Time-to-live (TTL) to assign to a private certificate | `string` | `null` | no |
| <a name="input_uri_sans"></a> [uri\_sans](#input\_uri\_sans) | URI Subject Alternative Names (SANs) to define for the CA certificate, in a comma-delimited list | `string` | `null` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_intermediate_ca_id"></a> [intermediate\_ca\_id](#output\_intermediate\_ca\_id) | Intermediate CA ID from the private cert engine module |
| <a name="output_intermediate_ca_status"></a> [intermediate\_ca\_status](#output\_intermediate\_ca\_status) | Intermediate CA status from the private cert engine module |
| <a name="output_root_ca_id"></a> [root\_ca\_id](#output\_root\_ca\_id) | Root CA ID from the private cert engine module |
| <a name="output_root_ca_status"></a> [root\_ca\_status](#output\_root\_ca\_status) | Root CA status from the private cert engine module |
| <a name="output_template_ids"></a> [template\_ids](#output\_template\_ids) | Map of certificate template IDs from the private cert engine module |
| <a name="output_template_names"></a> [template\_names](#output\_template\_names) | Map of certificate template names used to define certificate settings and policies during issuance. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- Leave this section as is so that your module has a link to local development environment set up steps for contributors to follow -->
## Contributing

You can report issues and request features for this module in GitHub issues in the module repo. See [Report an issue or request a feature](https://github.com/terraform-ibm-modules/.github/blob/main/.github/SUPPORT.md).

To set up your local development environment, see [Local development setup](https://terraform-ibm-modules.github.io/documentation/#/local-dev-setup) in the project documentation.
