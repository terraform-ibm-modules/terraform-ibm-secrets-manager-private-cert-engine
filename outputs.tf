##############################################################################
# Outputs
##############################################################################
output "root_ca_id" {
  description = "Root CA ID from the private cert engine module"
  value       = ibm_sm_private_certificate_configuration_root_ca.private_certificate_root_ca.id
}

output "root_ca_status" {
  description = "Root CA status from the private cert engine module"
  value       = ibm_sm_private_certificate_configuration_root_ca.private_certificate_root_ca.status
}

output "intermediate_ca_id" {
  description = "Intermediate CA ID from the private cert engine module"
  value       = ibm_sm_private_certificate_configuration_intermediate_ca.intermediate_ca.id
}

output "intermediate_ca_status" {
  description = "Intermediate CA status from the private cert engine module"
  value       = ibm_sm_private_certificate_configuration_intermediate_ca.intermediate_ca.status
}

output "template_id" {
  description = "Certificate template ID from the private cert engine module"
  value       = ibm_sm_private_certificate_configuration_template.certificate_template.id
}

output "template_name" {
  description = "template name"
  value       = ibm_sm_private_certificate_configuration_template.certificate_template.name
}
