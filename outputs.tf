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

output "template_ids" {
  description = "Map of certificate template IDs from the private cert engine module"
  value = {
    for k, v in ibm_sm_private_certificate_configuration_template.certificate_template : k => v.id
  }
}

output "template_names" {
  description = "Map of certificate template names used to define certificate settings and policies during issuance."
  value = {
    for k, v in ibm_sm_private_certificate_configuration_template.certificate_template : k => v.name
  }
}
