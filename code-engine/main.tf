# workaround for Schematics automatically setting a null value to false for bool type
# Issue for the enable_key_protect and enable_secrets_manager inputs as the logic fails with regard to
# determing whether to use the enable_secrets_manager or the toolchain specific counter parts ci/cd/cc_enable_secrets_manager
# this could be addressed manually by ticking a setting in Schematics for each of the inputs
locals {
  #setting all three toolchain specific parameters to false by default instead of null. If any of these values change then use the toolchain specific values.
  use_sm_override           = (var.ci_enable_secrets_manager == false) && (var.cd_enable_secrets_manager == false) && (var.cc_enable_secrets_manager == false) ? true : false
  use_kp_override           = (var.ci_enable_key_protect == false) && (var.cd_enable_key_protect == false) && (var.cc_enable_key_protect == false) ? true : false
  use_slack_enable_override = (var.ci_enable_slack == false) && (var.cd_enable_slack == false) && (var.cc_enable_slack == false) ? true : false

  git_fr2 = "https://private.eu-fr2.git.cloud.ibm.com"
  compliance_pipelines_git_server = (
    (var.toolchain_region == "eu-fr2") ? local.git_fr2
    : format("https://%s.git.cloud.ibm.com", var.toolchain_region)
  )

  enable_slack = try(var.enable_slack, false)
  ci_slack_notification_state = (
    (var.ci_slack_notifications != "") ? var.ci_slack_notifications :
    (var.slack_notifications != "") ? var.slack_notifications :
    (local.use_slack_enable_override) && (local.enable_slack) ? "1" :
    (var.ci_enable_slack) ? "1" : "0"
  )

  cd_slack_notification_state = (
    (var.cd_slack_notifications != "") ? var.cd_slack_notifications :
    (var.slack_notifications != "") ? var.slack_notifications :
    (local.use_slack_enable_override) && (local.enable_slack) ? "1" :
    (var.cd_enable_slack) ? "1" : "0"
  )

  cc_slack_notification_state = (
    (var.cc_slack_notifications != "") ? var.cc_slack_notifications :
    (var.slack_notifications != "") ? var.slack_notifications :
    (local.use_slack_enable_override) && (local.enable_slack) ? "1" :
    (var.cc_enable_slack) ? "1" : "0"
  )

  app_source_repo_url = (
    (var.ci_app_repo_clone_from_url != "") ? var.ci_app_repo_clone_from_url :
    format("%s/open-toolchain/code-engine-compliance-app.git", local.compliance_pipelines_git_server)
  )

  code_engine_app_branch = "main"
  repo_auth_type         = ((var.repo_git_token_secret_name == "") && (var.repo_git_token_secret_crn == "")) ? "oauth" : "pat"

  inventory_repo_existing_url = (var.inventory_repo_existing_url != "") ? var.inventory_repo_existing_url : var.inventory_repo_url
  evidence_repo_existing_url  = (var.evidence_repo_existing_url != "") ? var.evidence_repo_existing_url : var.evidence_repo_url
  issues_repo_existing_url    = (var.issues_repo_existing_url != "") ? var.issues_repo_existing_url : var.issues_repo_url

  ci_code_engine_project_prefix = (var.ci_code_engine_project_prefix == "") ? var.code_engine_project_prefix : var.ci_code_engine_project_prefix
  cd_code_engine_project_prefix = (var.cd_code_engine_project_prefix == "") ? var.code_engine_project_prefix : var.cd_code_engine_project_prefix
  ci_code_engine_project        = (var.ci_code_engine_project == "") ? var.code_engine_project : var.ci_code_engine_project
  cd_code_engine_project        = (var.cd_code_engine_project == "") ? var.code_engine_project : var.cd_code_engine_project

  ci_code_engine_project_name = (local.ci_code_engine_project_prefix == "") ? local.ci_code_engine_project : format("%s-%s", local.ci_code_engine_project_prefix, local.ci_code_engine_project)
  cd_code_engine_project_name = (local.cd_code_engine_project_prefix == "") ? local.cd_code_engine_project : format("%s-%s", local.cd_code_engine_project_prefix, local.cd_code_engine_project)
  registry_namespace          = (var.ci_registry_namespace == "") ? var.registry_namespace : var.ci_registry_namespace
}

resource "random_string" "resource_suffix" {
  count   = var.add_container_name_suffix ? 1 : 0
  length  = 4
  special = false
  upper   = false
}

module "devsecops_ci_toolchain" {
  count                    = var.create_ci_toolchain ? 1 : 0
  source                   = "git::https://github.com/terraform-ibm-modules/terraform-ibm-devsecops-ci-toolchain?ref=v1.2.0"
  ibmcloud_api_key         = var.ibmcloud_api_key
  toolchain_name           = (var.ci_toolchain_name == "") ? format("${var.toolchain_name}%s", "-CI-Toolchain") : var.ci_toolchain_name
  toolchain_region         = (var.ci_toolchain_region == "") ? var.toolchain_region : replace(replace(var.ci_toolchain_region, "ibm:yp:", ""), "ibm:ys1:", "")
  toolchain_resource_group = (var.ci_toolchain_resource_group == "") ? var.toolchain_resource_group : var.ci_toolchain_resource_group
  toolchain_description    = var.ci_toolchain_description
  registry_namespace       = (var.add_container_name_suffix == false) ? local.registry_namespace : format("%s-%s", local.registry_namespace, random_string.resource_suffix[0].result)
  ibmcloud_api             = var.ibmcloud_api
  compliance_base_image    = (var.ci_compliance_base_image == "") ? var.compliance_base_image : var.ci_compliance_base_image
  ci_pipeline_branch       = (var.ci_compliance_pipeline_branch == "") ? var.compliance_pipeline_branch : var.ci_compliance_pipeline_branch
  pr_pipeline_branch       = (var.ci_compliance_pipeline_pr_branch == "") ? var.compliance_pipeline_branch : var.ci_compliance_pipeline_pr_branch
  ci_pipeline_git_tag      = (var.ci_pipeline_git_tag == "") ? var.pipeline_git_tag : var.ci_pipeline_git_tag
  pr_pipeline_git_tag      = (var.pr_pipeline_git_tag == "") ? var.pipeline_git_tag : var.pr_pipeline_git_tag
  dev_region               = (var.ci_toolchain_region == "") ? var.toolchain_region : replace(replace(var.ci_toolchain_region, "ibm:yp:", ""), "ibm:ys1:", "")
  dev_resource_group       = (var.ci_toolchain_resource_group == "") ? var.toolchain_resource_group : var.ci_toolchain_resource_group
  #SECRET PROVIDERS
  enable_key_protect     = (local.use_kp_override) ? var.enable_key_protect : var.ci_enable_key_protect
  enable_secrets_manager = (local.use_sm_override) ? var.enable_secrets_manager : var.ci_enable_secrets_manager
  sm_name                = (var.ci_sm_name == "") ? var.sm_name : var.ci_sm_name
  sm_location            = (var.ci_sm_location == "") ? replace(replace(var.sm_location, "ibm:yp:", ""), "ibm:ys1:", "") : replace(replace(var.ci_sm_location, "ibm:yp:", ""), "ibm:ys1:", "")
  sm_resource_group      = (var.ci_sm_resource_group != "") ? var.ci_sm_resource_group : (var.sm_resource_group != "") ? var.sm_resource_group : var.toolchain_resource_group
  sm_secret_group        = (var.ci_sm_secret_group == "") ? var.sm_secret_group : var.ci_sm_secret_group
  kp_name                = (var.ci_kp_name == "") ? var.kp_name : var.ci_kp_name
  kp_location            = (var.ci_kp_location == "") ? replace(replace(var.kp_location, "ibm:yp:", ""), "ibm:ys1:", "") : replace(replace(var.ci_kp_location, "ibm:yp:", ""), "ibm:ys1:", "")
  kp_resource_group      = (var.ci_kp_resource_group != "") ? var.ci_kp_resource_group : (var.kp_resource_group != "") ? var.kp_resource_group : var.toolchain_resource_group
  sm_instance_crn        = (var.ci_sm_instance_crn != "") ? var.ci_sm_instance_crn : var.sm_instance_crn

  #SECRET NAMES
  pipeline_ibmcloud_api_key_secret_name  = (var.ci_pipeline_ibmcloud_api_key_secret_name == "") ? var.pipeline_ibmcloud_api_key_secret_name : var.ci_pipeline_ibmcloud_api_key_secret_name
  pipeline_ibmcloud_api_key_secret_group = var.ci_pipeline_ibmcloud_api_key_secret_group

  cos_api_key_secret_name  = (var.ci_cos_api_key_secret_name == "") ? var.cos_api_key_secret_name : var.ci_cos_api_key_secret_name
  cos_api_key_secret_group = var.ci_cos_api_key_secret_group

  slack_webhook_secret_name  = (var.ci_slack_webhook_secret_name == "") ? var.slack_webhook_secret_name : var.ci_slack_webhook_secret_name
  slack_webhook_secret_group = var.ci_slack_webhook_secret_group

  signing_key_secret_name  = var.ci_signing_key_secret_name
  signing_key_secret_group = var.ci_signing_key_secret_group

  pipeline_dockerconfigjson_secret_name  = var.ci_pipeline_dockerconfigjson_secret_name
  pipeline_dockerconfigjson_secret_group = var.ci_pipeline_dockerconfigjson_secret_group

  pipeline_git_token_secret_name  = var.ci_pipeline_git_token_secret_name
  pipeline_git_token_secret_group = var.ci_pipeline_git_token_secret_group

  issues_repo_git_token_secret_name = (var.ci_issues_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : var.ci_issues_repo_git_token_secret_name
  issues_repo_secret_group          = (var.ci_issues_repo_secret_group == "") ? var.repo_secret_group : var.ci_issues_repo_secret_group

  evidence_repo_git_token_secret_name = (var.ci_evidence_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : var.ci_evidence_repo_git_token_secret_name
  evidence_repo_secret_group          = (var.ci_evidence_repo_secret_group == "") ? var.repo_secret_group : var.ci_evidence_repo_secret_group

  inventory_repo_git_token_secret_name = (var.ci_inventory_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : var.ci_inventory_repo_git_token_secret_name
  inventory_repo_secret_group          = (var.ci_inventory_repo_secret_group == "") ? var.repo_secret_group : var.ci_inventory_repo_secret_group

  compliance_pipeline_repo_git_token_secret_name = (var.ci_compliance_pipeline_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : var.ci_compliance_pipeline_repo_git_token_secret_name
  compliance_pipeline_repo_secret_group          = (var.ci_compliance_pipeline_repo_secret_group == "") ? var.repo_secret_group : var.ci_compliance_pipeline_repo_secret_group

  pipeline_config_repo_git_token_secret_name = (var.ci_pipeline_config_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : var.ci_pipeline_config_repo_git_token_secret_name
  pipeline_config_repo_secret_group          = (var.ci_pipeline_config_repo_secret_group == "") ? var.repo_secret_group : var.ci_pipeline_config_repo_secret_group

  app_repo_git_token_secret_name = (var.ci_app_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : var.ci_app_repo_git_token_secret_name
  app_repo_secret_group          = (var.ci_app_repo_secret_group == "") ? var.repo_secret_group : var.ci_app_repo_secret_group

  gosec_private_repository_ssh_key_secret_name  = (var.ci_gosec_repo_ssh_key_secret_name == "") ? var.gosec_repo_ssh_key_secret_name : var.ci_gosec_repo_ssh_key_secret_name
  gosec_private_repository_ssh_key_secret_group = (var.ci_gosec_repo_ssh_key_secret_group == "") ? var.gosec_repo_ssh_key_secret_group : var.ci_gosec_repo_ssh_key_secret_group

  pipeline_doi_api_key_secret_name  = (var.ci_pipeline_doi_api_key_secret_name == "") ? var.pipeline_doi_api_key_secret_name : var.ci_pipeline_doi_api_key_secret_name
  pipeline_doi_api_key_secret_group = (var.ci_pipeline_doi_api_key_secret_group == "") ? var.pipeline_doi_api_key_secret_group : var.ci_pipeline_doi_api_key_secret_group

  # CRN SECRETS
  app_repo_git_token_secret_crn                 = (var.ci_app_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : var.ci_app_repo_git_token_secret_crn
  issues_repo_git_token_secret_crn              = (var.ci_issues_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : var.ci_issues_repo_git_token_secret_crn
  evidence_repo_git_token_secret_crn            = (var.ci_evidence_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : var.ci_evidence_repo_git_token_secret_crn
  inventory_repo_git_token_secret_crn           = (var.ci_inventory_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : var.ci_inventory_repo_git_token_secret_crn
  compliance_pipeline_repo_git_token_secret_crn = (var.ci_compliance_pipeline_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : var.ci_pipeline_config_repo_git_token_secret_crn
  pipeline_config_repo_git_token_secret_crn     = (var.ci_pipeline_config_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : var.ci_pipeline_config_repo_git_token_secret_crn
  cos_api_key_secret_crn                        = (var.ci_cos_api_key_secret_crn == "") ? var.cos_api_key_secret_crn : var.ci_cos_api_key_secret_crn
  pipeline_ibmcloud_api_key_secret_crn          = (var.ci_pipeline_ibmcloud_api_key_secret_crn == "") ? var.pipeline_ibmcloud_api_key_secret_crn : var.ci_pipeline_ibmcloud_api_key_secret_crn
  signing_key_secret_crn                        = var.ci_signing_key_secret_crn
  pipeline_dockerconfigjson_secret_crn          = var.ci_pipeline_dockerconfigjson_secret_crn
  slack_webhook_secret_crn                      = (var.ci_slack_webhook_secret_crn == "") ? var.slack_webhook_secret_crn : var.ci_slack_webhook_secret_crn
  privateworker_credentials_secret_crn          = var.ci_privateworker_credentials_secret_crn
  artifactory_token_secret_crn                  = var.ci_artifactory_token_secret_crn
  pipeline_git_token_secret_crn                 = var.ci_pipeline_git_token_secret_crn
  pipeline_doi_api_key_secret_crn               = var.ci_pipeline_doi_api_key_secret_crn
  sonarqube_secret_crn                          = (var.ci_sonarqube_secret_crn == "") ? var.sonarqube_secret_crn : var.ci_sonarqube_secret_crn
  gosec_private_repository_ssh_key_secret_crn   = (var.ci_gosec_private_repository_ssh_key_secret_crn == "") ? var.gosec_private_repository_ssh_key_secret_crn : var.ci_gosec_private_repository_ssh_key_secret_crn

  #AUTH TYPE FOR REPOS
  pipeline_config_repo_auth_type     = (var.ci_pipeline_config_repo_auth_type == "") ? local.repo_auth_type : var.ci_pipeline_config_repo_auth_type
  inventory_repo_auth_type           = (var.ci_inventory_repo_auth_type == "") ? local.repo_auth_type : var.ci_inventory_repo_auth_type
  issues_repo_auth_type              = (var.ci_issues_repo_auth_type == "") ? local.repo_auth_type : var.ci_issues_repo_auth_type
  evidence_repo_auth_type            = (var.ci_evidence_repo_auth_type == "") ? local.repo_auth_type : var.ci_evidence_repo_auth_type
  app_repo_auth_type                 = (var.ci_app_repo_auth_type == "") ? local.repo_auth_type : var.ci_app_repo_auth_type
  compliance_pipeline_repo_auth_type = (var.ci_compliance_pipeline_repo_auth_type == "") ? local.repo_auth_type : var.ci_compliance_pipeline_repo_auth_type

  #GROUPS/USERS FOR REPOS
  app_group                 = (var.ci_app_group == "") ? var.repo_group : var.ci_app_group
  issues_group              = (var.ci_issues_group == "") ? var.repo_group : var.ci_issues_group
  inventory_group           = (var.ci_inventory_group == "") ? var.repo_group : var.ci_inventory_group
  evidence_group            = (var.ci_evidence_group == "") ? var.repo_group : var.ci_evidence_group
  pipeline_config_group     = (var.ci_pipeline_config_group == "") ? var.repo_group : var.ci_pipeline_config_group
  compliance_pipeline_group = (var.ci_compliance_pipeline_group == "") ? var.repo_group : var.ci_compliance_pipeline_group

  #APP REPO
  app_repo_clone_from_url        = local.app_source_repo_url
  app_repo_clone_from_branch     = (var.ci_app_repo_clone_from_branch == "") ? local.code_engine_app_branch : var.ci_app_repo_clone_from_branch
  app_repo_existing_url          = var.ci_app_repo_existing_url
  app_repo_existing_branch       = var.ci_app_repo_existing_branch
  app_repo_existing_git_provider = var.ci_app_repo_existing_git_provider
  app_repo_existing_git_id       = var.ci_app_repo_existing_git_id
  app_repo_clone_to_git_provider = var.ci_app_repo_clone_to_git_provider
  app_repo_clone_to_git_id       = var.ci_app_repo_clone_to_git_id

  #PIPELINE CONFIG REPO
  pipeline_config_repo_existing_url   = var.ci_pipeline_config_repo_existing_url
  pipeline_config_repo_clone_from_url = var.ci_pipeline_config_repo_clone_from_url
  pipeline_config_repo_branch         = var.ci_pipeline_config_repo_branch
  pipeline_config_path                = var.ci_pipeline_config_path

  #EVIDENCE REPO
  evidence_repo_name              = var.evidence_repo_name
  evidence_repo_existing_url      = var.evidence_repo_existing_url
  evidence_repo_git_provider      = var.evidence_repo_existing_git_provider
  evidence_repo_git_id            = var.evidence_repo_existing_git_id
  evidence_repo_integration_owner = var.evidence_repo_integration_owner

  #ISSUES REPO
  issues_repo_name              = var.issues_repo_name
  issues_repo_existing_url      = var.issues_repo_existing_url
  issues_repo_git_provider      = var.issues_repo_existing_git_provider
  issues_repo_git_id            = var.issues_repo_existing_git_id
  issues_repo_integration_owner = var.issues_repo_integration_owner

  #INVENTORY REPO
  inventory_repo_name              = var.inventory_repo_name
  inventory_repo_existing_url      = var.inventory_repo_existing_url
  inventory_repo_git_provider      = var.inventory_repo_existing_git_provider
  inventory_repo_git_id            = var.inventory_repo_existing_git_id
  inventory_repo_integration_owner = var.inventory_repo_integration_owner

  app_name                           = var.ci_app_name
  registry_region                    = (var.ci_registry_region == "") ? format("${var.environment_prefix}%s", var.toolchain_region) : format("${var.environment_prefix}%s", replace(replace(var.ci_registry_region, "ibm:yp:", ""), "ibm:ys1:", ""))
  authorization_policy_creation      = (var.ci_authorization_policy_creation == "") ? var.authorization_policy_creation : var.ci_authorization_policy_creation
  repositories_prefix                = (var.ci_repositories_prefix == "") ? var.repositories_prefix : var.ci_repositories_prefix
  doi_toolchain_id                   = var.ci_doi_toolchain_id
  pipeline_debug                     = var.ci_pipeline_debug
  opt_in_dynamic_api_scan            = var.ci_opt_in_dynamic_api_scan
  opt_in_dynamic_ui_scan             = var.ci_opt_in_dynamic_ui_scan
  opt_in_dynamic_scan                = var.ci_opt_in_dynamic_scan
  opt_in_sonar                       = var.ci_opt_in_sonar
  doi_environment                    = var.ci_doi_environment
  doi_toolchain_id_pipeline_property = var.ci_doi_toolchain_id_pipeline_property
  cra_generate_cyclonedx_format      = var.ci_cra_generate_cyclonedx_format
  custom_image_tag                   = var.ci_custom_image_tag
  app_version                        = var.ci_app_version
  slack_notifications                = local.ci_slack_notification_state
  sonarqube_config                   = var.ci_sonarqube_config
  enable_pipeline_dockerconfigjson   = var.ci_enable_pipeline_dockerconfigjson
  peer_review_compliance             = (var.ci_peer_review_compliance == "") ? var.peer_review_compliance : var.ci_peer_review_compliance
  print_code_signing_certificate     = var.ci_print_code_signing_certificate

  #CODE ENGINE

  #CODE ENGINE
  deployment_target                   = (var.ci_deployment_target == "") ? var.deployment_target : var.ci_deployment_target
  code_engine_project                 = local.ci_code_engine_project_name
  code_engine_region                  = (var.ci_code_engine_region == "") ? var.toolchain_region : var.ci_code_engine_region
  code_engine_resource_group          = (var.ci_code_engine_resource_group == "") ? var.toolchain_resource_group : var.ci_code_engine_resource_group
  code_engine_build_strategy          = var.ci_code_engine_build_strategy
  code_engine_build_use_native_docker = var.ci_code_engine_build_use_native_docker
  code_engine_build_size              = var.ci_code_engine_build_size
  code_engine_build_timeout           = var.ci_code_engine_build_timeout
  code_engine_wait_timeout            = var.ci_code_engine_wait_timeout
  code_engine_context_dir             = var.ci_code_engine_context_dir
  code_engine_dockerfile              = var.ci_code_engine_dockerfile
  code_engine_image_name              = var.ci_code_engine_image_name
  code_engine_registry_domain         = var.ci_code_engine_registry_domain
  code_engine_source                  = var.ci_code_engine_source
  code_engine_binding_resource_group  = var.ci_code_engine_binding_resource_group
  code_engine_deployment_type         = var.ci_code_engine_deployment_type
  code_engine_cpu                     = var.ci_code_engine_cpu
  code_engine_memory                  = var.ci_code_engine_memory
  code_engine_ephemeral_storage       = var.ci_code_engine_ephemeral_storage
  code_engine_job_maxexecutiontime    = var.ci_code_engine_job_maxexecutiontime
  code_engine_job_retrylimit          = var.ci_code_engine_job_retrylimit
  code_engine_job_instances           = var.ci_code_engine_job_instances
  code_engine_app_port                = var.ci_code_engine_app_port
  code_engine_app_min_scale           = var.ci_code_engine_app_min_scale
  code_engine_app_max_scale           = var.ci_code_engine_app_max_scale
  code_engine_app_deployment_timeout  = var.ci_code_engine_app_deployment_timeout
  code_engine_app_concurrency         = var.ci_code_engine_app_concurrency
  code_engine_app_visibility          = var.ci_code_engine_app_visibility
  code_engine_env_from_configmaps     = var.ci_code_engine_env_from_configmaps
  code_engine_env_from_secrets        = var.ci_code_engine_env_from_secrets
  code_engine_remove_refs             = var.ci_code_engine_remove_refs
  code_engine_service_bindings        = var.ci_code_engine_service_bindings

  #OTHER INTEGRATIONS

  #SLACK INTEGRATION
  enable_slack           = (local.use_slack_enable_override) ? local.enable_slack : var.ci_enable_slack
  slack_channel_name     = (var.ci_slack_channel_name == "") ? var.slack_channel_name : var.ci_slack_channel_name
  slack_team_name        = (var.ci_slack_team_name == "") ? var.slack_team_name : var.ci_slack_team_name
  slack_pipeline_fail    = var.ci_slack_pipeline_fail
  slack_pipeline_start   = var.ci_slack_pipeline_start
  slack_pipeline_success = var.ci_slack_pipeline_success
  slack_toolchain_bind   = var.ci_slack_toolchain_bind
  slack_toolchain_unbind = var.ci_slack_toolchain_unbind

  #GOSEC
  gosec_private_repository_host = (var.ci_gosec_private_repository_host == "") ? var.gosec_private_repository_host : var.ci_gosec_private_repository_host
  opt_in_gosec                  = (var.ci_opt_in_gosec == "") ? var.opt_in_gosec : var.ci_opt_in_gosec

  #SONARQUBE
  sonarqube_integration_name    = var.ci_sonarqube_integration_name
  sonarqube_user                = var.ci_sonarqube_user
  sonarqube_secret_name         = var.ci_sonarqube_secret_name
  sonarqube_is_blind_connection = var.ci_sonarqube_is_blind_connection
  sonarqube_server_url          = var.ci_sonarqube_server_url

  #COS INTEGRATION
  cos_endpoint    = (var.ci_cos_endpoint == "") ? var.cos_endpoint : var.ci_cos_endpoint
  cos_bucket_name = (var.ci_cos_bucket_name == "") ? var.cos_bucket_name : var.ci_cos_bucket_name

  #EVENT NOTIFICATIONS
  event_notifications_crn       = (var.ci_event_notifications_crn == "") ? var.event_notifications_crn : var.ci_event_notifications_crn
  event_notifications_tool_name = var.event_notifications_tool_name

  #INTEGRATION NAMES
  sm_integration_name    = var.sm_integration_name
  kp_integration_name    = var.kp_integration_name
  slack_integration_name = var.slack_integration_name

  #DEVOPS INSIGHTS
  link_to_doi_toolchain = var.ci_link_to_doi_toolchain

  #TRIGGER PROPERTIES
  trigger_git_name             = var.ci_trigger_git_name
  trigger_git_enable           = var.ci_trigger_git_enable
  trigger_timed_name           = var.ci_trigger_timed_name
  trigger_timed_enable         = var.ci_trigger_timed_enable
  trigger_timed_cron_schedule  = var.ci_trigger_timed_cron_schedule
  trigger_manual_name          = var.ci_trigger_manual_name
  trigger_manual_enable        = var.ci_trigger_manual_enable
  trigger_pr_git_name          = var.ci_trigger_pr_git_name
  trigger_pr_git_enable        = var.ci_trigger_pr_git_enable
  trigger_manual_pruner_name   = var.ci_trigger_manual_pruner_name
  trigger_manual_pruner_enable = var.ci_trigger_manual_pruner_enable
  trigger_timed_pruner_name    = var.ci_trigger_timed_pruner_name
  trigger_timed_pruner_enable  = var.ci_trigger_timed_pruner_enable
}

module "devsecops_cd_toolchain" {
  count            = var.create_cd_toolchain ? 1 : 0
  source           = "git::https://github.com/terraform-ibm-modules/terraform-ibm-devsecops-cd-toolchain?ref=v1.2.1"
  ibmcloud_api_key = var.ibmcloud_api_key

  toolchain_name           = (var.cd_toolchain_name == "") ? format("${var.toolchain_name}%s", "-CD-Toolchain") : var.cd_toolchain_name
  toolchain_description    = var.cd_toolchain_description
  toolchain_region         = (var.cd_toolchain_region == "") ? var.toolchain_region : replace(replace(var.cd_toolchain_region, "ibm:yp:", ""), "ibm:ys1:", "")
  toolchain_resource_group = (var.cd_toolchain_resource_group == "") ? var.toolchain_resource_group : var.cd_toolchain_resource_group
  ibmcloud_api             = var.ibmcloud_api
  compliance_base_image    = (var.cd_compliance_base_image == "") ? var.compliance_base_image : var.cd_compliance_base_image
  pipeline_branch          = (var.cd_compliance_pipeline_branch == "") ? var.compliance_pipeline_branch : var.cd_compliance_pipeline_branch
  pipeline_git_tag         = (var.cd_pipeline_git_tag == "") ? var.pipeline_git_tag : var.cd_pipeline_git_tag

  #SECRET PROVIDERS
  enable_key_protect     = (local.use_kp_override) ? var.enable_key_protect : var.cd_enable_key_protect
  enable_secrets_manager = (local.use_sm_override) ? var.enable_secrets_manager : var.cd_enable_secrets_manager
  sm_name                = (var.cd_sm_name == "") ? var.sm_name : var.cd_sm_name
  sm_location            = (var.cd_sm_location == "") ? replace(replace(var.sm_location, "ibm:yp:", ""), "ibm:ys1:", "") : replace(replace(var.cd_sm_location, "ibm:yp:", ""), "ibm:ys1:", "")
  sm_resource_group      = (var.cd_sm_resource_group != "") ? var.cd_sm_resource_group : (var.sm_resource_group != "") ? var.sm_resource_group : var.toolchain_resource_group
  sm_secret_group        = (var.cd_sm_secret_group == "") ? var.sm_secret_group : var.cd_sm_secret_group
  kp_name                = (var.cd_kp_name == "") ? var.kp_name : var.cd_kp_name
  kp_location            = (var.cd_kp_location == "") ? replace(replace(var.kp_location, "ibm:yp:", ""), "ibm:ys1:", "") : replace(replace(var.cd_kp_location, "ibm:yp:", ""), "ibm:ys1:", "")
  kp_resource_group      = (var.cd_kp_resource_group != "") ? var.cd_kp_resource_group : (var.kp_resource_group != "") ? var.kp_resource_group : var.toolchain_resource_group
  sm_instance_crn        = (var.cd_sm_instance_crn != "") ? var.cd_sm_instance_crn : var.sm_instance_crn

  #SECRET NAMES AND SECRET GROUPS
  pipeline_ibmcloud_api_key_secret_name  = (var.cd_pipeline_ibmcloud_api_key_secret_name == "") ? var.pipeline_ibmcloud_api_key_secret_name : var.cd_pipeline_ibmcloud_api_key_secret_name
  pipeline_ibmcloud_api_key_secret_group = var.cd_pipeline_ibmcloud_api_key_secret_group

  cos_api_key_secret_name  = (var.cd_cos_api_key_secret_name == "") ? var.cos_api_key_secret_name : var.cd_cos_api_key_secret_name
  cos_api_key_secret_group = var.cd_cos_api_key_secret_group

  issues_repo_git_token_secret_name = (var.cd_issues_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : var.cd_issues_repo_git_token_secret_name
  issues_repo_secret_group          = (var.cd_issues_repo_secret_group == "") ? var.repo_secret_group : var.cd_issues_repo_secret_group

  evidence_repo_git_token_secret_name = (var.cd_evidence_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : var.cd_evidence_repo_git_token_secret_name
  evidence_repo_secret_group          = (var.cd_evidence_repo_secret_group == "") ? var.repo_secret_group : var.cd_evidence_repo_secret_group

  inventory_repo_git_token_secret_name = (var.cd_inventory_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : var.cd_inventory_repo_git_token_secret_name
  inventory_repo_secret_group          = (var.cd_inventory_repo_secret_group == "") ? var.repo_secret_group : var.cd_inventory_repo_secret_group

  compliance_pipeline_repo_git_token_secret_name = (var.cd_compliance_pipeline_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : var.cd_compliance_pipeline_repo_git_token_secret_name
  compliance_pipeline_repo_secret_group          = (var.cd_compliance_pipeline_repo_secret_group == "") ? var.repo_secret_group : var.cd_compliance_pipeline_repo_secret_group

  pipeline_config_repo_git_token_secret_name = (var.cd_pipeline_config_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : var.cd_pipeline_config_repo_git_token_secret_name
  pipeline_config_repo_secret_group          = (var.cd_pipeline_config_repo_secret_group == "") ? var.repo_secret_group : var.cd_pipeline_config_repo_secret_group

  deployment_repo_git_token_secret_name = (var.cd_deployment_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : var.cd_deployment_repo_git_token_secret_name
  deployment_repo_secret_group          = (var.cd_deployment_repo_secret_group == "") ? var.repo_secret_group : var.cd_deployment_repo_secret_group

  change_management_repo_git_token_secret_name = (var.cd_change_management_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : var.cd_change_management_repo_git_token_secret_name
  change_management_repo_secret_group          = (var.cd_change_management_repo_secret_group == "") ? var.repo_secret_group : var.cd_change_management_repo_secret_group

  slack_webhook_secret_name  = (var.cd_slack_webhook_secret_name == "") ? var.slack_webhook_secret_name : var.cd_slack_webhook_secret_name
  slack_webhook_secret_group = var.cd_slack_webhook_secret_group

  scc_scc_api_key_secret_name  = var.scc_scc_api_key_secret_name
  scc_scc_api_key_secret_group = var.scc_scc_api_key_secret_group

  pipeline_git_token_secret_name  = var.cd_pipeline_git_token_secret_name
  pipeline_git_token_secret_group = var.cd_pipeline_git_token_secret_group

  pipeline_doi_api_key_secret_name  = (var.cd_pipeline_doi_api_key_secret_name == "") ? var.pipeline_doi_api_key_secret_name : var.cd_pipeline_doi_api_key_secret_name
  pipeline_doi_api_key_secret_group = (var.cd_pipeline_doi_api_key_secret_group == "") ? var.pipeline_doi_api_key_secret_group : var.cd_pipeline_doi_api_key_secret_group

  code_signing_cert_secret_name  = var.cd_code_signing_cert_secret_name
  code_signing_cert_secret_group = var.cd_code_signing_cert_secret_group

  # CRN SECRETS
  deployment_repo_git_token_secret_crn          = (var.cd_deployment_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : var.cd_deployment_repo_git_token_secret_crn
  change_management_repo_git_token_secret_crn   = (var.cd_change_management_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : var.cd_change_management_repo_git_token_secret_crn
  issues_repo_git_token_secret_crn              = (var.cd_issues_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : var.cd_issues_repo_git_token_secret_crn
  evidence_repo_git_token_secret_crn            = (var.cd_evidence_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : var.cd_evidence_repo_git_token_secret_crn
  inventory_repo_git_token_secret_crn           = (var.cd_inventory_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : var.cd_inventory_repo_git_token_secret_crn
  compliance_pipeline_repo_git_token_secret_crn = (var.cd_compliance_pipeline_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : var.cd_compliance_pipeline_repo_git_token_secret_crn
  pipeline_config_repo_git_token_secret_crn     = (var.cd_pipeline_config_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : var.cd_pipeline_config_repo_git_token_secret_crn
  cos_api_key_secret_crn                        = (var.cd_cos_api_key_secret_crn == "") ? var.cos_api_key_secret_crn : var.cd_cos_api_key_secret_crn
  pipeline_ibmcloud_api_key_secret_crn          = (var.cd_pipeline_ibmcloud_api_key_secret_crn == "") ? var.pipeline_ibmcloud_api_key_secret_crn : var.cd_pipeline_ibmcloud_api_key_secret_crn
  slack_webhook_secret_crn                      = (var.cd_slack_webhook_secret_crn == "") ? var.slack_webhook_secret_crn : var.cd_slack_webhook_secret_crn
  privateworker_credentials_secret_crn          = var.cd_privateworker_credentials_secret_crn
  artifactory_token_secret_crn                  = var.cd_artifactory_token_secret_crn
  code_signing_cert_secret_crn                  = var.cd_code_signing_cert_secret_crn
  scc_scc_api_key_secret_crn                    = var.scc_scc_api_key_secret_crn
  pipeline_git_token_secret_crn                 = var.cd_pipeline_git_token_secret_crn
  pipeline_doi_api_key_secret_crn               = (var.cd_pipeline_doi_api_key_secret_crn == "") ? var.pipeline_doi_api_key_secret_crn : var.cd_pipeline_doi_api_key_secret_crn

  #AUTH TYPE FOR REPOS
  pipeline_config_repo_auth_type     = (var.cd_pipeline_config_repo_auth_type == "") ? local.repo_auth_type : var.cd_pipeline_config_repo_auth_type
  inventory_repo_auth_type           = (var.cd_inventory_repo_auth_type == "") ? local.repo_auth_type : var.cd_inventory_repo_auth_type
  issues_repo_auth_type              = (var.cd_issues_repo_auth_type == "") ? local.repo_auth_type : var.cd_issues_repo_auth_type
  evidence_repo_auth_type            = (var.cd_evidence_repo_auth_type == "") ? local.repo_auth_type : var.cd_evidence_repo_auth_type
  deployment_repo_auth_type          = (var.cd_deployment_repo_auth_type == "") ? local.repo_auth_type : var.cd_deployment_repo_auth_type
  compliance_pipeline_repo_auth_type = (var.cd_compliance_pipeline_repo_auth_type == "") ? local.repo_auth_type : var.cd_compliance_pipeline_repo_auth_type
  change_management_repo_auth_type   = (var.cd_change_management_repo_auth_type == "") ? local.repo_auth_type : var.cd_change_management_repo_auth_type

  #GROUPS/USERS FOR REPOS
  issues_group              = (var.cd_issues_group == "") ? var.repo_group : var.cd_issues_group
  inventory_group           = (var.cd_inventory_group == "") ? var.repo_group : var.cd_inventory_group
  evidence_group            = (var.cd_evidence_group == "") ? var.repo_group : var.cd_evidence_group
  pipeline_config_group     = (var.cd_pipeline_config_group == "") ? var.repo_group : var.cd_pipeline_config_group
  compliance_pipeline_group = (var.cd_compliance_pipeline_group == "") ? var.repo_group : var.cd_compliance_pipeline_group
  deployment_group          = (var.cd_deployment_group == "") ? var.repo_group : var.cd_deployment_group
  change_management_group   = (var.cd_change_management_group == "") ? var.repo_group : var.cd_change_management_group

  #PIPELINE CONFIG REPO
  pipeline_config_repo_existing_url   = var.cd_pipeline_config_repo_existing_url
  pipeline_config_repo_clone_from_url = var.cd_pipeline_config_repo_clone_from_url
  pipeline_config_repo_branch         = var.cd_pipeline_config_repo_branch
  pipeline_config_path                = var.cd_pipeline_config_path

  #EVIDENCE REPO
  evidence_repo_name              = var.evidence_repo_name
  evidence_repo_url               = try(module.devsecops_ci_toolchain[0].evidence_repo_url, local.evidence_repo_existing_url)
  evidence_repo_git_provider      = var.evidence_repo_existing_git_provider
  evidence_repo_git_id            = var.evidence_repo_existing_git_id
  evidence_repo_integration_owner = var.evidence_repo_integration_owner

  #ISSUES REPO
  issues_repo_name              = var.issues_repo_name
  issues_repo_url               = try(module.devsecops_ci_toolchain[0].issues_repo_url, local.issues_repo_existing_url)
  issues_repo_git_provider      = var.issues_repo_existing_git_provider
  issues_repo_git_id            = var.issues_repo_existing_git_id
  issues_repo_integration_owner = var.issues_repo_integration_owner

  #INVENTORY REPO
  inventory_repo_name              = var.inventory_repo_name
  inventory_repo_url               = try(module.devsecops_ci_toolchain[0].inventory_repo_url, local.inventory_repo_existing_url)
  inventory_repo_git_provider      = var.inventory_repo_existing_git_provider
  inventory_repo_git_id            = var.inventory_repo_existing_git_id
  inventory_repo_integration_owner = var.inventory_repo_integration_owner

  #CHANGE MANAGEMENT REPO
  change_repo_clone_from_url = var.cd_change_repo_clone_from_url

  #DEPLOYMENT REPO
  deployment_repo_existing_git_provider = (var.cd_deployment_repo_existing_git_provider == "") ? try(module.devsecops_ci_toolchain[0].app_repo_git_provider, "") : var.cd_deployment_repo_existing_git_provider
  deployment_repo_existing_git_id       = (var.cd_deployment_repo_existing_git_id == "") ? try(module.devsecops_ci_toolchain[0].app_repo_git_id, "") : var.cd_deployment_repo_existing_git_id
  deployment_repo_clone_to_git_provider = var.cd_deployment_repo_clone_to_git_provider
  deployment_repo_clone_to_git_id       = var.cd_deployment_repo_clone_to_git_id
  deployment_repo_clone_from_url        = var.cd_deployment_repo_clone_from_url
  deployment_repo_clone_from_branch     = var.cd_deployment_repo_clone_from_branch
  deployment_repo_existing_url          = (var.cd_deployment_repo_existing_url == "") ? try(module.devsecops_ci_toolchain[0].app_repo_url, "") : var.cd_deployment_repo_existing_url
  deployment_repo_existing_branch       = (var.cd_deployment_repo_existing_branch == "") ? try(module.devsecops_ci_toolchain[0].app_repo_branch, "") : var.cd_deployment_repo_existing_branch

  #SCC
  scc_enable_scc       = var.cd_scc_enable_scc
  scc_integration_name = var.cd_scc_integration_name

  #OTHER INTEGRATIONS
  slack_notifications           = local.cd_slack_notification_state
  repositories_prefix           = (var.cd_repositories_prefix == "") ? var.repositories_prefix : var.cd_repositories_prefix
  authorization_policy_creation = (var.cd_authorization_policy_creation == "") ? var.authorization_policy_creation : var.cd_authorization_policy_creation
  doi_environment               = var.cd_doi_environment
  link_to_doi_toolchain         = var.cd_link_to_doi_toolchain
  doi_toolchain_id              = try(module.devsecops_ci_toolchain[0].toolchain_id, var.cd_doi_toolchain_id)
  target_environment_detail     = var.cd_target_environment_detail
  customer_impact               = var.cd_customer_impact
  target_environment_purpose    = var.cd_target_environment_purpose
  change_request_id             = var.cd_change_request_id
  source_environment            = var.cd_source_environment
  target_environment            = var.cd_target_environment
  merge_cra_sbom                = var.cd_merge_cra_sbom
  emergency_label               = var.cd_emergency_label
  app_version                   = var.cd_app_version
  pipeline_debug                = var.cd_pipeline_debug
  region                        = (var.cd_region == "") ? var.toolchain_region : var.cd_region
  peer_review_compliance        = (var.cd_peer_review_compliance == "") ? var.peer_review_compliance : var.cd_peer_review_compliance
  scc_attachment_id             = var.scc_attachment_id
  scc_instance_crn              = var.scc_instance_crn
  scc_profile_name              = var.scc_profile_name
  scc_profile_version           = var.scc_profile_version
  scc_use_profile_attachment    = (var.cd_scc_use_profile_attachment == "") ? var.scc_use_profile_attachment : var.cd_scc_use_profile_attachment

  #SLACK INTEGRATION
  enable_slack           = (local.use_slack_enable_override) ? local.enable_slack : var.cd_enable_slack
  slack_channel_name     = (var.cd_slack_channel_name == "") ? var.slack_channel_name : var.cd_slack_channel_name
  slack_team_name        = (var.cd_slack_team_name == "") ? var.slack_team_name : var.cd_slack_team_name
  slack_pipeline_fail    = var.cd_slack_pipeline_fail
  slack_pipeline_start   = var.cd_slack_pipeline_start
  slack_pipeline_success = var.cd_slack_pipeline_success
  slack_toolchain_bind   = var.cd_slack_toolchain_bind
  slack_toolchain_unbind = var.cd_slack_toolchain_unbind

  #COS INTEGRATION
  cos_endpoint    = (var.cd_cos_endpoint == "") ? var.cos_endpoint : var.cd_cos_endpoint
  cos_bucket_name = (var.cd_cos_bucket_name == "") ? var.cos_bucket_name : var.cd_cos_bucket_name

  #EVENT NOTIFICATIONS
  event_notifications_crn       = (var.cd_event_notifications_crn == "") ? var.event_notifications_crn : var.cd_event_notifications_crn
  event_notifications_tool_name = var.event_notifications_tool_name

  #INTEGRATION NAMES
  sm_integration_name    = var.sm_integration_name
  kp_integration_name    = var.kp_integration_name
  slack_integration_name = var.slack_integration_name

  #TRIGGER PROPERTIES
  trigger_git_name                      = var.cd_trigger_git_name
  trigger_git_enable                    = var.cd_trigger_git_enable
  trigger_git_promotion_listener        = var.cd_trigger_git_promotion_validation_listener
  trigger_git_promotion_enable          = var.cd_trigger_git_promotion_validation_enable
  trigger_git_promotion_branch          = var.cd_trigger_git_promotion_validation_branch
  trigger_git_promotion_validation_name = var.cd_trigger_git_promotion_validation_name
  trigger_timed_name                    = var.cd_trigger_timed_name
  trigger_timed_enable                  = var.cd_trigger_timed_enable
  trigger_timed_cron_schedule           = var.cd_trigger_timed_cron_schedule
  trigger_manual_name                   = var.cd_trigger_manual_name
  trigger_manual_enable                 = var.cd_trigger_manual_enable
  trigger_manual_promotion_name         = var.cd_trigger_manual_promotion_name
  trigger_manual_promotion_enable       = var.cd_trigger_manual_promotion_enable
  trigger_manual_pruner_name            = var.cd_trigger_manual_pruner_name
  trigger_manual_pruner_enable          = var.cd_trigger_manual_pruner_enable
  trigger_timed_pruner_name             = var.cd_trigger_timed_pruner_name
  trigger_timed_pruner_enable           = var.cd_trigger_timed_pruner_enable

  #CODE ENGINE
  deployment_target                  = (var.cd_deployment_target == "") ? var.deployment_target : var.cd_deployment_target
  code_engine_project                = local.cd_code_engine_project_name
  code_engine_region                 = (var.cd_code_engine_region == "") ? var.toolchain_region : var.cd_code_engine_region
  code_engine_resource_group         = (var.cd_code_engine_resource_group == "") ? var.toolchain_resource_group : var.cd_code_engine_resource_group
  code_engine_binding_resource_group = var.cd_code_engine_binding_resource_group
  code_engine_deployment_type        = var.cd_code_engine_deployment_type
  code_engine_cpu                    = var.cd_code_engine_cpu
  code_engine_memory                 = var.cd_code_engine_memory
  code_engine_ephemeral_storage      = var.cd_code_engine_ephemeral_storage
  code_engine_job_maxexecutiontime   = var.cd_code_engine_job_maxexecutiontime
  code_engine_job_retrylimit         = var.cd_code_engine_job_retrylimit
  code_engine_job_instances          = var.cd_code_engine_job_instances
  code_engine_app_port               = var.cd_code_engine_app_port
  code_engine_app_min_scale          = var.cd_code_engine_app_min_scale
  code_engine_app_max_scale          = var.cd_code_engine_app_max_scale
  code_engine_app_deployment_timeout = var.cd_code_engine_app_deployment_timeout
  code_engine_app_concurrency        = var.cd_code_engine_app_concurrency
  code_engine_app_visibility         = var.cd_code_engine_app_visibility
  code_engine_env_from_configmaps    = var.cd_code_engine_env_from_configmaps
  code_engine_env_from_secrets       = var.cd_code_engine_env_from_secrets
  code_engine_remove_refs            = var.cd_code_engine_remove_refs
  code_engine_service_bindings       = var.cd_code_engine_service_bindings
}

module "devsecops_cc_toolchain" {
  count                         = var.create_cc_toolchain ? 1 : 0
  source                        = "git::https://github.com/terraform-ibm-modules/terraform-ibm-devsecops-cc-toolchain?ref=v1.2.0"
  ibmcloud_api_key              = var.ibmcloud_api_key
  toolchain_name                = (var.cc_toolchain_name == "") ? format("${var.toolchain_name}%s", "-CC-Toolchain") : var.cc_toolchain_name
  toolchain_description         = var.cc_toolchain_description
  toolchain_region              = (var.cc_toolchain_region == "") ? var.toolchain_region : replace(replace(var.cc_toolchain_region, "ibm:yp:", ""), "ibm:ys1:", "")
  toolchain_resource_group      = (var.cc_toolchain_resource_group == "") ? var.toolchain_resource_group : var.cc_toolchain_resource_group
  ibmcloud_api                  = var.ibmcloud_api
  compliance_base_image         = (var.cc_compliance_base_image == "") ? var.compliance_base_image : var.cc_compliance_base_image
  authorization_policy_creation = (var.cc_authorization_policy_creation == "") ? var.authorization_policy_creation : var.cc_authorization_policy_creation
  pipeline_branch               = (var.cc_compliance_pipeline_branch == "") ? var.compliance_pipeline_branch : var.cc_compliance_pipeline_branch
  pipeline_git_tag              = (var.cc_pipeline_git_tag == "") ? var.pipeline_git_tag : var.cc_pipeline_git_tag

  #SECRET PROVIDERS
  enable_key_protect     = (local.use_kp_override) ? var.enable_key_protect : var.cc_enable_key_protect
  enable_secrets_manager = (local.use_sm_override) ? var.enable_secrets_manager : var.cc_enable_secrets_manager
  sm_name                = (var.cc_sm_name == "") ? var.sm_name : var.cc_sm_name
  sm_location            = (var.cc_sm_location == "") ? replace(replace(var.sm_location, "ibm:yp:", ""), "ibm:ys1:", "") : replace(replace(var.cc_sm_location, "ibm:yp:", ""), "ibm:ys1:", "")
  sm_resource_group      = (var.cc_sm_resource_group != "") ? var.cc_sm_resource_group : (var.sm_resource_group != "") ? var.sm_resource_group : var.toolchain_resource_group
  sm_secret_group        = (var.cc_sm_secret_group == "") ? var.sm_secret_group : var.cc_sm_secret_group
  kp_name                = (var.cc_kp_name == "") ? var.kp_name : var.cc_kp_name
  kp_location            = (var.cc_sm_location == "") ? replace(replace(var.kp_location, "ibm:yp:", ""), "ibm:ys1:", "") : replace(replace(var.cc_kp_location, "ibm:yp:", ""), "ibm:ys1:", "")
  kp_resource_group      = (var.cc_kp_resource_group != "") ? var.cc_kp_resource_group : (var.kp_resource_group != "") ? var.kp_resource_group : var.toolchain_resource_group
  sm_instance_crn        = (var.cc_sm_instance_crn != "") ? var.cc_sm_instance_crn : var.sm_instance_crn

  #SECRET NAMES AND SECRET GROUPS
  pipeline_ibmcloud_api_key_secret_name  = (var.cc_pipeline_ibmcloud_api_key_secret_name == "") ? var.pipeline_ibmcloud_api_key_secret_name : var.cc_pipeline_ibmcloud_api_key_secret_name
  pipeline_ibmcloud_api_key_secret_group = var.cc_pipeline_ibmcloud_api_key_secret_group

  cos_api_key_secret_name  = (var.cc_cos_api_key_secret_name == "") ? var.cos_api_key_secret_name : var.cc_cos_api_key_secret_name
  cos_api_key_secret_group = var.cc_cos_api_key_secret_group

  issues_repo_git_token_secret_name = (var.cc_issues_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : var.cc_issues_repo_git_token_secret_name
  issues_repo_secret_group          = (var.cc_issues_repo_secret_group == "") ? var.repo_secret_group : var.cc_issues_repo_secret_group

  evidence_repo_git_token_secret_name = (var.cc_evidence_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : var.cc_evidence_repo_git_token_secret_name
  evidence_repo_secret_group          = (var.cc_evidence_repo_secret_group == "") ? var.repo_secret_group : var.cc_evidence_repo_secret_group

  inventory_repo_git_token_secret_name = (var.cc_inventory_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : var.cc_inventory_repo_git_token_secret_name
  inventory_repo_secret_group          = (var.cc_inventory_repo_secret_group == "") ? var.repo_secret_group : var.cc_inventory_repo_secret_group

  compliance_pipeline_repo_git_token_secret_name = (var.cc_compliance_pipeline_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : var.cc_compliance_pipeline_repo_git_token_secret_name
  compliance_pipeline_repo_secret_group          = (var.cc_compliance_pipeline_repo_secret_group == "") ? var.repo_secret_group : var.cc_compliance_pipeline_repo_secret_group

  pipeline_config_repo_git_token_secret_name = (var.cc_pipeline_config_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : var.cc_pipeline_config_repo_git_token_secret_name
  pipeline_config_repo_secret_group          = (var.cc_pipeline_config_repo_secret_group == "") ? var.repo_secret_group : var.cc_pipeline_config_repo_secret_group

  app_repo_git_token_secret_name = (var.cc_app_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : var.cc_app_repo_git_token_secret_name
  app_repo_secret_group          = (var.cc_app_repo_secret_group == "") ? var.repo_secret_group : var.cc_app_repo_secret_group

  slack_webhook_secret_name  = (var.cc_slack_webhook_secret_name == "") ? var.slack_webhook_secret_name : var.cc_slack_webhook_secret_name
  slack_webhook_secret_group = var.cc_slack_webhook_secret_group

  pipeline_dockerconfigjson_secret_name  = var.cc_pipeline_dockerconfigjson_secret_name
  pipeline_dockerconfigjson_secret_group = var.cc_pipeline_dockerconfigjson_secret_group

  scc_scc_api_key_secret_name  = var.scc_scc_api_key_secret_name
  scc_scc_api_key_secret_group = var.scc_scc_api_key_secret_group

  gosec_private_repository_ssh_key_secret_name  = (var.cc_gosec_repo_ssh_key_secret_name == "") ? var.gosec_repo_ssh_key_secret_name : var.cc_gosec_repo_ssh_key_secret_name
  gosec_private_repository_ssh_key_secret_group = (var.cc_gosec_repo_ssh_key_secret_group == "") ? var.gosec_repo_ssh_key_secret_group : var.cc_gosec_repo_ssh_key_secret_group

  pipeline_doi_api_key_secret_name  = (var.cc_pipeline_doi_api_key_secret_name == "") ? var.pipeline_doi_api_key_secret_name : var.cc_pipeline_doi_api_key_secret_name
  pipeline_doi_api_key_secret_group = (var.cc_pipeline_doi_api_key_secret_group == "") ? var.pipeline_doi_api_key_secret_group : var.cc_pipeline_doi_api_key_secret_group

  # CRN SECRETS
  app_repo_git_token_secret_crn                 = (var.cc_app_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : var.cc_app_repo_git_token_secret_crn
  issues_repo_git_token_secret_crn              = (var.cc_issues_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : var.cc_issues_repo_git_token_secret_crn
  evidence_repo_git_token_secret_crn            = (var.cc_evidence_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : var.cc_evidence_repo_git_token_secret_crn
  inventory_repo_git_token_secret_crn           = (var.cc_inventory_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : var.cc_inventory_repo_git_token_secret_crn
  compliance_pipeline_repo_git_token_secret_crn = (var.cc_compliance_pipeline_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : var.cc_compliance_pipeline_repo_git_token_secret_crn
  pipeline_config_repo_git_token_secret_crn     = (var.cc_pipeline_config_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : var.cc_pipeline_config_repo_git_token_secret_crn
  cos_api_key_secret_crn                        = (var.cc_cos_api_key_secret_crn == "") ? var.cos_api_key_secret_crn : var.cc_cos_api_key_secret_crn
  pipeline_ibmcloud_api_key_secret_crn          = (var.cc_pipeline_ibmcloud_api_key_secret_crn == "") ? var.pipeline_ibmcloud_api_key_secret_crn : var.cc_pipeline_ibmcloud_api_key_secret_crn
  pipeline_dockerconfigjson_secret_crn          = var.cc_pipeline_dockerconfigjson_secret_crn
  slack_webhook_secret_crn                      = (var.cc_slack_webhook_secret_crn == "") ? var.slack_webhook_secret_crn : var.cc_slack_webhook_secret_crn
  artifactory_token_secret_crn                  = var.cc_artifactory_token_secret_crn
  pipeline_git_token_secret_crn                 = var.cc_pipeline_git_token_secret_crn
  scc_scc_api_key_secret_crn                    = var.scc_scc_api_key_secret_crn
  sonarqube_secret_crn                          = (var.cc_sonarqube_secret_crn == "") ? var.sonarqube_secret_crn : var.cc_sonarqube_secret_crn
  pipeline_doi_api_key_secret_crn               = (var.cc_pipeline_doi_api_key_secret_crn == "") ? var.pipeline_doi_api_key_secret_crn : var.cc_pipeline_doi_api_key_secret_crn
  gosec_private_repository_ssh_key_secret_crn   = (var.cc_gosec_private_repository_ssh_key_secret_crn == "") ? var.gosec_private_repository_ssh_key_secret_crn : var.cc_gosec_private_repository_ssh_key_secret_crn

  #AUTH TYPE FOR REPOS
  pipeline_config_repo_auth_type     = (var.cc_pipeline_config_repo_auth_type == "") ? local.repo_auth_type : var.cc_pipeline_config_repo_auth_type
  inventory_repo_auth_type           = (var.cc_inventory_repo_auth_type == "") ? local.repo_auth_type : var.cc_inventory_repo_auth_type
  issues_repo_auth_type              = (var.cc_issues_repo_auth_type == "") ? local.repo_auth_type : var.cc_issues_repo_auth_type
  evidence_repo_auth_type            = (var.cc_evidence_repo_auth_type == "") ? local.repo_auth_type : var.cc_evidence_repo_auth_type
  app_repo_auth_type                 = (var.cc_app_repo_auth_type == "") ? local.repo_auth_type : var.cc_app_repo_auth_type
  compliance_pipeline_repo_auth_type = (var.cc_compliance_pipeline_repo_auth_type == "") ? local.repo_auth_type : var.cc_compliance_pipeline_repo_auth_type

  #GROUPS/USERS FOR REPOS
  issues_group              = (var.cc_issues_group == "") ? var.repo_group : var.cc_issues_group
  inventory_group           = (var.cc_inventory_group == "") ? var.repo_group : var.cc_inventory_group
  evidence_group            = (var.cc_evidence_group == "") ? var.repo_group : var.cc_evidence_group
  pipeline_config_group     = (var.cc_pipeline_config_group == "") ? var.repo_group : var.cc_pipeline_config_group
  compliance_pipeline_group = (var.cc_compliance_pipeline_group == "") ? var.repo_group : var.cc_compliance_pipeline_group
  app_group                 = (var.cc_app_group == "") ? var.repo_group : var.cc_app_group

  doi_environment       = var.cc_doi_environment
  link_to_doi_toolchain = var.cc_link_to_doi_toolchain

  #PIPELINE CONFIG REPO
  pipeline_config_repo_existing_url   = var.cc_pipeline_config_repo_existing_url
  pipeline_config_repo_clone_from_url = var.cc_pipeline_config_repo_clone_from_url
  pipeline_config_repo_branch         = var.cc_pipeline_config_repo_branch
  pipeline_config_path                = var.cc_pipeline_config_path

  #APP REPO
  app_repo_url          = try(module.devsecops_ci_toolchain[0].app_repo_url, var.cc_app_repo_url)
  app_repo_git_provider = try(module.devsecops_ci_toolchain[0].app_repo_git_provider, var.cc_app_repo_git_provider)
  app_repo_branch       = try(module.devsecops_ci_toolchain[0].app_repo_branch, var.cc_app_repo_branch)
  app_repo_git_id       = try(module.devsecops_ci_toolchain[0].app_repo_git_id, var.cc_app_repo_git_id)

  #EVIDENCE REPO
  evidence_repo_name              = var.evidence_repo_name
  evidence_repo_url               = try(module.devsecops_ci_toolchain[0].evidence_repo_url, local.evidence_repo_existing_url)
  evidence_repo_git_provider      = var.evidence_repo_existing_git_provider
  evidence_repo_git_id            = var.evidence_repo_existing_git_id
  evidence_repo_integration_owner = var.evidence_repo_integration_owner

  #ISSUES REPO
  issues_repo_name              = var.issues_repo_name
  issues_repo_url               = try(module.devsecops_ci_toolchain[0].issues_repo_url, local.issues_repo_existing_url)
  issues_repo_git_provider      = var.issues_repo_existing_git_provider
  issues_repo_git_id            = var.issues_repo_existing_git_id
  issues_repo_integration_owner = var.issues_repo_integration_owner

  #INVENTORY REPO
  inventory_repo_name              = var.inventory_repo_name
  inventory_repo_url               = try(module.devsecops_ci_toolchain[0].inventory_repo_url, local.inventory_repo_existing_url)
  inventory_repo_git_provider      = var.inventory_repo_existing_git_provider
  inventory_repo_git_id            = var.inventory_repo_existing_git_id
  inventory_repo_integration_owner = var.inventory_repo_integration_owner

  #SCC
  scc_enable_scc       = var.cc_scc_enable_scc
  scc_integration_name = var.cc_scc_integration_name

  #OTHER INTEGRATIONS
  slack_notifications              = local.cc_slack_notification_state
  sonarqube_config                 = var.cc_sonarqube_config
  repositories_prefix              = (var.cc_repositories_prefix == "") ? var.repositories_prefix : var.cc_repositories_prefix
  doi_toolchain_id                 = try(module.devsecops_ci_toolchain[0].toolchain_id, var.cc_doi_toolchain_id)
  pipeline_debug                   = var.cc_pipeline_debug
  opt_in_dynamic_api_scan          = var.cc_opt_in_dynamic_api_scan
  opt_in_dynamic_ui_scan           = var.cc_opt_in_dynamic_ui_scan
  opt_in_dynamic_scan              = var.cc_opt_in_dynamic_scan
  opt_in_auto_close                = var.cc_opt_in_auto_close
  environment_tag                  = (var.cc_environment_tag == "") ? format("%s_prod_latest", var.toolchain_region) : var.cc_environment_tag
  enable_pipeline_dockerconfigjson = var.cc_enable_pipeline_dockerconfigjson
  peer_review_compliance           = (var.cc_peer_review_compliance == "") ? var.peer_review_compliance : var.cc_peer_review_compliance
  scc_attachment_id                = var.scc_attachment_id
  scc_instance_crn                 = var.scc_instance_crn
  scc_profile_name                 = var.scc_profile_name
  scc_profile_version              = var.scc_profile_version
  scc_use_profile_attachment       = (var.cc_scc_use_profile_attachment == "") ? var.scc_use_profile_attachment : var.cc_scc_use_profile_attachment

  #SLACK INTEGRATION
  enable_slack           = (local.use_slack_enable_override) ? local.enable_slack : var.cc_enable_slack
  slack_channel_name     = (var.cc_slack_channel_name == "") ? var.slack_channel_name : var.cc_slack_channel_name
  slack_team_name        = (var.cc_slack_team_name == "") ? var.slack_team_name : var.cc_slack_team_name
  slack_pipeline_fail    = var.cc_slack_pipeline_fail
  slack_pipeline_start   = var.cc_slack_pipeline_start
  slack_pipeline_success = var.cc_slack_pipeline_success
  slack_toolchain_bind   = var.cc_slack_toolchain_bind
  slack_toolchain_unbind = var.cc_slack_toolchain_unbind

  #COS INTEGRATION
  cos_endpoint    = (var.cc_cos_endpoint == "") ? var.cos_endpoint : var.cc_cos_endpoint
  cos_bucket_name = (var.cc_cos_bucket_name == "") ? var.cos_bucket_name : var.cc_cos_bucket_name

  #EVENT NOTIFICATIONS
  event_notifications_crn       = (var.cc_event_notifications_crn == "") ? var.event_notifications_crn : var.cc_event_notifications_crn
  event_notifications_tool_name = var.event_notifications_tool_name

  #INTEGRATION NAMES
  sm_integration_name    = var.sm_integration_name
  kp_integration_name    = var.kp_integration_name
  slack_integration_name = var.slack_integration_name

  #GOSEC
  gosec_private_repository_host = (var.cc_gosec_private_repository_host == "") ? var.gosec_private_repository_host : var.cc_gosec_private_repository_host
  opt_in_gosec                  = (var.cc_opt_in_gosec == "") ? var.opt_in_gosec : var.cc_opt_in_gosec

  #SONARQUBE
  sonarqube_integration_name    = var.cc_sonarqube_integration_name
  sonarqube_user                = var.cc_sonarqube_user
  sonarqube_secret_name         = var.cc_sonarqube_secret_name
  sonarqube_is_blind_connection = var.cc_sonarqube_is_blind_connection
  sonarqube_server_url          = var.cc_sonarqube_server_url

  #TRIGGER PROPERTIES
  trigger_timed_name           = var.cc_trigger_timed_name
  trigger_timed_enable         = var.cc_trigger_timed_enable
  trigger_timed_cron_schedule  = var.cc_trigger_timed_cron_schedule
  trigger_manual_name          = var.cc_trigger_manual_name
  trigger_manual_enable        = var.cc_trigger_manual_enable
  trigger_manual_pruner_name   = var.cc_trigger_manual_pruner_name
  trigger_manual_pruner_enable = var.cc_trigger_manual_pruner_enable
  trigger_timed_pruner_name    = var.cc_trigger_timed_pruner_name
  trigger_timed_pruner_enable  = var.cc_trigger_timed_pruner_enable
}

#############Auto Remediation Support ######################
resource "ibm_cd_tekton_pipeline_property" "cc_pipeline_opt_in_cra_auto_remediation" {
  depends_on  = [module.devsecops_cc_toolchain]
  name        = "opt-in-cra-auto-remediation"
  type        = "text"
  value       = var.cc_opt_in_cra_auto_remediation
  pipeline_id = module.devsecops_cc_toolchain[0].cc_pipeline_id
}

resource "ibm_cd_tekton_pipeline_property" "cc_pipeline_opt_in_cra_auto_remediation_force" {
  depends_on  = [module.devsecops_cc_toolchain]
  name        = "opt-in-cra-auto-remediation-force"
  type        = "text"
  value       = var.cc_opt_in_cra_auto_remediation_force
  pipeline_id = module.devsecops_cc_toolchain[0].cc_pipeline_id
}

resource "ibm_cd_tekton_pipeline_property" "cc_pipeline_opt_in_cra_auto_remediation_enabled_repos" {
  depends_on  = [module.devsecops_cc_toolchain]
  name        = "opt-in-cra-auto-remediation-enabled-repos"
  type        = "text"
  value       = var.cc_opt_in_cra_auto_remediation_enabled_repos
  pipeline_id = module.devsecops_cc_toolchain[0].cc_pipeline_id
}

############### Auto Start Webhook ######################

# Random string for webhook token
resource "random_string" "webhook_secret" {
  length  = 48
  special = false
  upper   = false
}

# Create webhook for CI pipeline
resource "ibm_cd_tekton_pipeline_trigger" "ci_pipeline_webhook" {
  count          = (var.autostart) ? 1 : 0
  depends_on     = [random_string.webhook_secret]
  type           = "generic"
  pipeline_id    = module.devsecops_ci_toolchain[0].ci_pipeline_id
  name           = "ci-auto-start-webhook-trigger"
  event_listener = "ci-listener-gitlab"
  secret {
    type     = "token_matches"
    source   = "payload"
    key_name = "webhook-token"
    value    = random_string.webhook_secret.result
  }
}

# Ensure webhook trigger runs against correct git branch
resource "ibm_cd_tekton_pipeline_trigger_property" "ci_pipeline_webhook_branch_property" {
  count       = (var.autostart) ? 1 : 0
  depends_on  = [ibm_cd_tekton_pipeline_trigger.ci_pipeline_webhook]
  name        = "branch"
  pipeline_id = module.devsecops_ci_toolchain[0].ci_pipeline_id
  trigger_id  = ibm_cd_tekton_pipeline_trigger.ci_pipeline_webhook[0].trigger_id
  type        = "text"
  value       = module.devsecops_ci_toolchain[0].app_repo_branch
}

# Trigger property app name
resource "ibm_cd_tekton_pipeline_trigger_property" "ci_pipeline_webhook_name_property" {
  count       = (var.autostart) ? 1 : 0
  depends_on  = [ibm_cd_tekton_pipeline_trigger.ci_pipeline_webhook]
  name        = "app-name"
  pipeline_id = module.devsecops_ci_toolchain[0].ci_pipeline_id
  trigger_id  = ibm_cd_tekton_pipeline_trigger.ci_pipeline_webhook[0].trigger_id
  type        = "text"
  value       = var.ci_app_name
}

# Trigger property repository url
resource "ibm_cd_tekton_pipeline_trigger_property" "ci_pipeline_webhook_repo_url_property" {
  count       = (var.autostart) ? 1 : 0
  depends_on  = [ibm_cd_tekton_pipeline_trigger.ci_pipeline_webhook]
  name        = "repository"
  pipeline_id = module.devsecops_ci_toolchain[0].ci_pipeline_id
  trigger_id  = ibm_cd_tekton_pipeline_trigger.ci_pipeline_webhook[0].trigger_id
  type        = "text"
  value       = module.devsecops_ci_toolchain[0].app_repo_url
}

# Trigger webhook to start CI pipeline run
resource "null_resource" "ci_pipeline_run" {
  count = (var.autostart) ? 1 : 0
  depends_on = [
    ibm_cd_tekton_pipeline_trigger.ci_pipeline_webhook,
    ibm_cd_tekton_pipeline_trigger_property.ci_pipeline_webhook_branch_property
  ]
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command     = "${path.root}/../scripts/ci_start.sh \"${ibm_cd_tekton_pipeline_trigger.ci_pipeline_webhook[0].webhook_url}\" \"${random_string.webhook_secret.result}\""
    interpreter = ["/bin/bash", "-c"]
    quiet       = true
  }
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
