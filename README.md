# Secrets Manager Private Certificates Secrets Engine module

<!-- UPDATE BADGE: Update the link for the following badge-->
[![Incubating (Not yet consumable)](https://img.shields.io/badge/status-Incubating%20(Not%20yet%20consumable)-red)](https://terraform-ibm-modules.github.io/documentation/#/badge-status)
[![Build status](https://github.com/terraform-ibm-modules/terraform-ibm-secrets-manager-private-cert-engine/actions/workflows/ci.yml/badge.svg)](https://github.com/terraform-ibm-modules/terraform-ibm-secrets-manager-private-cert-engine/actions/workflows/ci.yml)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![latest release](https://img.shields.io/github/v/release/terraform-ibm-modules/terraform-ibm-secrets-manager-private-cert-engine?logo=GitHub&sort=semver)](https://github.com/terraform-ibm-modules/terraform-ibm-secrets-manager-private-cert-engine/releases/latest)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

This module configures a private certificates engine for a Secrets Manager instance. For more information about enabling Secrets Manager for private certificates, see [Preparing to create private certificates](https://cloud.ibm.com/docs/secrets-manager?topic=secrets-manager-prepare-order-certificates).

The module handles the following components:

- [Root certificate authorities](https://cloud.ibm.com/docs/secrets-manager?topic=secrets-manager-root-certificate-authorities) configuration
- [Intermediate certificate authorities](https://cloud.ibm.com/docs/secrets-manager?topic=secrets-manager-intermediate-certificate-authorities) configuration
- [Certificate templates](https://cloud.ibm.com/docs/secrets-manager?topic=secrets-manager-certificate-templates)

These components make up the `private_cert` secrets type. The module also signs the intermediate certificate authority (CA) when the engine is created.

## Usage

```hcl
# Replace "main" with a GIT release version to lock into a specific release
module "private_secret_engine" {
  source                    = "git::https://github.com/terraform-ibm-modules/terraform-ibm-secrets-manager-private-cert-engine?ref=main"
  secrets_manager_guid      = "<secrets_manager_instance_id>"
  region                    = "us-south"
  root_ca_name              = "My Root CA"
  root_ca_common_name       = "cloud.ibm.com"
  root_ca_max_ttl           = "8760h"
  intermediate_ca_name      = "My Intermediate CA"
  certificate_template_name = "My Certificate Template"
}
```

## Required IAM access policies
You need the following permissions to run this module.

- IAM Services
    - **Secrets Manager** service
        - `Administrator` platform access
        - `Manager` service access

<!-- BEGIN EXAMPLES HOOK -->
## Examples

- [ Example with Secrets Manager and the private certificates engine](examples/default)
<!-- END EXAMPLES HOOK -->

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.51.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ibm_sm_private_certificate_configuration_intermediate_ca.intermediate_ca](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/sm_private_certificate_configuration_intermediate_ca) | resource |
| [ibm_sm_private_certificate_configuration_root_ca.private_certificate_root_ca](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/sm_private_certificate_configuration_root_ca) | resource |
| [ibm_sm_private_certificate_configuration_template.certificate_template](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/sm_private_certificate_configuration_template) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_domains_template"></a> [allowed\_domains\_template](#input\_allowed\_domains\_template) | Optional, Allow the domains that are supplied in the allowed\_domains field to contain access control list (ACL) templates | `bool` | `false` | no |
| <a name="input_alt_names"></a> [alt\_names](#input\_alt\_names) | Optional, Alternate names for the certificate to be created | `list(string)` | `null` | no |
| <a name="input_certificate_template_name"></a> [certificate\_template\_name](#input\_certificate\_template\_name) | Name of the Certificate Template to create for a private\_cert secret engine | `string` | n/a | yes |
| <a name="input_country"></a> [country](#input\_country) | Optional, Country (C) values to define in the subject field of the resulting certificate | `list(string)` | `null` | no |
| <a name="input_exclude_cn_from_sans"></a> [exclude\_cn\_from\_sans](#input\_exclude\_cn\_from\_sans) | Optional, Set whether the common name is excluded from Subject Alternative Names (SANs). If set to true, the common name is not included in DNS or Email SANs if they apply | `bool` | `false` | no |
| <a name="input_intermediate_ca_common_name"></a> [intermediate\_ca\_common\_name](#input\_intermediate\_ca\_common\_name) | Common name for the intermediate CA | `string` | `"cloud.ibm.com"` | no |
| <a name="input_intermediate_ca_crl_disable"></a> [intermediate\_ca\_crl\_disable](#input\_intermediate\_ca\_crl\_disable) | crl\_disable for the intermediate CA | `bool` | `false` | no |
| <a name="input_intermediate_ca_crl_distribution_points_encoded"></a> [intermediate\_ca\_crl\_distribution\_points\_encoded](#input\_intermediate\_ca\_crl\_distribution\_points\_encoded) | crl\_distribution\_points\_encoded flag for the intermediate CA | `bool` | `true` | no |
| <a name="input_intermediate_ca_crl_expiry"></a> [intermediate\_ca\_crl\_expiry](#input\_intermediate\_ca\_crl\_expiry) | crl\_expiry for the intermediate CA | `string` | `"72h"` | no |
| <a name="input_intermediate_ca_issuing_certificates_urls_encoded"></a> [intermediate\_ca\_issuing\_certificates\_urls\_encoded](#input\_intermediate\_ca\_issuing\_certificates\_urls\_encoded) | issuing\_certificates\_urls\_encoded flag for the intermediate CA | `bool` | `true` | no |
| <a name="input_intermediate_ca_max_ttl"></a> [intermediate\_ca\_max\_ttl](#input\_intermediate\_ca\_max\_ttl) | for the intermediate CA | `string` | `"26300h"` | no |
| <a name="input_intermediate_ca_name"></a> [intermediate\_ca\_name](#input\_intermediate\_ca\_name) | Name of the Intermediate CA to create for a private\_cert secret engine | `string` | n/a | yes |
| <a name="input_intermediate_ca_serial_number"></a> [intermediate\_ca\_serial\_number](#input\_intermediate\_ca\_serial\_number) | Optional, serial number to assign to the generated certificate. To assign a random serial number, you can omit this field. | `string` | `null` | no |
| <a name="input_intermediate_ca_signing_method"></a> [intermediate\_ca\_signing\_method](#input\_intermediate\_ca\_signing\_method) | Optional, Signing method to use with this certificate authority to generate private certificates | `string` | `"internal"` | no |
| <a name="input_ip_sans"></a> [ip\_sans](#input\_ip\_sans) | Optional, IP Subject Alternative Names (SANs) to define for the CA certificate, in a comma-delimited list | `string` | `null` | no |
| <a name="input_key_type"></a> [key\_type](#input\_key\_type) | Optional, Type of private key to generate | `string` | `"rsa"` | no |
| <a name="input_locality"></a> [locality](#input\_locality) | Optional, Locality (L) values to define in the subject field of the resulting certificate | `list(string)` | `null` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Optional, Organization (O) values to define in the subject field of the resulting certificate | `list(string)` | `null` | no |
| <a name="input_organizational_unit"></a> [organizational\_unit](#input\_organizational\_unit) | Optional, Organizational Unit (OU) values to define in the subject field of the resulting certificate | `list(string)` | `null` | no |
| <a name="input_other_sans"></a> [other\_sans](#input\_other\_sans) | Optional, The custom Object Identifier (OID) or UTF8-string Subject Alternative Names (SANs) to define for the CA certificate. The alternative names must match the values that are specified in the 'allowed\_other\_sans' field in the associated certificate template | `list(string)` | `null` | no |
| <a name="input_permitted_dns_domains"></a> [permitted\_dns\_domains](#input\_permitted\_dns\_domains) | Optional, Allowed DNS domains or subdomains for the certificates to be signed and issued by the CA certificate | `list(string)` | `null` | no |
| <a name="input_postal_code"></a> [postal\_code](#input\_postal\_code) | Optional, Street Address values in the subject field of the resulting certificate | `list(string)` | `null` | no |
| <a name="input_private_key_format"></a> [private\_key\_format](#input\_private\_key\_format) | Optional, Format of the generated private key | `string` | `"der"` | no |
| <a name="input_province"></a> [province](#input\_province) | Optional, Province (ST) values to define in the subject field of the resulting certificate | `list(string)` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | Region of the secrets manager instance | `string` | n/a | yes |
| <a name="input_return_format"></a> [return\_format](#input\_return\_format) | Optional, Format of the returned data | `string` | `"pem"` | no |
| <a name="input_root_ca_common_name"></a> [root\_ca\_common\_name](#input\_root\_ca\_common\_name) | Fully qualified domain name or host domain name for the certificate to be created | `string` | n/a | yes |
| <a name="input_root_ca_crl_disable"></a> [root\_ca\_crl\_disable](#input\_root\_ca\_crl\_disable) | crl\_disable flag for the root CA | `bool` | `false` | no |
| <a name="input_root_ca_crl_distribution_points_encoded"></a> [root\_ca\_crl\_distribution\_points\_encoded](#input\_root\_ca\_crl\_distribution\_points\_encoded) | crl\_distribution\_points\_encoded flag for the root CA | `bool` | `true` | no |
| <a name="input_root_ca_crl_expiry"></a> [root\_ca\_crl\_expiry](#input\_root\_ca\_crl\_expiry) | Optional, Expiry time for root CA Certificate Revocation List (CRL) | `string` | `null` | no |
| <a name="input_root_ca_issuing_certificates_urls_encoded"></a> [root\_ca\_issuing\_certificates\_urls\_encoded](#input\_root\_ca\_issuing\_certificates\_urls\_encoded) | issuing\_certificates\_urls\_encoded flag for the root CA | `bool` | `true` | no |
| <a name="input_root_ca_max_ttl"></a> [root\_ca\_max\_ttl](#input\_root\_ca\_max\_ttl) | Maximum TTL value for the root CA | `string` | n/a | yes |
| <a name="input_root_ca_name"></a> [root\_ca\_name](#input\_root\_ca\_name) | Name of the Root CA to create for a private\_cert secret engine | `string` | n/a | yes |
| <a name="input_root_ca_serial_number"></a> [root\_ca\_serial\_number](#input\_root\_ca\_serial\_number) | Optional, serial number to assign to the generated certificate. To assign a random serial number, you can omit this field. | `string` | `null` | no |
| <a name="input_secrets_manager_guid"></a> [secrets\_manager\_guid](#input\_secrets\_manager\_guid) | GUID of secrets manager instance to create the secret engine in | `string` | n/a | yes |
| <a name="input_street_address"></a> [street\_address](#input\_street\_address) | Optional, Street Address values in the subject field of the resulting certificate | `list(string)` | `null` | no |
| <a name="input_tempalate_key_usage"></a> [tempalate\_key\_usage](#input\_tempalate\_key\_usage) | Optional, List of allowed key usage constraint to define for private certificates | `list(string)` | <pre>[<br>  "DigitalSignature",<br>  "KeyAgreement",<br>  "KeyEncipherment"<br>]</pre> | no |
| <a name="input_template_allow_any_name"></a> [template\_allow\_any\_name](#input\_template\_allow\_any\_name) | Optional, Allow clients to request a private certificate that matches any common name | `bool` | `true` | no |
| <a name="input_template_allow_bare_domains"></a> [template\_allow\_bare\_domains](#input\_template\_allow\_bare\_domains) | Optional, Allow clients to request private certificates that match the value of the actual domains on the final certificate | `bool` | `false` | no |
| <a name="input_template_allow_glob_domains"></a> [template\_allow\_glob\_domains](#input\_template\_allow\_glob\_domains) | Optional, Allow glob patterns in the names that are specified in the allowed\_domains field | `bool` | `false` | no |
| <a name="input_template_allow_ip_sans"></a> [template\_allow\_ip\_sans](#input\_template\_allow\_ip\_sans) | Optional, Allow clients to request a private certificate with IP Subject Alternative Names | `bool` | `true` | no |
| <a name="input_template_allow_subdomains"></a> [template\_allow\_subdomains](#input\_template\_allow\_subdomains) | Optional, Allow clients to request private certificates with common names (CN) that are subdomains of the CNs that are allowed by the other certificate template options | `bool` | `false` | no |
| <a name="input_template_allowed_domains"></a> [template\_allowed\_domains](#input\_template\_allowed\_domains) | Optional, Domains to define for the certificate template | `list(string)` | `[]` | no |
| <a name="input_template_allowed_other_sans"></a> [template\_allowed\_other\_sans](#input\_template\_allowed\_other\_sans) | Optional, The custom Object Identifier (OID) or UTF8-string Subject Alternative Names (SANs) to allow for private certificates | `list(string)` | `[]` | no |
| <a name="input_template_allowed_secret_groups"></a> [template\_allowed\_secret\_groups](#input\_template\_allowed\_secret\_groups) | Optional, Allowed secrets group Ids as a comma-delimited list | `string` | `null` | no |
| <a name="input_template_allowed_uri_sans"></a> [template\_allowed\_uri\_sans](#input\_template\_allowed\_uri\_sans) | Allowed URI SANs for the certificate template | `list(string)` | <pre>[<br>  "example.com/test"<br>]</pre> | no |
| <a name="input_template_basic_constraints_valid_for_non_ca"></a> [template\_basic\_constraints\_valid\_for\_non\_ca](#input\_template\_basic\_constraints\_valid\_for\_non\_ca) | Optional, Mark the Basic Constraints extension of an issued private certificate as valid for non-CA certificates | `bool` | `false` | no |
| <a name="input_template_client_flag"></a> [template\_client\_flag](#input\_template\_client\_flag) | Optional, Set whether private certificates are flagged for client use | `bool` | `true` | no |
| <a name="input_template_code_signing_flag"></a> [template\_code\_signing\_flag](#input\_template\_code\_signing\_flag) | Optional, Set whether private certificates are flagged for code signing use | `bool` | `false` | no |
| <a name="input_template_email_protection_flag"></a> [template\_email\_protection\_flag](#input\_template\_email\_protection\_flag) | Optional, Set whether private certificates are flagged for email protection use | `bool` | `false` | no |
| <a name="input_template_enforce_hostnames"></a> [template\_enforce\_hostnames](#input\_template\_enforce\_hostnames) | Optional, Set whether to enforce only valid host names for common names, DNS Subject Alternative Names, and the host section of email addresses | `bool` | `true` | no |
| <a name="input_template_ext_key_usage"></a> [template\_ext\_key\_usage](#input\_template\_ext\_key\_usage) | Optional, List of allowed extended key usage constraint on private certificates | `list(string)` | `[]` | no |
| <a name="input_template_ext_key_usage_oids"></a> [template\_ext\_key\_usage\_oids](#input\_template\_ext\_key\_usage\_oids) | Optional, List of extended key usage Object Identifiers (OIDs) | `list(string)` | `[]` | no |
| <a name="input_template_max_ttl"></a> [template\_max\_ttl](#input\_template\_max\_ttl) | Max TTL for the certificate template | `string` | `"8760h"` | no |
| <a name="input_template_policy_identifiers"></a> [template\_policy\_identifiers](#input\_template\_policy\_identifiers) | Optional, list of policy Object Identifiers (OIDs) | `list(string)` | `[]` | no |
| <a name="input_template_require_common_name"></a> [template\_require\_common\_name](#input\_template\_require\_common\_name) | Optional, Set whether to require a common name to create a private certificate | `bool` | `true` | no |
| <a name="input_template_serial_number"></a> [template\_serial\_number](#input\_template\_serial\_number) | Optional, Serial number to assign to the generated certificate | `string` | `null` | no |
| <a name="input_template_server_flag"></a> [template\_server\_flag](#input\_template\_server\_flag) | Optional, Set whether private certificates are flagged for server use | `bool` | `true` | no |
| <a name="input_template_use_csr_cn"></a> [template\_use\_csr\_cn](#input\_template\_use\_csr\_cn) | Optional, Set whether to use the common name (CN) from a certificate signing request (CSR) instead of the CN that's included in the data of the certificate | `bool` | `true` | no |
| <a name="input_template_use_csr_sans"></a> [template\_use\_csr\_sans](#input\_template\_use\_csr\_sans) | Optional, Set whether to use the Subject Alternative Names(SANs) from a certificate signing request (CSR) instead of the SANs that are included in the data of the certificate | `bool` | `true` | no |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | Optional, Time-to-live (TTL) to assign to a private certificate | `string` | `null` | no |
| <a name="input_uri_sans"></a> [uri\_sans](#input\_uri\_sans) | Optional, URI Subject Alternative Names (SANs) to define for the CA certificate, in a comma-delimited list | `string` | `null` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN CONTRIBUTING HOOK -->
<!-- END CONTRIBUTING HOOK -->
