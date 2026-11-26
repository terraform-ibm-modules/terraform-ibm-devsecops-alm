locals {
  ghe_next_compliance_pipeline_urls = {
    ibm_ghe    = "https://ibm.ghe.com/one-pipeline/compliance-pipelines"
    sandbox    = "https://sandbox.github.ibm.com/one-pipeline/compliance-pipelines"
    integrated = "https://github.ibm.com/one-pipeline/compliance-pipelines"
  }

  ghe_next_compliance_pipeline_url = lookup(local.ghe_next_compliance_pipeline_urls, var.ghe_next_git_id, "")
}

module "terraform_devsecops_alm" {
  source                                        = "./../.."
  ibmcloud_api_key                              = var.ibmcloud_api_key
  create_ci_toolchain                           = true
  create_cd_toolchain                           = true
  create_cc_toolchain                           = true
  toolchain_name                                = var.toolchain_name
  toolchain_region                              = var.toolchain_region
  toolchain_resource_group                      = var.toolchain_resource_group
  sm_instance_crn                               = var.sm_instance_crn
  repo_git_provider                             = "githubconsolidated"
  repo_git_id                                   = var.ghe_next_git_id
  repo_auth_type                                = var.ghe_next_auth_type
  repo_github_app_auth_method                   = var.ghe_next_github_app_auth_method
  repo_github_app_credential_app_id             = var.ghe_next_github_app_credential_app_id
  repo_github_app_credential_private_key_crn    = var.ghe_next_github_app_credential_private_key_secret_crn
  repo_apply_settings_to_compliance_repos       = true
  repo_git_token_secret_crn                     = var.repo_git_token_secret_crn
  compliance_pipeline_repo_use_group_settings   = false
  compliance_pipeline_repo_auth_type            = "pat"
  compliance_pipeline_repo_git_provider         = "githubconsolidated"
  compliance_pipeline_repo_git_id               = "integrated"
  compliance_pipeline_repo_git_token_secret_crn = var.repo_git_token_secret_crn
  compliance_pipeline_existing_repo_url         = local.ghe_next_compliance_pipeline_url
  compliance_pipeline_branch                    = "v10"
  inventory_repo_existing_url                   = var.inventory_repo_existing_url
  issues_repo_existing_url                      = var.issues_repo_existing_url
  ci_app_repo_existing_url                      = var.app_repo_existing_url
  ci_app_repo_branch                            = var.app_repo_branch
  cd_enable_change_management_repo              = true
  change_management_existing_url                = var.change_management_existing_url
  cd_deployment_repo_existing_url               = var.app_repo_existing_url
  cc_app_repo_url                               = var.app_repo_existing_url
  cc_app_repo_branch                            = var.app_repo_branch
}
