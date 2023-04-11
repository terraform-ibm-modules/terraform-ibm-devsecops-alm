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

output "evidence_repo_url" {
  description = "The Evidence Repo URL"
  value       = try(module.devsecops_ci_toolchain[0].evidence_repo_url, "")
}

output "issues_repo_url" {
  description = "The Issues Repo URL"
  value       = try(module.devsecops_ci_toolchain[0].issues_repo_url, "")
}

output "inventory_repo_url" {
  description = "The Inventory Repo URL"
  value       = try(module.devsecops_ci_toolchain[0].inventory_repo_url, "")
}

output "app_repo_url" {
  description = "The App Repo URL"
  value       = try(module.devsecops_ci_toolchain[0].app_repo_url, "")
}

#############################################################################
