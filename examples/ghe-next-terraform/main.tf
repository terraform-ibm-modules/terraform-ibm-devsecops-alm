locals {
  ghe_next_compliance_pipeline_urls = {
    ibm_ghe = "https://ibm.ghe.com/one-pipeline/compliance-pipelines"
    sandbox = "https://sandbox.github.ibm.com/one-pipeline/compliance-pipelines"
  }

  ghe_next_compliance_pipeline_url = lookup(local.ghe_next_compliance_pipeline_urls, var.ghe_next_git_id, "")
}

module "terraform_devsecops_alm" {
  source                                         = "./../.."
  ibmcloud_api_key                               = var.ibmcloud_api_key
  create_ci_toolchain                            = true
  create_cd_toolchain                            = true
  create_cc_toolchain                            = true
  toolchain_name                                 = var.toolchain_name
  toolchain_region                               = var.toolchain_region
  toolchain_resource_group                       = var.toolchain_resource_group
  sm_instance_crn                                = var.sm_instance_crn
  repo_git_provider                              = "githubconsolidated"
  repo_git_id                                    = var.ghe_next_git_id
  compliance_pipeline_repo_git_provider          = "githubconsolidated"
  compliance_pipeline_repo_git_id                = var.ghe_next_git_id
  #compliance_pipeline_repo_git_id                = "integrated"
  compliance_pipeline_repo_auth_type             = "pat"
  compliance_pipeline_repo_git_token_secret_crn  = var.repo_git_token_secret_crn
  #compliance_pipeline_repo_git_token_secret_crn  = "crn:v1:bluemix:public:secrets-manager:eu-de:a/d2948a254c42cdfbec135a5af44f5d56:90151b12-ec22-439b-9d9d-70b9d2536809:secret:a2fdc70e-ff29-6b92-b084-f1c966b33ac0"
  compliance_pipeline_existing_repo_url          = local.ghe_next_compliance_pipeline_url
  #compliance_pipeline_existing_repo_url          = "https://github.ibm.com/open-toolchain/compliance-pipelines"
  compliance_pipeline_branch                     = "v10"
  inventory_repo_existing_url                    = var.inventory_repo_existing_url
  inventory_repo_auth_type                       = "pat"
  inventory_repo_git_token_secret_crn            = var.repo_git_token_secret_crn
  issues_repo_existing_url                       = var.issues_repo_existing_url
  issues_repo_auth_type                          = "pat"
  issues_repo_git_token_secret_crn               = var.repo_git_token_secret_crn
  ci_app_repo_clone_to_git_id                    = var.ghe_next_git_id
  ci_app_repo_existing_git_id                    = var.ghe_next_git_id
  ci_app_repo_auth_type                          = "pat"
  ci_app_repo_existing_url                       = var.app_repo_existing_url
  ci_app_repo_branch                             = var.app_repo_branch
  ci_app_repo_git_token_secret_crn               = var.repo_git_token_secret_crn
  cd_enable_change_management_repo               = true
  change_management_repo_git_id                  = var.ghe_next_git_id
  cd_change_management_repo_auth_type            = "pat"
  cd_change_management_repo_git_token_secret_crn = var.repo_git_token_secret_crn
  change_management_existing_url                 = var.change_management_existing_url
  cd_deployment_repo_existing_git_id             = var.ghe_next_git_id
  cd_deployment_repo_auth_type                   = "pat"
  cd_deployment_repo_git_token_secret_crn        = var.repo_git_token_secret_crn
  cd_deployment_repo_existing_url                = var.app_repo_existing_url
  cc_app_repo_git_id                             = var.ghe_next_git_id
  cc_app_repo_auth_type                          = "pat"
  cc_app_repo_git_token_secret_crn               = var.repo_git_token_secret_crn
  cc_app_repo_url                                = var.app_repo_existing_url
  cc_app_repo_branch                             = var.app_repo_branch
}
