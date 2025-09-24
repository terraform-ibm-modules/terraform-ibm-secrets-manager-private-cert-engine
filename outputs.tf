##############################################################################
# Outputs
##############################################################################

output "template_name" {
  description = "template name"
  value       = ibm_sm_private_certificate_configuration_template.certificate_template.name
}
