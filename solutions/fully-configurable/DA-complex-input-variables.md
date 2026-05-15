# Configuring complex inputs for Secrets Manager Private Certificate Engine in IBM Cloud projects

The `certificate_templates` input variable uses a complex object type. You need to specify this input variable when you configure the deployable architecture.

* [Certificate Templates](#certificate-templates) (`certificate_templates`)

## Certificate Templates <a name="certificate-templates"></a>

The `certificate_templates` input variable allows you to define multiple certificate templates for issuing private certificates from the intermediate CA. Each template defines policies and constraints for certificate issuance.

- Variable name: `certificate_templates`
- Type: A list of objects, where each object represents a certificate template configuration
- Default value: A list with a single default template

### Options for certificate_templates

- `name` (required): The unique name for the certificate template.

- `max_ttl` (optional): Maximum time-to-live (TTL) for certificates issued from this template. Format: `<number>[s,m,h,d]`. Default: `"8760h"`.

- `allow_any_name` (optional): Allow clients to request a private certificate that matches any common name. Default: `true`.

- `allow_bare_domains` (optional): Allow clients to request private certificates that match the value of the actual domains on the final certificate. Default: `false`.

- `allow_glob_domains` (optional): Allow glob patterns in the names specified in the `allowed_domains` field. Default: `false`.

- `allow_ip_sans` (optional): Allow clients to request a private certificate with IP Subject Alternative Names. Default: `true`.

- `allow_subdomains` (optional): Allow clients to request private certificates with common names (CN) that are subdomains of the CNs allowed by other certificate template options. Default: `false`.

- `allowed_domains` (optional): List of domains to define for the certificate template (maximum 100). Default: `[]`.

- `allowed_domains_template` (optional): Allow the domains supplied in the `allowed_domains` field to contain access control list (ACL) templates. Default: `false`.

- `allowed_other_sans` (optional): The custom Object Identifier (OID) or UTF8-string Subject Alternative Names (SANs) to allow for private certificates (maximum 100). Default: `[]`.

- `allowed_secret_groups` (optional): Allowed secrets group IDs as a comma-delimited list (2-1024 characters). Default: `null`.

- `allowed_uri_sans` (optional): Allowed URI SANs for the certificate template (maximum 100). Default: `["example.com/test"]`.

- `basic_constraints_valid_for_non_ca` (optional): Mark the Basic Constraints extension of an issued private certificate as valid for non-CA certificates. Default: `false`.

- `client_flag` (optional): Set whether private certificates are flagged for client use. Default: `true`.

- `code_signing_flag` (optional): Set whether private certificates are flagged for code signing use. Default: `false`.

- `email_protection_flag` (optional): Set whether private certificates are flagged for email protection use. Default: `false`.

- `enforce_hostnames` (optional): Set whether to enforce only valid host names for common names, DNS Subject Alternative Names, and the host section of email addresses. Default: `true`.

- `ext_key_usage` (optional): List of allowed extended key usage constraints on private certificates (maximum 100). Default: `[]`.

- `ext_key_usage_oids` (optional): List of extended key usage Object Identifiers (OIDs) (maximum 100). Default: `[]`.

- `key_usage` (optional): List of allowed key usage constraints to define for private certificates (maximum 100). Default: `["DigitalSignature", "KeyAgreement", "KeyEncipherment"]`.

- `policy_identifiers` (optional): List of policy Object Identifiers (OIDs). Default: `[]`.

- `require_common_name` (optional): Set whether to require a common name to create a private certificate. Default: `true`.

- `server_flag` (optional): Set whether private certificates are flagged for server use. Default: `true`.

- `serial_number` (optional): Serial number to assign to the generated certificate (32-64 characters). Default: `null`.

- `use_csr_cn` (optional): Set whether to use the common name (CN) from a certificate signing request (CSR) instead of the CN included in the data of the certificate. Default: `true`.

- `use_csr_sans` (optional): Set whether to use the Subject Alternative Names (SANs) from a certificate signing request (CSR) instead of the SANs included in the data of the certificate. Default: `true`.

### Points to note

- You can define between 1 and 10 certificate templates per intermediate CA (IBM Cloud Secrets Manager limit).
- Each template must have a unique `name` value within the list.
- Template names are validated to ensure uniqueness.
- Lists such as `allowed_domains`, `allowed_other_sans`, `allowed_uri_sans`, `ext_key_usage`, `ext_key_usage_oids`, and `key_usage` have a maximum of 100 items.

### Example Certificate Templates Configuration

#### Single Default Template

```hcl
certificate_templates = [
  {
    name = "default-cert-template"
  }
]
```

#### Web Server Template

```hcl
certificate_templates = [
  {
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
]
```

#### Multiple Templates for Different Use Cases

```hcl
certificate_templates = [
  {
    name            = "web-server-template"
    max_ttl         = "8760h"
    allowed_domains = ["*.example.com"]
    server_flag     = true
    client_flag     = false
    ext_key_usage   = ["ServerAuth"]
  },
  {
    name               = "client-cert-template"
    max_ttl            = "4380h"
    allow_any_name     = true
    enforce_hostnames  = false
    server_flag        = false
    client_flag        = true
    key_usage          = ["DigitalSignature", "KeyAgreement"]
    ext_key_usage      = ["ClientAuth"]
  },
  {
    name                 = "internal-services-template"
    max_ttl              = "8760h"
    allow_any_name       = false
    enforce_hostnames    = true
    allow_subdomains     = true
    allow_glob_domains   = true
    allowed_domains      = ["*.internal.example.com", "*.svc.cluster.local"]
    server_flag          = true
    client_flag          = true
    key_usage            = ["DigitalSignature", "KeyAgreement", "KeyEncipherment"]
    ext_key_usage        = ["ServerAuth", "ClientAuth"]
  }
]
```

For more information, refer to the [IBM Cloud Secrets Manager - Certificate Templates documentation](https://cloud.ibm.com/docs/secrets-manager?topic=secrets-manager-certificate-templates) and the [IBM Cloud Terraform Provider documentation for Private Certificate Configuration Template](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/sm_private_certificate_configuration_template).
