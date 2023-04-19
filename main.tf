# workaround for Schematics automatically setting a null value to false for bool type
# Issue for the enable_key_protect and enable_secrets_manager inputs as the logic fails with regard to
# determing whether to use the enable_secrets_manager or the toolchain specific counter parts ci/cd/cc_enable_secrets_manager
# this could be addressed manually by ticking a setting in Schematics for each of the inputs
locals {
  #setting all three toolchain specific parameters to false by default instead of null. If any of these values change then use the toolchain specific values.
  use_sm_override = (var.ci_enable_secrets_manager == false) && (var.cd_enable_secrets_manager == false) && (var.cc_enable_secrets_manager == false) ? true : false
  use_kp_override = (var.ci_enable_key_protect == false) && (var.cd_enable_key_protect == false) && (var.cc_enable_key_protect == false) ? true : false
}

module "devsecops_ci_toolchain" {
  count            = var.create_ci_toolchain ? 1 : 0
  source           = "git::https://github.com/terraform-ibm-modules/terraform-ibm-devsecops-ci-toolchain?ref=v1.0.5"
  ibmcloud_api_key = var.ibmcloud_api_key

  toolchain_name           = var.ci_toolchain_name
  toolchain_region         = (var.ci_toolchain_region == "") ? var.toolchain_region : var.ci_toolchain_region
  toolchain_resource_group = (var.ci_toolchain_resource_group == "") ? var.toolchain_resource_group : var.ci_toolchain_resource_group
  toolchain_description    = var.ci_toolchain_description
  registry_namespace       = var.ci_registry_namespace
  ibmcloud_api             = var.ibmcloud_api
  compliance_base_image    = var.ci_compliance_base_image

  #SECRET PROVIDERS
  enable_key_protect     = (local.use_kp_override) ? var.enable_key_protect : var.ci_enable_key_protect
  enable_secrets_manager = (local.use_sm_override) ? var.enable_secrets_manager : var.ci_enable_secrets_manager
  sm_name                = (var.ci_sm_name == "") ? var.sm_name : var.ci_sm_name
  sm_location            = (var.ci_sm_location == "") ? var.sm_location : var.ci_sm_location
  sm_resource_group      = (var.ci_sm_resource_group == "") ? var.sm_resource_group : var.ci_sm_resource_group
  sm_secret_group        = (var.ci_sm_secret_group == "") ? var.sm_secret_group : var.ci_sm_secret_group
  kp_name                = (var.ci_kp_name == "") ? var.kp_name : var.ci_kp_name
  kp_location            = (var.ci_kp_location == "") ? var.kp_location : var.ci_kp_location
  kp_resource_group      = (var.ci_kp_resource_group == "") ? var.kp_resource_group : var.ci_kp_resource_group

  #SECRET NAMES
  pipeline_ibmcloud_api_key_secret_name          = var.ci_pipeline_ibmcloud_api_key_secret_name
  cos_api_key_secret_name                        = var.ci_cos_api_key_secret_name
  issues_repo_git_token_secret_name              = var.ci_issues_repo_git_token_secret_name
  evidence_repo_git_token_secret_name            = var.ci_evidence_repo_git_token_secret_name
  inventory_repo_git_token_secret_name           = var.ci_inventory_repo_git_token_secret_name
  compliance_pipeline_repo_git_token_secret_name = var.ci_compliance_pipeline_repo_git_token_secret_name
  pipeline_config_repo_git_token_secret_name     = var.ci_pipeline_config_repo_git_token_secret_name
  slack_webhook_secret_name                      = var.ci_slack_webhook_secret_name
  app_repo_git_token_secret_name                 = var.ci_app_repo_git_token_secret_name
  signing_key_secret_name                        = var.ci_signing_key_secret_name
  pipeline_dockerconfigjson_secret_name          = var.ci_pipeline_dockerconfigjson_secret_name

  #AUTH TYPE FOR REPOS
  pipeline_config_repo_auth_type     = var.ci_pipeline_config_repo_auth_type
  inventory_repo_auth_type           = var.ci_inventory_repo_auth_type
  issues_repo_auth_type              = var.ci_issues_repo_auth_type
  evidence_repo_auth_type            = var.ci_evidence_repo_auth_type
  app_repo_auth_type                 = var.ci_app_repo_auth_type
  compliance_pipeline_repo_auth_type = var.ci_compliance_pipeline_repo_auth_type

  #PIPELINE CONFIG REPO
  pipeline_config_repo_existing_url   = var.ci_pipeline_config_repo_existing_url
  pipeline_config_repo_clone_from_url = var.ci_pipeline_config_repo_clone_from_url
  pipeline_config_repo_branch         = var.ci_pipeline_config_repo_branch
  pipeline_config_path                = var.ci_pipeline_config_path

  #GROUPS/USERS FOR REPOS
  app_group                 = var.ci_app_group
  issues_group              = var.ci_issues_group
  inventory_group           = var.ci_inventory_group
  evidence_group            = var.ci_evidence_group
  pipeline_config_group     = var.ci_pipeline_config_group
  compliance_pipeline_group = var.ci_compliance_pipeline_group

  app_name                           = var.ci_app_name
  dev_region                         = var.ci_dev_region
  dev_resource_group                 = var.ci_dev_resource_group
  cluster_name                       = var.ci_cluster_name
  cluster_namespace                  = var.ci_cluster_namespace
  registry_region                    = var.ci_registry_region
  authorization_policy_creation      = var.ci_authorization_policy_creation
  repositories_prefix                = var.ci_repositories_prefix
  doi_toolchain_id                   = var.ci_doi_toolchain_id
  pipeline_debug                     = var.ci_pipeline_debug
  opt_in_dynamic_api_scan            = var.ci_opt_in_dynamic_api_scan
  opt_in_dynamic_ui_scan             = var.ci_opt_in_dynamic_ui_scan
  opt_in_dynamic_scan                = var.ci_opt_in_dynamic_scan
  opt_out_v1_evidence                = var.ci_opt_out_v1_evidence
  opt_in_sonar                       = var.ci_opt_in_sonar
  doi_environment                    = var.ci_doi_environment
  doi_toolchain_id_pipeline_property = var.ci_doi_toolchain_id_pipeline_property
  cra_generate_cyclonedx_format      = var.ci_cra_generate_cyclonedx_format
  custom_image_tag                   = var.ci_custom_image_tag
  app_version                        = var.ci_app_version
  slack_notifications                = var.ci_slack_notifications
  sonarqube_config                   = var.ci_sonarqube_config
  enable_pipeline_dockerconfigjson   = var.ci_enable_pipeline_dockerconfigjson

  #APP REPO
  app_repo_clone_from_url        = var.ci_app_repo_clone_from_url
  app_repo_clone_from_branch     = var.ci_app_repo_clone_from_branch
  app_repo_existing_url          = var.ci_app_repo_existing_url
  app_repo_existing_branch       = var.ci_app_repo_existing_branch
  app_repo_existing_git_provider = var.ci_app_repo_existing_git_provider
  app_repo_existing_git_id       = var.ci_app_repo_existing_git_id
  app_repo_clone_to_git_provider = var.ci_app_repo_clone_to_git_provider
  app_repo_clone_to_git_id       = var.ci_app_repo_clone_to_git_id

  #CODE ENGINE
  code_engine_project        = var.ci_code_engine_project
  code_engine_region         = var.ci_code_engine_region
  code_engine_resource_group = var.ci_code_engine_resource_group
  code_engine_entity_type    = var.ci_code_engine_entity_type
  code_engine_build_strategy = var.ci_code_engine_build_strategy
  code_engine_source         = var.ci_code_engine_source

  deployment_target = var.ci_deployment_target

  #OTHER INTEGRATIONS


  #SLACK INTEGRATION
  enable_slack           = var.ci_enable_slack
  slack_channel_name     = var.ci_slack_channel_name
  slack_team_name        = var.ci_slack_team_name
  slack_pipeline_fail    = var.ci_slack_pipeline_fail
  slack_pipeline_start   = var.ci_slack_pipeline_start
  slack_pipeline_success = var.ci_slack_pipeline_success
  slack_toolchain_bind   = var.ci_slack_toolchain_bind
  slack_toolchain_unbind = var.ci_slack_toolchain_unbind

  #COS INTEGRATION
  cos_endpoint    = var.ci_cos_endpoint
  cos_bucket_name = var.ci_cos_bucket_name

  #DEVOPS INSIGHTS
  link_to_doi_toolchain = var.ci_link_to_doi_toolchain

}

module "devsecops_cd_toolchain" {
  count            = var.create_cd_toolchain ? 1 : 0
  source           = "git::https://github.com/terraform-ibm-modules/terraform-ibm-devsecops-cd-toolchain?ref=v1.0.5"
  ibmcloud_api_key = var.ibmcloud_api_key

  toolchain_name           = var.cd_toolchain_name
  toolchain_description    = var.cd_toolchain_description
  toolchain_region         = (var.cd_toolchain_region == "") ? var.toolchain_region : var.cd_toolchain_region
  toolchain_resource_group = (var.cd_toolchain_resource_group == "") ? var.toolchain_resource_group : var.cd_toolchain_resource_group
  ibmcloud_api             = var.ibmcloud_api
  compliance_base_image    = var.cd_compliance_base_image

  #SECRET PROVIDERS
  enable_key_protect     = (local.use_kp_override) ? var.enable_key_protect : var.cd_enable_key_protect
  enable_secrets_manager = (local.use_sm_override) ? var.enable_secrets_manager : var.cd_enable_secrets_manager
  sm_name                = (var.cd_sm_name == "") ? var.sm_name : var.cd_sm_name
  sm_location            = (var.cd_sm_location == "") ? var.sm_location : var.cd_sm_location
  sm_resource_group      = (var.cd_sm_resource_group == "") ? var.sm_resource_group : var.cd_sm_resource_group
  sm_secret_group        = (var.cd_sm_secret_group == "") ? var.sm_secret_group : var.cd_sm_secret_group
  kp_name                = (var.cd_kp_name == "") ? var.kp_name : var.cd_kp_name
  kp_location            = (var.cd_kp_location == "") ? var.kp_location : var.cd_kp_location
  kp_resource_group      = (var.cd_kp_resource_group == "") ? var.kp_resource_group : var.cd_kp_resource_group

  #SECRET NAMES
  pipeline_ibmcloud_api_key_secret_name          = var.cd_pipeline_ibmcloud_api_key_secret_name
  cos_api_key_secret_name                        = var.cd_cos_api_key_secret_name
  issues_repo_git_token_secret_name              = var.cd_issues_repo_git_token_secret_name
  evidence_repo_git_token_secret_name            = var.cd_evidence_repo_git_token_secret_name
  inventory_repo_git_token_secret_name           = var.cd_inventory_repo_git_token_secret_name
  compliance_pipeline_repo_git_token_secret_name = var.cd_compliance_pipeline_repo_git_token_secret_name
  pipeline_config_repo_git_token_secret_name     = var.cd_pipeline_config_repo_git_token_secret_name
  deployment_repo_git_token_secret_name          = var.cd_deployment_repo_git_token_secret_name
  change_management_repo_git_token_secret_name   = var.cd_change_management_repo_git_token_secret_name
  slack_webhook_secret_name                      = var.cd_slack_webhook_secret_name
  code_signing_cert_secret_name                  = var.cd_code_signing_cert_secret_name

  #AUTH TYPE FOR REPOS
  pipeline_config_repo_auth_type     = var.cd_pipeline_config_repo_auth_type
  inventory_repo_auth_type           = var.cd_inventory_repo_auth_type
  issues_repo_auth_type              = var.cd_issues_repo_auth_type
  evidence_repo_auth_type            = var.cd_evidence_repo_auth_type
  deployment_repo_auth_type          = var.cd_deployment_repo_auth_type
  compliance_pipeline_repo_auth_type = var.cd_compliance_pipeline_repo_auth_type
  change_management_repo_auth_type   = var.cd_change_management_repo_auth_type

  #PIPELINE CONFIG REPO
  pipeline_config_repo_existing_url   = var.cd_pipeline_config_repo_existing_url
  pipeline_config_repo_clone_from_url = var.cd_pipeline_config_repo_clone_from_url
  pipeline_config_repo_branch         = var.cd_pipeline_config_repo_branch
  pipeline_config_path                = var.cd_pipeline_config_path

  #GROUPS/USERS FOR REPOS
  issues_group              = var.cd_issues_group
  inventory_group           = var.cd_inventory_group
  evidence_group            = var.cd_evidence_group
  pipeline_config_group     = var.cd_pipeline_config_group
  compliance_pipeline_group = var.cd_compliance_pipeline_group
  deployment_group          = var.cd_deployment_group
  change_management_group   = var.cd_change_management_group


  evidence_repo_url  = try(module.devsecops_ci_toolchain[0].evidence_repo_url, var.evidence_repo_url)
  issues_repo_url    = try(module.devsecops_ci_toolchain[0].issues_repo_url, var.issues_repo_url)
  inventory_repo_url = try(module.devsecops_ci_toolchain[0].inventory_repo_url, var.inventory_repo_url)

  change_management_repo                = var.cd_change_management_repo
  change_repo_clone_from_url            = var.cd_change_repo_clone_from_url
  deployment_repo_existing_git_provider = var.cd_deployment_repo_existing_git_provider
  deployment_repo_existing_git_id       = var.cd_deployment_repo_existing_git_id
  deployment_repo_clone_to_git_provider = var.cd_deployment_repo_clone_to_git_provider
  deployment_repo_clone_to_git_id       = var.cd_deployment_repo_clone_to_git_id
  deployment_repo_clone_from_url        = var.cd_deployment_repo_clone_from_url
  deployment_repo_clone_from_branch     = var.cd_deployment_repo_clone_from_branch
  deployment_repo_existing_url          = var.cd_deployment_repo_existing_url
  deployment_repo_existing_branch       = var.cd_deployment_repo_existing_branch

  #SCC
  scc_enable_scc       = var.cd_scc_enable_scc
  scc_integration_name = var.cd_scc_integration_name

  #OTHER INTEGRATIONS
  slack_notifications           = var.cd_slack_notifications
  cluster_name                  = var.cd_cluster_name
  cluster_namespace             = var.cd_cluster_namespace
  cluster_region                = var.cd_cluster_region
  repositories_prefix           = var.cd_repositories_prefix
  authorization_policy_creation = var.cd_authorization_policy_creation
  doi_environment               = var.cd_doi_environment
  link_to_doi_toolchain         = var.cd_link_to_doi_toolchain
  doi_toolchain_id              = try(module.devsecops_ci_toolchain[0].toolchain_id, var.cd_doi_toolchain_id)
  target_environment_detail     = var.cd_target_environment_detail
  customer_impact               = var.cd_customer_impact
  target_environment_purpose    = var.cd_target_environment_purpose
  change_request_id             = var.cd_change_request_id
  satellite_cluster_group       = var.cd_satellite_cluster_group
  source_environment            = var.cd_source_environment
  target_environment            = var.cd_target_environment
  merge_cra_sbom                = var.cd_merge_cra_sbom
  opt_out_v1_evidence           = var.cd_opt_out_v1_evidence
  emergency_label               = var.cd_emergency_label
  app_version                   = var.cd_app_version
  pipeline_debug                = var.cd_pipeline_debug
  enable_signing_validation     = var.cd_enable_signing_validation

  #SLACK INTEGRATION
  enable_slack           = var.cd_enable_slack
  slack_channel_name     = var.cd_slack_channel_name
  slack_team_name        = var.cd_slack_team_name
  slack_pipeline_fail    = var.cd_slack_pipeline_fail
  slack_pipeline_start   = var.cd_slack_pipeline_start
  slack_pipeline_success = var.cd_slack_pipeline_success
  slack_toolchain_bind   = var.cd_slack_toolchain_bind
  slack_toolchain_unbind = var.cd_slack_toolchain_unbind

  #COS INTEGRATION
  cos_endpoint    = var.cd_cos_endpoint
  cos_bucket_name = var.cd_cos_bucket_name



}

module "devsecops_cc_toolchain" {
  count                         = var.create_cc_toolchain ? 1 : 0
  source                        = "git::https://github.com/terraform-ibm-modules/terraform-ibm-devsecops-cc-toolchain?ref=v1.0.5"
  ibmcloud_api_key              = var.ibmcloud_api_key
  toolchain_name                = var.cc_toolchain_name
  toolchain_description         = var.cc_toolchain_description
  toolchain_region              = (var.cc_toolchain_region == "") ? var.toolchain_region : var.cc_toolchain_region
  toolchain_resource_group      = (var.cc_toolchain_resource_group == "") ? var.toolchain_resource_group : var.cc_toolchain_resource_group
  ibmcloud_api                  = var.ibmcloud_api
  compliance_base_image         = var.cc_compliance_base_image
  authorization_policy_creation = var.cc_authorization_policy_creation

  #SECRET PROVIDERS
  enable_key_protect     = (local.use_kp_override) ? var.enable_key_protect : var.cc_enable_key_protect
  enable_secrets_manager = (local.use_sm_override) ? var.enable_secrets_manager : var.cc_enable_secrets_manager
  sm_name                = (var.cc_sm_name == "") ? var.sm_name : var.cc_sm_name
  sm_location            = (var.cc_sm_location == "") ? var.sm_location : var.cc_sm_location
  sm_resource_group      = (var.cc_sm_resource_group == "") ? var.sm_resource_group : var.cc_sm_resource_group
  sm_secret_group        = (var.cc_sm_secret_group == "") ? var.sm_secret_group : var.cc_sm_secret_group
  kp_name                = (var.cc_kp_name == "") ? var.kp_name : var.cc_kp_name
  kp_location            = (var.cc_kp_location == "") ? var.kp_location : var.cc_kp_location
  kp_resource_group      = (var.cc_kp_resource_group == "") ? var.kp_resource_group : var.cc_kp_resource_group

  #SECRET NAMES
  pipeline_ibmcloud_api_key_secret_name          = var.cc_pipeline_ibmcloud_api_key_secret_name
  cos_api_key_secret_name                        = var.cc_cos_api_key_secret_name
  issues_repo_git_token_secret_name              = var.cc_issues_repo_git_token_secret_name
  evidence_repo_git_token_secret_name            = var.cc_evidence_repo_git_token_secret_name
  inventory_repo_git_token_secret_name           = var.cc_inventory_repo_git_token_secret_name
  compliance_pipeline_repo_git_token_secret_name = var.cc_compliance_pipeline_repo_git_token_secret_name
  pipeline_config_repo_git_token_secret_name     = var.cc_pipeline_config_repo_git_token_secret_name
  app_repo_git_token_secret_name                 = var.cc_app_repo_git_token_secret_name
  slack_webhook_secret_name                      = var.cc_slack_webhook_secret_name
  pipeline_dockerconfigjson_secret_name          = var.cc_pipeline_dockerconfigjson_secret_name

  #AUTH TYPE FOR REPOS
  pipeline_config_repo_auth_type     = var.cc_pipeline_config_repo_auth_type
  inventory_repo_auth_type           = var.cc_inventory_repo_auth_type
  issues_repo_auth_type              = var.cc_issues_repo_auth_type
  evidence_repo_auth_type            = var.cc_evidence_repo_auth_type
  app_repo_auth_type                 = var.cc_app_repo_auth_type
  compliance_pipeline_repo_auth_type = var.cc_compliance_pipeline_repo_auth_type

  #PIPELINE CONFIG REPO
  pipeline_config_repo_existing_url   = var.cc_pipeline_config_repo_existing_url
  pipeline_config_repo_clone_from_url = var.cc_pipeline_config_repo_clone_from_url
  pipeline_config_repo_branch         = var.cc_pipeline_config_repo_branch
  pipeline_config_path                = var.cc_pipeline_config_path

  #GROUPS/USERS FOR REPOS
  issues_group              = var.cc_issues_group
  inventory_group           = var.cc_inventory_group
  evidence_group            = var.cc_evidence_group
  pipeline_config_group     = var.cc_pipeline_config_group
  compliance_pipeline_group = var.cc_compliance_pipeline_group
  app_group                 = var.cc_app_group

  doi_environment       = var.cc_doi_environment
  link_to_doi_toolchain = var.cc_link_to_doi_toolchain

  evidence_repo_url  = try(module.devsecops_ci_toolchain[0].evidence_repo_url, var.evidence_repo_url)
  inventory_repo_url = try(module.devsecops_ci_toolchain[0].inventory_repo_url, var.inventory_repo_url)
  issues_repo_url    = try(module.devsecops_ci_toolchain[0].issues_repo_url, var.issues_repo_url)

  app_repo_url          = try(module.devsecops_ci_toolchain[0].app_repo_url, var.cc_app_repo_url)
  app_repo_git_provider = try(module.devsecops_ci_toolchain[0].app_repo_git_provider, var.cc_app_repo_git_provider)
  app_repo_branch       = try(module.devsecops_ci_toolchain[0].app_repo_branch, var.cc_app_repo_branch)
  app_repo_git_id       = try(module.devsecops_ci_toolchain[0].app_repo_git_id, var.cc_app_repo_git_id)

  #SCC
  scc_enable_scc       = var.cc_scc_enable_scc
  scc_integration_name = var.cc_scc_integration_name

  #OTHER INTEGRATIONS
  slack_notifications              = var.cc_slack_notifications
  sonarqube_config                 = var.cc_sonarqube_config
  repositories_prefix              = var.cc_repositories_prefix
  doi_toolchain_id                 = try(module.devsecops_ci_toolchain[0].toolchain_id, var.cc_doi_toolchain_id)
  pipeline_debug                   = var.cc_pipeline_debug
  opt_in_dynamic_api_scan          = var.cc_opt_in_dynamic_api_scan
  opt_in_dynamic_ui_scan           = var.cc_opt_in_dynamic_ui_scan
  opt_in_dynamic_scan              = var.cc_opt_in_dynamic_scan
  opt_in_auto_close                = var.cc_opt_in_auto_close
  environment_tag                  = var.cc_environment_tag
  enable_pipeline_dockerconfigjson = var.cc_enable_pipeline_dockerconfigjson

  #SLACK INTEGRATION
  enable_slack           = var.cc_enable_slack
  slack_channel_name     = var.cc_slack_channel_name
  slack_team_name        = var.cc_slack_team_name
  slack_pipeline_fail    = var.cc_slack_pipeline_fail
  slack_pipeline_start   = var.cc_slack_pipeline_start
  slack_pipeline_success = var.cc_slack_pipeline_success
  slack_toolchain_bind   = var.cc_slack_toolchain_bind
  slack_toolchain_unbind = var.cc_slack_toolchain_unbind

  #COS INTEGRATION
  cos_endpoint    = var.cc_cos_endpoint
  cos_bucket_name = var.cc_cos_bucket_name
}
#############################################################
## Example resources to extend the ci_toolchain created above
#############################################################
# resource "ibm_cd_toolchain_tool_hostedgit" "akme_repo" {
#   toolchain_id = module.devsecops_ci_toolchain.toolchain_id
#   name         = "akmebank-app-repo"
#   initialization {
#     type = "link"
#     # Change akme_app_url to add your own app
#     repo_url = var.akme_app_url
#   }
#   parameters {
#     toolchain_issues_enabled = false
#     enable_traceability      = false
#   }
# }
# resource "ibm_cd_tekton_pipeline_property" "ci_pipeline_akme_cos_api_key" {
#    name           = "AKME_COS_API_KEY"
#    type           = "secure"
#    value          = format("{vault::%s.akme-cos-api-key}", module.devsecops_ci_toolchain.secret_tool)
#    pipeline_id    = module.devsecops_ci_toolchain.ci_pipeline_id
# }

# resource "ibm_cd_tekton_pipeline_trigger" "ci_pipeline_akme_dev_mode_trigger" {
#   pipeline_id    = module.devsecops_ci_toolchain.ci_pipeline_id
#   type           = "manual"
#   name           = "Akme dev mode trigger"
#   event_listener = "dev-mode-listener"
#   enabled        = true
#   max_concurrent_runs = 3
# }

# resource "ibm_cd_tekton_pipeline_trigger_property" "ci_pipeline_manual_trigger_property" {
#    name           = "repository"
#    type           = "text"
#    value          = var.akme_app_url
#    pipeline_id    = module.devsecops_ci_toolchain.ci_pipeline_id
#    trigger_id     = ibm_cd_tekton_pipeline_trigger.ci_pipeline_akme_dev_mode_trigger.trigger_id
# }
