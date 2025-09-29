##############################################################################
# Outputs
##############################################################################

output "template_name" {
  description = "template name"
  value       = module.secrets_manager_private_cert_engine.template_name
}
  
output "private_root_ca_id" {
  description = "Root CA ID from the private cert engine module"
  value       = module.secrets_manager_private_cert_engine.root_ca_id
}

output "private_root_ca_status" {
  description = "Root CA status from the private cert engine module"
  value       = module.secrets_manager_private_cert_engine.root_ca_status
}

output "private_intermediate_ca_id" {
  description = "Intermediate CA ID from the private cert engine module"
  value       = module.secrets_manager_private_cert_engine.intermediate_ca_id
}

output "private_intermediate_ca_status" {
  description = "Intermediate CA status from the private cert engine module"
  value       = module.secrets_manager_private_cert_engine.intermediate_ca_status
}

output "private_template_id" {
  description = "Certificate template ID from the private cert engine module"
  value       = module.secrets_manager_private_cert_engine.template_id
}
