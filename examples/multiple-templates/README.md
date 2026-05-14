# Example with Secrets Manager and the private certificates engine with multiple templates

<!-- BEGIN SCHEMATICS DEPLOY HOOK -->
<p>
  <a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=secrets-manager-private-cert-engine-multiple-templates-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-secrets-manager-private-cert-engine/tree/main/examples/multiple-templates">
    <img src="https://img.shields.io/badge/Deploy%20with%20IBM%20Cloud%20Schematics-0f62fe?style=flat&logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics">
  </a><br>
  ℹ️ Ctrl/Cmd+Click or right-click on the Schematics deploy button to open in a new tab.
</p>
<!-- END SCHEMATICS DEPLOY HOOK -->


This example demonstrates how to create multiple certificate templates under a single intermediate CA using the Secrets Manager Private Certificate Engine module.
This example creates:
- 1 Root CA
- 1 Intermediate CA
- 4 Certificate Templates with different configurations:
  - **web-server-template**: For web server certificates with specific domain restrictions
  - **client-cert-template**: For client authentication certificates
  - **code-signing-template**: For code signing certificates
  - **internal-services-template**: For internal services with wildcard domain support
