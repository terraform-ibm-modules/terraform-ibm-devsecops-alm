module "devsecops_da" {
  source = "../../"

  add_container_name_suffix                       = var.add_container_name_suffix
  app_group                                       = var.app_group
  add_pipeline_definitions                        = var.add_pipeline_definitions
  app_repo_auth_type                              = var.app_repo_auth_type
  app_repo_branch                                 = var.app_repo_branch
  app_repo_clone_from_url                         = var.app_repo_clone_from_url
  app_repo_clone_to_git_id                        = var.app_repo_clone_to_git_id
  app_repo_clone_to_git_provider                  = var.app_repo_clone_to_git_provider
  app_repo_existing_git_id                        = var.app_repo_existing_git_id
  app_repo_existing_git_provider                  = var.app_repo_existing_git_provider
  app_repo_existing_url                           = var.app_repo_existing_url
  app_repo_git_token_secret_crn                   = var.app_repo_git_token_secret_crn
  app_repo_git_token_secret_name                  = var.app_repo_git_token_secret_name
  app_repo_secret_group                           = var.app_repo_secret_group
  authorization_policy_creation                   = var.authorization_policy_creation
  autostart                                       = var.autostart
  change_management_existing_url                  = var.change_management_existing_url
  change_management_repo_git_id                   = var.change_management_repo_git_id
  cluster_name                                    = var.cluster_name
  code_engine_project                             = var.code_engine_project
  compliance_pipeline_branch                      = var.compliance_pipeline_branch
  compliance_pipeline_existing_repo_url           = var.compliance_pipeline_existing_repo_url
  compliance_pipeline_group                       = var.compliance_pipeline_group
  compliance_pipeline_repo_auth_type              = var.compliance_pipeline_repo_auth_type
  compliance_pipeline_repo_blind_connection       = var.compliance_pipeline_repo_blind_connection
  compliance_pipeline_repo_git_id                 = var.compliance_pipeline_repo_git_id
  compliance_pipeline_repo_git_provider           = var.compliance_pipeline_repo_git_provider
  compliance_pipeline_repo_git_token_secret_crn   = var.compliance_pipeline_repo_git_token_secret_crn
  compliance_pipeline_repo_git_token_secret_name  = var.compliance_pipeline_repo_git_token_secret_name
  compliance_pipeline_repo_name                   = var.compliance_pipeline_repo_name
  compliance_pipeline_repo_root_url               = var.compliance_pipeline_repo_root_url
  compliance_pipeline_repo_use_group_settings     = var.compliance_pipeline_repo_use_group_settings
  compliance_pipeline_repo_secret_group           = var.compliance_pipeline_repo_secret_group
  compliance_pipeline_repo_title                  = var.compliance_pipeline_repo_title
  cos_api_key_secret_crn                          = var.cos_api_key_secret_crn
  cos_api_key_secret_group                        = var.cos_api_key_secret_group
  cos_api_key_secret_name                         = var.cos_api_key_secret_name
  cos_api_key_secret_value                        = var.cos_api_key_secret_value
  cos_bucket_name                                 = var.cos_bucket_name
  cos_endpoint                                    = var.cos_endpoint
  cos_instance_crn                                = var.cos_instance_crn
  create_access_group                             = var.create_access_group
  create_cc_toolchain                             = var.create_cc_toolchain
  create_cd_instance                              = var.create_cd_instance
  create_cd_toolchain                             = var.create_cd_toolchain
  create_ci_toolchain                             = var.create_ci_toolchain
  create_code_engine_access_policy                = var.create_code_engine_access_policy
  create_cos_api_key                              = var.create_cos_api_key
  create_git_token                                = var.create_git_token
  create_ibmcloud_api_key                         = var.create_ibmcloud_api_key
  create_icr_namespace                            = var.create_icr_namespace
  create_kubernetes_access_policy                 = var.create_kubernetes_access_policy
  create_privateworker_secret                     = var.create_privateworker_secret
  create_secret_group                             = var.create_secret_group
  create_signing_key                              = var.create_signing_key
  create_triggers                                 = var.create_triggers
  create_git_triggers                             = var.create_git_triggers
  enable_cos                                      = var.enable_cos
  enable_pipeline_notifications                   = var.enable_pipeline_notifications
  enable_privateworker                            = var.enable_privateworker
  enable_secrets_manager                          = var.enable_secrets_manager
  enable_slack                                    = var.enable_slack
  environment_prefix                              = var.environment_prefix
  environment_tag                                 = var.environment_tag
  event_notifications_crn                         = var.event_notifications_crn
  event_notifications_tool_name                   = var.event_notifications_tool_name
  evidence_group                                  = var.evidence_group
  evidence_repo_auth_type                         = var.evidence_repo_auth_type
  evidence_repo_existing_git_id                   = var.evidence_repo_existing_git_id
  evidence_repo_existing_git_provider             = var.evidence_repo_existing_git_provider
  evidence_repo_existing_url                      = var.evidence_repo_existing_url
  evidence_repo_git_token_secret_crn              = var.evidence_repo_git_token_secret_crn
  evidence_repo_git_token_secret_name             = var.evidence_repo_git_token_secret_name
  evidence_repo_integration_owner                 = var.evidence_repo_integration_owner
  evidence_repo_name                              = var.evidence_repo_name
  evidence_repo_secret_group                      = var.evidence_repo_secret_group
  evidence_repo_source_url                        = var.evidence_repo_source_url
  force_create_standard_api_key                   = var.force_create_standard_api_key
  ibmcloud_api                                    = var.ibmcloud_api
  ibmcloud_api_key                                = var.ibmcloud_api_key
  inventory_group                                 = var.inventory_group
  inventory_repo_auth_type                        = var.inventory_repo_auth_type
  inventory_repo_existing_git_id                  = var.inventory_repo_existing_git_id
  inventory_repo_existing_git_provider            = var.inventory_repo_existing_git_provider
  inventory_repo_existing_url                     = var.inventory_repo_existing_url
  inventory_repo_git_token_secret_crn             = var.inventory_repo_git_token_secret_crn
  inventory_repo_git_token_secret_name            = var.inventory_repo_git_token_secret_name
  inventory_repo_integration_owner                = var.inventory_repo_integration_owner
  inventory_repo_name                             = var.inventory_repo_name
  inventory_repo_secret_group                     = var.inventory_repo_secret_group
  inventory_repo_source_url                       = var.inventory_repo_source_url
  issues_group                                    = var.issues_group
  issues_repo_auth_type                           = var.issues_repo_auth_type
  issues_repo_existing_git_id                     = var.issues_repo_existing_git_id
  issues_repo_existing_git_provider               = var.issues_repo_existing_git_provider
  issues_repo_existing_url                        = var.issues_repo_existing_url
  issues_repo_git_token_secret_crn                = var.issues_repo_git_token_secret_crn
  issues_repo_git_token_secret_name               = var.issues_repo_git_token_secret_name
  issues_repo_integration_owner                   = var.issues_repo_integration_owner
  issues_repo_name                                = var.issues_repo_name
  issues_repo_secret_group                        = var.issues_repo_secret_group
  issues_repo_source_url                          = var.issues_repo_source_url
  pipeline_config_group                           = var.pipeline_config_group
  pipeline_config_repo_auth_type                  = var.pipeline_config_repo_auth_type
  pipeline_config_repo_branch                     = var.pipeline_config_repo_branch
  pipeline_config_repo_clone_from_url             = var.pipeline_config_repo_clone_from_url
  pipeline_config_repo_existing_url               = var.pipeline_config_repo_existing_url
  pipeline_config_repo_git_id                     = var.pipeline_config_repo_git_id
  pipeline_config_repo_git_provider               = var.pipeline_config_repo_git_provider
  pipeline_config_repo_git_token_secret_crn       = var.pipeline_config_repo_git_token_secret_crn
  pipeline_config_repo_git_token_secret_name      = var.pipeline_config_repo_git_token_secret_name
  pipeline_config_repo_secret_group               = var.pipeline_config_repo_secret_group
  pipeline_doi_api_key_secret_crn                 = var.pipeline_doi_api_key_secret_crn
  pipeline_doi_api_key_secret_group               = var.pipeline_doi_api_key_secret_group
  pipeline_doi_api_key_secret_name                = var.pipeline_doi_api_key_secret_name
  pipeline_git_tag                                = var.pipeline_git_tag
  pipeline_ibmcloud_api_key_secret_crn            = var.pipeline_ibmcloud_api_key_secret_crn
  pipeline_ibmcloud_api_key_secret_group          = var.pipeline_ibmcloud_api_key_secret_group
  pipeline_ibmcloud_api_key_secret_name           = var.pipeline_ibmcloud_api_key_secret_name
  pipeline_ibmcloud_api_key_secret_value          = var.pipeline_ibmcloud_api_key_secret_value
  prefix                                          = var.prefix
  privateworker_credentials_secret_crn            = var.privateworker_credentials_secret_crn
  privateworker_credentials_secret_group          = var.privateworker_credentials_secret_group
  privateworker_credentials_secret_name           = var.privateworker_credentials_secret_name
  privateworker_name                              = var.privateworker_name
  privateworker_secret_value                      = var.privateworker_secret_value
  registry_namespace                              = var.registry_namespace
  repo_blind_connection                           = var.repo_blind_connection
  repo_git_id                                     = var.repo_git_id
  repo_git_provider                               = var.repo_git_provider
  repo_git_token_secret_crn                       = var.repo_git_token_secret_crn
  repo_git_token_secret_name                      = var.repo_git_token_secret_name
  repo_git_token_secret_value                     = var.repo_git_token_secret_value
  repo_group                                      = var.repo_group
  repo_secret_group                               = var.repo_secret_group
  repo_root_url                                   = var.repo_root_url
  repo_title                                      = var.repo_title
  repo_apply_settings_to_compliance_repos         = var.repo_apply_settings_to_compliance_repos
  repositories_prefix                             = var.repositories_prefix
  rotation_period                                 = var.rotation_period
  rotate_signing_key                              = var.rotate_signing_key
  scc_attachment_id                               = var.scc_attachment_id
  scc_enable_scc                                  = var.scc_enable_scc
  scc_evidence_locker_type                        = var.scc_evidence_locker_type
  scc_instance_crn                                = var.scc_instance_crn
  scc_profile_name                                = var.scc_profile_name
  scc_profile_version                             = var.scc_profile_version
  scc_scc_api_key_secret_crn                      = var.scc_scc_api_key_secret_crn
  scc_scc_api_key_secret_group                    = var.scc_scc_api_key_secret_group
  scc_scc_api_key_secret_name                     = var.scc_scc_api_key_secret_name
  scc_use_profile_attachment                      = var.scc_use_profile_attachment
  sample_default_application                      = var.sample_default_application
  slack_channel_name                              = var.slack_channel_name
  slack_integration_name                          = var.slack_integration_name
  slack_team_name                                 = var.slack_team_name
  slack_webhook_secret_crn                        = var.slack_webhook_secret_crn
  slack_webhook_secret_group                      = var.slack_webhook_secret_group
  slack_webhook_secret_name                       = var.slack_webhook_secret_name
  sm_endpoint_type                                = var.sm_endpoint_type
  sm_instance_crn                                 = var.sm_instance_crn
  sm_integration_name                             = var.sm_integration_name
  sm_location                                     = var.sm_location
  sm_name                                         = var.sm_name
  sm_resource_group                               = var.sm_resource_group
  sm_secret_expiration_period                     = var.sm_secret_expiration_period
  sm_secret_group                                 = var.sm_secret_group
  sonarqube_integration_name                      = var.sonarqube_integration_name
  sonarqube_is_blind_connection                   = var.sonarqube_is_blind_connection
  sonarqube_secret_crn                            = var.sonarqube_secret_crn
  sonarqube_secret_group                          = var.sonarqube_secret_group
  sonarqube_secret_name                           = var.sonarqube_secret_name
  sonarqube_server_url                            = var.sonarqube_server_url
  sonarqube_user                                  = var.sonarqube_user
  toolchain_access_group_name                     = var.toolchain_access_group_name
  toolchain_name                                  = var.toolchain_name
  toolchain_resource_group                        = var.toolchain_resource_group
  toolchain_region                                = var.toolchain_region
  use_app_repo_for_cd_deploy                      = var.use_app_repo_for_cd_deploy
  cc_app_repo_branch                              = var.cc_app_repo_branch
  cc_doi_toolchain_id                             = var.cc_doi_toolchain_id
  cc_link_to_doi_toolchain                        = var.cc_link_to_doi_toolchain
  cc_pipeline_config_repo_branch                  = var.cc_pipeline_config_repo_branch
  cc_pipeline_properties                          = var.cc_pipeline_properties
  cc_pipeline_properties_filepath                 = var.cc_pipeline_properties_filepath
  cc_repository_properties                        = var.cc_repository_properties
  cc_toolchain_description                        = var.cc_toolchain_description
  cc_toolchain_name                               = var.cc_toolchain_name
  cc_trigger_manual_enable                        = var.cc_trigger_manual_enable
  cc_trigger_manual_pruner_enable                 = var.cc_trigger_manual_pruner_enable
  cc_trigger_timed_cron_schedule                  = var.cc_trigger_timed_cron_schedule
  cc_trigger_timed_enable                         = var.cc_trigger_timed_enable
  cc_trigger_timed_pruner_enable                  = var.cc_trigger_timed_pruner_enable
  cd_change_management_group                      = var.cd_change_management_group
  cd_change_management_repo_auth_type             = var.cd_change_management_repo_auth_type
  cd_change_management_repo_git_token_secret_crn  = var.cd_change_management_repo_git_token_secret_crn
  cd_change_management_repo_git_token_secret_name = var.cd_change_management_repo_git_token_secret_name
  cd_change_management_repo_secret_group          = var.cd_change_management_repo_secret_group
  cd_change_repo_clone_from_url                   = var.cd_change_repo_clone_from_url
  cd_enable_change_management_repo                = var.cd_enable_change_management_repo
  cd_cluster_name                                 = var.cd_cluster_name
  cd_cluster_namespace                            = var.cd_cluster_namespace
  cd_cluster_region                               = var.cd_cluster_region
  cd_code_engine_region                           = var.cd_code_engine_region
  cd_code_engine_project                          = var.cd_code_engine_project
  cd_code_engine_resource_group                   = var.cd_code_engine_resource_group
  cd_code_signing_cert_secret_name                = var.cd_code_signing_cert_secret_name
  cd_deployment_group                             = var.cd_deployment_group
  cd_deployment_repo_auth_type                    = var.cd_deployment_repo_auth_type
  cd_deployment_repo_clone_from_branch            = var.cd_deployment_repo_clone_from_branch
  cd_deployment_repo_clone_from_url               = var.cd_deployment_repo_clone_from_url
  cd_deployment_repo_clone_to_git_id              = var.cd_deployment_repo_clone_to_git_id
  cd_deployment_repo_clone_to_git_provider        = var.cd_deployment_repo_clone_to_git_provider
  cd_deployment_repo_existing_branch              = var.cd_deployment_repo_existing_branch
  cd_deployment_repo_existing_git_id              = var.cd_deployment_repo_existing_git_id
  cd_deployment_repo_existing_git_provider        = var.cd_deployment_repo_existing_git_provider
  cd_deployment_repo_existing_url                 = var.cd_deployment_repo_existing_url
  cd_deployment_repo_git_token_secret_crn         = var.cd_deployment_repo_git_token_secret_crn
  cd_deployment_repo_git_token_secret_name        = var.cd_deployment_repo_git_token_secret_name
  cd_deployment_repo_secret_group                 = var.cd_deployment_repo_secret_group
  cd_doi_toolchain_id                             = var.cd_doi_toolchain_id
  continuous_delivery_service_name                = var.continuous_delivery_service_name
  cd_link_to_doi_toolchain                        = var.cd_link_to_doi_toolchain
  cd_pipeline_config_repo_branch                  = var.cd_pipeline_config_repo_branch
  cd_pipeline_properties                          = var.cd_pipeline_properties
  cd_pipeline_properties_filepath                 = var.cd_pipeline_properties_filepath
  cd_privateworker_credentials_secret_crn         = var.cd_privateworker_credentials_secret_crn
  cd_region                                       = var.cd_region
  cd_repository_properties                        = var.cd_repository_properties
  cd_service_plan                                 = var.cd_service_plan
  cd_toolchain_description                        = var.cd_toolchain_description
  cd_toolchain_name                               = var.cd_toolchain_name
  cd_trigger_git_enable                           = var.cd_trigger_git_enable
  cd_trigger_git_promotion_validation_branch      = var.cd_trigger_git_promotion_validation_branch
  cd_trigger_git_promotion_validation_enable      = var.cd_trigger_git_promotion_validation_enable
  cd_trigger_git_promotion_validation_listener    = var.cd_trigger_git_promotion_validation_listener
  cd_trigger_manual_enable                        = var.cd_trigger_manual_enable
  cd_trigger_manual_promotion_enable              = var.cd_trigger_manual_promotion_enable
  cd_trigger_manual_pruner_enable                 = var.cd_trigger_manual_pruner_enable
  cd_trigger_timed_cron_schedule                  = var.cd_trigger_timed_cron_schedule
  cd_trigger_timed_enable                         = var.cd_trigger_timed_enable
  cd_trigger_timed_pruner_enable                  = var.cd_trigger_timed_pruner_enable
  ci_app_name                                     = var.ci_app_name
  ci_app_repo_branch                              = var.ci_app_repo_branch
  ci_cluster_name                                 = var.ci_cluster_name
  ci_cluster_namespace                            = var.ci_cluster_namespace
  ci_cluster_region                               = var.ci_cluster_region
  ci_cluster_resource_group                       = var.ci_cluster_resource_group
  ci_code_engine_project                          = var.ci_code_engine_project
  ci_code_engine_region                           = var.ci_code_engine_region
  ci_code_engine_resource_group                   = var.ci_code_engine_resource_group
  ci_compliance_pipeline_pr_branch                = var.ci_compliance_pipeline_pr_branch
  ci_doi_toolchain_id                             = var.ci_doi_toolchain_id
  ci_doi_toolchain_id_pipeline_property           = var.ci_doi_toolchain_id_pipeline_property
  ci_link_to_doi_toolchain                        = var.ci_link_to_doi_toolchain
  ci_pipeline_config_repo_branch                  = var.ci_pipeline_config_repo_branch
  ci_pipeline_properties                          = var.ci_pipeline_properties
  ci_pipeline_properties_filepath                 = var.ci_pipeline_properties_filepath
  ci_privateworker_credentials_secret_crn         = var.ci_privateworker_credentials_secret_crn
  ci_registry_region                              = var.ci_registry_region
  ci_repository_properties                        = var.ci_repository_properties
  ci_signing_key_secret_name                      = var.ci_signing_key_secret_name
  ci_toolchain_description                        = var.ci_toolchain_description
  ci_toolchain_name                               = var.ci_toolchain_name
  ci_trigger_git_enable                           = var.ci_trigger_git_enable
  ci_trigger_manual_enable                        = var.ci_trigger_manual_enable
  ci_trigger_manual_pruner_enable                 = var.ci_trigger_manual_pruner_enable
  ci_trigger_pr_git_enable                        = var.ci_trigger_pr_git_enable
  ci_trigger_timed_cron_schedule                  = var.ci_trigger_timed_cron_schedule
  ci_trigger_timed_enable                         = var.ci_trigger_timed_enable
  ci_trigger_timed_pruner_enable                  = var.ci_trigger_timed_pruner_enable
  pr_pipeline_git_tag                             = var.pr_pipeline_git_tag
  use_legacy_cos_tool                             = var.use_legacy_cos_tool
  use_legacy_ref                                  = var.use_legacy_ref
}
