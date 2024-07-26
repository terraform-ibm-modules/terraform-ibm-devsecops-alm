##############################################################################
# Outputs
##############################################################################

output "gpg_key" {
  description = "The GPG signing key in base64 encoding."
  value       = try(data.external.signing_keys[0].result.signingkey, "")
  sensitive   = true
}

output "gpg_public_certificate" {
  description = "The GPG public certificate in base64 encoding."
  value       = try(data.external.signing_keys[0].result.publickey, "")
  sensitive   = true
}

output "sm_instance_crn" {
  description = "The instance ID of the specified Secrets Manager."
  value       = local.sm_instance_crn
}

output "sm_instance_id" {
  description = "The GUID of the specified Secrets Manager."
  value       = local.sm_instance_id
}
