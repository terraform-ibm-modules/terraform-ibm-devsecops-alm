##############################################################################
# Outputs
##############################################################################

locals {
  compliance_ci_toolchain_id  = try(module.devsecops_ci_toolchain[0].toolchain_id, "")
  compliance_cd_toolchain_id  = try(module.devsecops_cd_toolchain[0].toolchain_id, "")
  compliance_cc_toolchain_id  = try(module.devsecops_cc_toolchain[0].toolchain_id, "")
  base_url                    = format("${var.ibmcloud_api}%s", "/devops/toolchains/")
  env_tag                     = (var.ibmcloud_api == "https://cloud.ibm.com") ? format("?env_id=ibm:yp:%s", var.toolchain_region) : format("?env_id=ibm:ys1:%s", var.toolchain_region)
  compliance_ci_toolchain_url = (local.compliance_ci_toolchain_id != "") ? format("${local.base_url}%s", format("${local.compliance_ci_toolchain_id}%s", local.env_tag)) : ""
  compliance_cd_toolchain_url = (local.compliance_cd_toolchain_id != "") ? format("${local.base_url}%s", format("${local.compliance_cd_toolchain_id}%s", local.env_tag)) : ""
  compliance_cc_toolchain_url = (local.compliance_cc_toolchain_id != "") ? format("${local.base_url}%s", format("${local.compliance_cc_toolchain_id}%s", local.env_tag)) : ""
}

output "compliance_ci_toolchain_id" {
  description = "The ID of the Compliance CI Toolchain"
  value       = local.compliance_ci_toolchain_id
}

output "compliance_cd_toolchain_id" {
  description = "The ID of the Compliance CD Toolchain"
  value       = local.compliance_cd_toolchain_id
}

output "compliance_cc_toolchain_id" {
  description = "The ID of the Compliance CC Toolchain"
  value       = local.compliance_cc_toolchain_id
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
  value       = local.compliance_ci_toolchain_url
}

output "compliance_cd_toolchain_url" {
  description = "The Compliance CD Toolchain URL"
  value       = local.compliance_cd_toolchain_url
}

output "compliance_cc_toolchain_url" {
  description = "The Compliance CC Toolchain URL"
  value       = local.compliance_cc_toolchain_url
}

#############################################################################
