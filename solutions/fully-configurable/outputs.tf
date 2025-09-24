##############################################################################
# Outputs
##############################################################################

output "template_name" {
  description = "template name"
  value       = module.secrets_manager_private_cert_engine.template_name
}
