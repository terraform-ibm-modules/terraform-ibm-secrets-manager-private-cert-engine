# Example with Private-Only Secrets Manager and the private certificates engine

<!-- BEGIN SCHEMATICS DEPLOY HOOK -->
<p>
  <a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=secrets-manager-private-cert-engine-private-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-secrets-manager-private-cert-engine/tree/main/examples/private">
    <img src="https://img.shields.io/badge/Deploy%20with%20IBM%20Cloud%20Schematics-0f62fe?style=flat&logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics">
  </a><br>
  ℹ️ Ctrl/Cmd+Click or right-click on the Schematics deploy button to open in a new tab.
</p>
<!-- END SCHEMATICS DEPLOY HOOK -->

This example handles the following tasks:

- Creates a private-only Secrets Manager instance
- Configures a `private_cert` secret type in the Secrets Manager instance
