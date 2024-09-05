##############################################################################
# Outputs
##############################################################################

output "compliance_ci_toolchain_id" {
  description = "The ID of the Compliance CI Toolchain"
  value       = module.devsecops_da.compliance_ci_toolchain_id
}

output "compliance_cd_toolchain_id" {
  description = "The ID of the Compliance CD Toolchain"
  value       = module.devsecops_da.compliance_cd_toolchain_id
}

output "compliance_cc_toolchain_id" {
  description = "The ID of the Compliance CC Toolchain"
  value       = module.devsecops_da.compliance_cc_toolchain_id
}

output "secrets_manager_instance_id" {
  description = "The Secrets Manage Instance ID"
  value       = module.devsecops_da.secrets_manager_instance_id
}

output "key_protect_instance_id" {
  description = "The Key Protect Instance ID"
  value       = module.devsecops_da.key_protect_instance_id
}

output "evidence_repo_url" {
  description = "The Evidence Repo URL"
  value       = module.devsecops_da.evidence_repo_url
}

output "issues_repo_url" {
  description = "The Issues Repo URL"
  value       = module.devsecops_da.issues_repo_url
}

output "inventory_repo_url" {
  description = "The Inventory Repo URL"
  value       = module.devsecops_da.inventory_repo_url
}

output "app_repo_url" {
  description = "The App Repo URL"
  value       = module.devsecops_da.app_repo_url
}

output "compliance_ci_toolchain_url" {
  description = "The Compliance CI Toolchain URL"
  value       = module.devsecops_da.compliance_ci_toolchain_url
}

output "compliance_cd_toolchain_url" {
  description = "The Compliance CD Toolchain URL"
  value       = module.devsecops_da.compliance_cd_toolchain_url
}

output "change_management_repo_url" {
  description = "The Change Management Repo URL."
  value       = module.devsecops_da.change_management_repo_url
}

output "compliance_cc_toolchain_url" {
  description = "The Compliance CC Toolchain URL"
  value       = module.devsecops_da.compliance_cc_toolchain_url
}

output "ci_pipeline_id" {
  description = "The CI pipeline Id"
  value       = module.devsecops_da.ci_pipeline_id
}

output "cd_pipeline_id" {
  description = "The CD pipeline Id"
  value       = module.devsecops_da.cd_pipeline_id
}

output "cc_pipeline_id" {
  description = "The CC pipeline Id"
  value       = module.devsecops_da.cc_pipeline_id
}

output "pr_pipeline_id" {
  description = "The PR pipeline Id"
  value       = module.devsecops_da.pr_pipeline_id
}

output "icr_namespace_name" {
  description = "The name of the targets ICR namespace."
  value       = module.devsecops_da.icr_namespace_name
}

#############################################################################
