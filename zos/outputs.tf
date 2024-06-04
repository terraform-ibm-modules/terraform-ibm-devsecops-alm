##############################################################################
# Outputs
##############################################################################

output "compliance_ci_toolchain_id" {
  description = "The ID of the Compliance CI Toolchain"
  value       = try(module.devsecops_ci_toolchain[0].toolchain_id, "")
}

output "compliance_cd_toolchain_id" {
  description = "The ID of the Compliance CD Toolchain"
  value       = try(module.devsecops_cd_toolchain[0].toolchain_id, "")
}

output "compliance_cc_toolchain_id" {
  description = "The ID of the Compliance CC Toolchain"
  value       = try(module.devsecops_cc_toolchain[0].toolchain_id, "")
}

output "secrets_manager_instance_id" {
  description = "The Secrets Manage Instance ID"
  value       = try(module.devsecops_ci_toolchain[0].secrets_manager_instance_id, "")
}

output "key_protect_instance_id" {
  description = "The Key Protect Instance ID"
  value       = try(module.devsecops_ci_toolchain[0].key_protect_instance_id, "")
}

output "evidence_repo_url" {
  description = "The Evidence Repo URL"
  value       = try(module.devsecops_ci_toolchain[0].evidence_repo_url, var.evidence_repo_url)
}

output "issues_repo_url" {
  description = "The Issues Repo URL"
  value       = try(module.devsecops_ci_toolchain[0].issues_repo_url, var.issues_repo_url)
}

output "inventory_repo_url" {
  description = "The Inventory Repo URL"
  value       = try(module.devsecops_ci_toolchain[0].inventory_repo_url, var.inventory_repo_url)
}

output "app_repo_url" {
  description = "The App Repo URL"
  value       = try(module.devsecops_ci_toolchain[0].app_repo_url, var.cc_app_repo_url)
}

output "compliance_ci_toolchain_url" {
  description = "The Compliance CI Toolchain URL"
  value       = try(module.devsecops_ci_toolchain[0].toolchain_url, "")
}

output "compliance_cd_toolchain_url" {
  description = "The Compliance CD Toolchain URL"
  value       = try(module.devsecops_cd_toolchain[0].toolchain_url, "")
}

output "compliance_cc_toolchain_url" {
  description = "The Compliance CC Toolchain URL"
  value       = try(module.devsecops_cc_toolchain[0].toolchain_url, "")
}

output "ci_pipeline_id" {
  description = "The CI pipeline Id"
  value       = try(module.devsecops_ci_toolchain[0].ci_pipeline_id, "")
}

output "cd_pipeline_id" {
  description = "The CD pipeline Id"
  value       = try(module.devsecops_cd_toolchain[0].cd_pipeline_id, "")
}

output "cc_pipeline_id" {
  description = "The CC pipeline Id"
  value       = try(module.devsecops_cc_toolchain[0].cc_pipeline_id, "")
}

output "pr_pipeline_id" {
  description = "The PR pipeline Id"
  value       = try(module.devsecops_ci_toolchain[0].pr_pipeline_id, "")
}
#############################################################################
