# Cloud automation for Secrets Manager Private Certificate Engine (Fully configurable)

This solution supports the following:
- Provisioning and configuring a root certificate authority
- Provisioning and configuring of an intermediate certificate authority
- Provisioning and configuring a certificate template.

![secrets-manager-private-cert-engine-deployable-architecture](../../reference-architecture/secrets_manager_private_cert_engine.svg)

**NB:** This solution is not intended to be called by one or more other modules since it contains a provider configurations, meaning it is not compatible with the `for_each`, `count`, and `depends_on` arguments. For more information see [Providers Within Modules](https://developer.hashicorp.com/terraform/language/modules/develop/providers)
