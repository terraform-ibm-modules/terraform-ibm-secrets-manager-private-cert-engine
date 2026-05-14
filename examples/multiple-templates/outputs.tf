##############################################################################
# Outputs
##############################################################################

output "root_ca_id" {
  description = "Root CA ID"
  value       = module.private_secret_engine.root_ca_id
}

output "intermediate_ca_id" {
  description = "Intermediate CA ID"
  value       = module.private_secret_engine.intermediate_ca_id
}

output "template_ids" {
  description = "Map of all certificate template IDs"
  value       = module.private_secret_engine.template_ids
}

output "template_names" {
  description = "Map of all certificate template names"
  value       = module.private_secret_engine.template_names
}
