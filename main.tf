# workaround for Schematics automatically setting a null value to false for bool type
# Issue for the enable_key_protect and enable_secrets_manager inputs as the logic fails with regard to
# determing whether to use the enable_secrets_manager or the toolchain specific counter parts ci/cd/cc_enable_secrets_manager
# this could be addressed manually by ticking a setting in Schematics for each of the inputs
locals {

  git_fr2 = "https://private.eu-fr2.git.cloud.ibm.com"
  compliance_pipelines_git_server = (
    (var.toolchain_region == "eu-fr2") ? local.git_fr2
    : format("https://%s.git.cloud.ibm.com", var.toolchain_region)
  )

  ci_app_repo_clone_from_url = (var.ci_app_repo_clone_from_url == "") ? var.app_repo_clone_from_url : var.ci_app_repo_clone_from_url

  app_source_repo_url = (
    (local.ci_app_repo_clone_from_url != "") ? local.ci_app_repo_clone_from_url :
    format("%s/open-toolchain/%s.git", local.compliance_pipelines_git_server, var.sample_default_application)
  )

  #setting all three toolchain specific parameters to false by default instead of null. If any of these values change then use the toolchain specific values.
  ci_enable_secrets_manager = (var.ci_enable_secrets_manager == "") ? var.enable_secrets_manager : var.ci_enable_secrets_manager
  cd_enable_secrets_manager = (var.cd_enable_secrets_manager == "") ? var.enable_secrets_manager : var.cd_enable_secrets_manager
  cc_enable_secrets_manager = (var.cc_enable_secrets_manager == "") ? var.enable_secrets_manager : var.cc_enable_secrets_manager

  ci_enable_key_protect = (var.ci_enable_key_protect == "") ? var.enable_key_protect : var.ci_enable_key_protect
  cd_enable_key_protect = (var.cd_enable_key_protect == "") ? var.enable_key_protect : var.cd_enable_key_protect
  cc_enable_key_protect = (var.cc_enable_key_protect == "") ? var.enable_key_protect : var.cc_enable_key_protect

  ci_enable_slack = (var.ci_enable_slack == "") ? var.enable_slack : var.ci_enable_slack
  cd_enable_slack = (var.cd_enable_slack == "") ? var.enable_slack : var.cd_enable_slack
  cc_enable_slack = (var.cc_enable_slack == "") ? var.enable_slack : var.cc_enable_slack

  ci_enable_pipeline_notifications = (var.ci_enable_pipeline_notifications == "") ? var.enable_pipeline_notifications : var.ci_enable_pipeline_notifications
  cd_enable_pipeline_notifications = (var.cd_enable_pipeline_notifications == "") ? var.enable_pipeline_notifications : var.cd_enable_pipeline_notifications
  cc_enable_pipeline_notifications = (var.cc_enable_pipeline_notifications == "") ? var.enable_pipeline_notifications : var.cc_enable_pipeline_notifications

  cd_scc_enable_scc = (var.cd_scc_enable_scc == "") ? var.scc_enable_scc : var.cd_scc_enable_scc
  cc_scc_enable_scc = (var.cc_scc_enable_scc == "") ? var.scc_enable_scc : var.cc_scc_enable_scc

  repo_auth_type               = ((var.repo_git_token_secret_name == "") && (var.repo_git_token_secret_crn == "")) ? "" : "pat"
  custom_app_repo_auth_type    = ((var.custom_app_repo_git_token_secret_name == "") && (var.custom_app_repo_git_token_secret_crn == "")) ? "" : "pat"
  calculated_ci_cluster_region = (var.ci_cluster_region != "") ? var.ci_cluster_region : var.toolchain_region

  ci_toolchain_name = (var.ci_toolchain_name == "") ? format("${var.toolchain_name}%s", "-CI-Toolchain") : var.ci_toolchain_name
  cd_toolchain_name = (var.cd_toolchain_name == "") ? format("${var.toolchain_name}%s", "-CD-Toolchain") : var.cd_toolchain_name
  cc_toolchain_name = (var.cc_toolchain_name == "") ? format("${var.toolchain_name}%s", "-CC-Toolchain") : var.cc_toolchain_name

  ci_code_engine_project = (var.ci_code_engine_project == "") ? var.code_engine_project : var.ci_code_engine_project
  cd_code_engine_project = (var.cd_code_engine_project == "") ? var.code_engine_project : var.cd_code_engine_project

  ci_code_engine_project_name = ((var.prefix != "") && (var.add_code_engine_prefix)) ? format("${var.prefix}-%s", local.ci_code_engine_project) : local.ci_code_engine_project
  cd_code_engine_project_name = ((var.prefix != "") && (var.add_code_engine_prefix)) ? format("${var.prefix}-%s", local.cd_code_engine_project) : local.cd_code_engine_project

  ci_repositories_prefix = (var.ci_repositories_prefix == "") ? var.repositories_prefix : var.ci_repositories_prefix
  cd_repositories_prefix = (var.cd_repositories_prefix == "") ? var.repositories_prefix : var.cd_repositories_prefix
  cc_repositories_prefix = (var.cc_repositories_prefix == "") ? var.repositories_prefix : var.cc_repositories_prefix

  enable_prereqs = ((var.create_secret_group == true) || (var.create_ibmcloud_api_key == true) || (var.create_cos_api_key == true) || (var.create_signing_key == true) || (var.create_git_token == true) || (var.create_privateworker_secret == true)) ? true : false

  registry_namespace_suffix = (var.add_container_name_suffix) ? format("%s-%s", var.registry_namespace, random_string.resource_suffix[0].result) : var.registry_namespace
  registry_namespace        = (var.prefix == "") ? local.registry_namespace_suffix : format("%s-%s", var.prefix, local.registry_namespace_suffix)

  ci_app_repo_git_token_secret_crn = (var.ci_app_repo_git_token_secret_crn == "") ? var.app_repo_git_token_secret_crn : var.ci_app_repo_git_token_secret_crn
  cc_app_repo_git_token_secret_crn = (var.cc_app_repo_git_token_secret_crn == "") ? var.app_repo_git_token_secret_crn : var.cc_app_repo_git_token_secret_crn

  ci_compliance_pipeline_repo_auth_type             = (var.ci_compliance_pipeline_repo_auth_type == "") ? var.compliance_pipeline_repo_auth_type : var.ci_compliance_pipeline_repo_auth_type
  cd_compliance_pipeline_repo_auth_type             = (var.cd_compliance_pipeline_repo_auth_type == "") ? var.compliance_pipeline_repo_auth_type : var.cd_compliance_pipeline_repo_auth_type
  cc_compliance_pipeline_repo_auth_type             = (var.cc_compliance_pipeline_repo_auth_type == "") ? var.compliance_pipeline_repo_auth_type : var.cc_compliance_pipeline_repo_auth_type
  ci_compliance_pipeline_repo_git_token_secret_crn  = (var.ci_compliance_pipeline_repo_git_token_secret_crn == "") ? var.compliance_pipeline_repo_git_token_secret_crn : var.ci_compliance_pipeline_repo_git_token_secret_crn
  cd_compliance_pipeline_repo_git_token_secret_crn  = (var.cd_compliance_pipeline_repo_git_token_secret_crn == "") ? var.compliance_pipeline_repo_git_token_secret_crn : var.cd_compliance_pipeline_repo_git_token_secret_crn
  cc_compliance_pipeline_repo_git_token_secret_crn  = (var.cc_compliance_pipeline_repo_git_token_secret_crn == "") ? var.compliance_pipeline_repo_git_token_secret_crn : var.cc_compliance_pipeline_repo_git_token_secret_crn
  ci_compliance_pipeline_repo_git_token_secret_name = (var.ci_compliance_pipeline_repo_git_token_secret_name == "") ? var.compliance_pipeline_repo_git_token_secret_name : var.ci_compliance_pipeline_repo_git_token_secret_name
  cd_compliance_pipeline_repo_git_token_secret_name = (var.cd_compliance_pipeline_repo_git_token_secret_name == "") ? var.compliance_pipeline_repo_git_token_secret_name : var.cd_compliance_pipeline_repo_git_token_secret_name
  cc_compliance_pipeline_repo_git_token_secret_name = (var.cc_compliance_pipeline_repo_git_token_secret_name == "") ? var.compliance_pipeline_repo_git_token_secret_name : var.cc_compliance_pipeline_repo_git_token_secret_name
  ci_compliance_pipeline_repo_secret_group          = (var.ci_compliance_pipeline_repo_secret_group == "") ? var.compliance_pipeline_repo_secret_group : var.ci_compliance_pipeline_repo_secret_group
  cd_compliance_pipeline_repo_secret_group          = (var.cd_compliance_pipeline_repo_secret_group == "") ? var.compliance_pipeline_repo_secret_group : var.cd_compliance_pipeline_repo_secret_group
  cc_compliance_pipeline_repo_secret_group          = (var.cc_compliance_pipeline_repo_secret_group == "") ? var.compliance_pipeline_repo_secret_group : var.cc_compliance_pipeline_repo_secret_group
  ci_compliance_pipeline_group                      = (var.ci_compliance_pipeline_group == "") ? var.compliance_pipeline_group : var.ci_compliance_pipeline_group
  cd_compliance_pipeline_group                      = (var.cd_compliance_pipeline_group == "") ? var.compliance_pipeline_group : var.cd_compliance_pipeline_group
  cc_compliance_pipeline_group                      = (var.cc_compliance_pipeline_group == "") ? var.compliance_pipeline_group : var.cc_compliance_pipeline_group
  compliance_pipeline_repo_existing_git_provider = (
    (var.compliance_pipeline_repo_git_provider != "") ? var.compliance_pipeline_repo_git_provider :
    (var.compliance_pipeline_repo_use_group_settings == false) ? "hostedgit" :
    (var.repo_git_provider != "") ? var.repo_git_provider : "hostedgit"
  )

  ci_evidence_repo_auth_type             = (var.ci_evidence_repo_auth_type == "") ? var.evidence_repo_auth_type : var.ci_evidence_repo_auth_type
  cd_evidence_repo_auth_type             = (var.cd_evidence_repo_auth_type == "") ? var.evidence_repo_auth_type : var.cd_evidence_repo_auth_type
  cc_evidence_repo_auth_type             = (var.cc_evidence_repo_auth_type == "") ? var.evidence_repo_auth_type : var.cc_evidence_repo_auth_type
  ci_evidence_repo_git_token_secret_crn  = (var.ci_evidence_repo_git_token_secret_crn == "") ? var.evidence_repo_git_token_secret_crn : var.ci_evidence_repo_git_token_secret_crn
  cd_evidence_repo_git_token_secret_crn  = (var.cd_evidence_repo_git_token_secret_crn == "") ? var.evidence_repo_git_token_secret_crn : var.cd_evidence_repo_git_token_secret_crn
  cc_evidence_repo_git_token_secret_crn  = (var.cc_evidence_repo_git_token_secret_crn == "") ? var.evidence_repo_git_token_secret_crn : var.cc_evidence_repo_git_token_secret_crn
  ci_evidence_repo_git_token_secret_name = (var.ci_evidence_repo_git_token_secret_name == "") ? var.evidence_repo_git_token_secret_name : var.ci_evidence_repo_git_token_secret_name
  cd_evidence_repo_git_token_secret_name = (var.cd_evidence_repo_git_token_secret_name == "") ? var.evidence_repo_git_token_secret_name : var.cd_evidence_repo_git_token_secret_name
  cc_evidence_repo_git_token_secret_name = (var.cc_evidence_repo_git_token_secret_name == "") ? var.evidence_repo_git_token_secret_name : var.cc_evidence_repo_git_token_secret_name
  ci_evidence_repo_secret_group          = (var.ci_evidence_repo_secret_group == "") ? var.evidence_repo_secret_group : var.ci_evidence_repo_secret_group
  cd_evidence_repo_secret_group          = (var.cd_evidence_repo_secret_group == "") ? var.evidence_repo_secret_group : var.cd_evidence_repo_secret_group
  cc_evidence_repo_secret_group          = (var.cc_evidence_repo_secret_group == "") ? var.evidence_repo_secret_group : var.cc_evidence_repo_secret_group
  ci_evidence_group                      = (var.ci_evidence_group == "") ? var.evidence_group : var.ci_evidence_group
  cd_evidence_group                      = (var.cd_evidence_group == "") ? var.evidence_group : var.cd_evidence_group
  cc_evidence_group                      = (var.cc_evidence_group == "") ? var.evidence_group : var.cc_evidence_group
  evidence_repo_existing_git_provider = (
    (var.evidence_repo_existing_git_provider != "") ? var.evidence_repo_existing_git_provider :
    (var.repo_git_provider != "") ? var.repo_git_provider : "hostedgit"
  )

  ci_issues_repo_auth_type             = (var.ci_issues_repo_auth_type == "") ? var.issues_repo_auth_type : var.ci_issues_repo_auth_type
  cd_issues_repo_auth_type             = (var.cd_issues_repo_auth_type == "") ? var.issues_repo_auth_type : var.cd_issues_repo_auth_type
  cc_issues_repo_auth_type             = (var.cc_issues_repo_auth_type == "") ? var.issues_repo_auth_type : var.cc_issues_repo_auth_type
  ci_issues_repo_git_token_secret_crn  = (var.ci_issues_repo_git_token_secret_crn == "") ? var.issues_repo_git_token_secret_crn : var.ci_issues_repo_git_token_secret_crn
  cd_issues_repo_git_token_secret_crn  = (var.cd_issues_repo_git_token_secret_crn == "") ? var.issues_repo_git_token_secret_crn : var.cd_issues_repo_git_token_secret_crn
  cc_issues_repo_git_token_secret_crn  = (var.cc_issues_repo_git_token_secret_crn == "") ? var.issues_repo_git_token_secret_crn : var.cc_issues_repo_git_token_secret_crn
  ci_issues_repo_git_token_secret_name = (var.ci_issues_repo_git_token_secret_name == "") ? var.issues_repo_git_token_secret_name : var.ci_issues_repo_git_token_secret_name
  cd_issues_repo_git_token_secret_name = (var.cd_issues_repo_git_token_secret_name == "") ? var.issues_repo_git_token_secret_name : var.cd_issues_repo_git_token_secret_name
  cc_issues_repo_git_token_secret_name = (var.cc_issues_repo_git_token_secret_name == "") ? var.issues_repo_git_token_secret_name : var.cc_issues_repo_git_token_secret_name
  ci_issues_repo_secret_group          = (var.ci_issues_repo_secret_group == "") ? var.issues_repo_secret_group : var.ci_issues_repo_secret_group
  cd_issues_repo_secret_group          = (var.cd_issues_repo_secret_group == "") ? var.issues_repo_secret_group : var.cd_issues_repo_secret_group
  cc_issues_repo_secret_group          = (var.cc_issues_repo_secret_group == "") ? var.issues_repo_secret_group : var.cc_issues_repo_secret_group
  ci_issues_group                      = (var.ci_issues_group == "") ? var.issues_group : var.ci_issues_group
  cd_issues_group                      = (var.cd_issues_group == "") ? var.issues_group : var.cd_issues_group
  cc_issues_group                      = (var.cc_issues_group == "") ? var.issues_group : var.cc_issues_group
  issues_repo_existing_git_provider = (
    (var.issues_repo_existing_git_provider != "") ? var.issues_repo_existing_git_provider :
    (var.repo_git_provider != "") ? var.repo_git_provider : "hostedgit"
  )

  ci_inventory_repo_auth_type             = (var.ci_inventory_repo_auth_type == "") ? var.inventory_repo_auth_type : var.ci_inventory_repo_auth_type
  cd_inventory_repo_auth_type             = (var.cd_inventory_repo_auth_type == "") ? var.inventory_repo_auth_type : var.cd_inventory_repo_auth_type
  cc_inventory_repo_auth_type             = (var.cc_inventory_repo_auth_type == "") ? var.inventory_repo_auth_type : var.cc_inventory_repo_auth_type
  ci_inventory_repo_git_token_secret_crn  = (var.ci_inventory_repo_git_token_secret_crn == "") ? var.inventory_repo_git_token_secret_crn : var.ci_inventory_repo_git_token_secret_crn
  cd_inventory_repo_git_token_secret_crn  = (var.cd_inventory_repo_git_token_secret_crn == "") ? var.inventory_repo_git_token_secret_crn : var.cd_inventory_repo_git_token_secret_crn
  cc_inventory_repo_git_token_secret_crn  = (var.cc_inventory_repo_git_token_secret_crn == "") ? var.inventory_repo_git_token_secret_crn : var.cc_inventory_repo_git_token_secret_crn
  ci_inventory_repo_git_token_secret_name = (var.ci_inventory_repo_git_token_secret_name == "") ? var.inventory_repo_git_token_secret_name : var.ci_inventory_repo_git_token_secret_name
  cd_inventory_repo_git_token_secret_name = (var.cd_inventory_repo_git_token_secret_name == "") ? var.inventory_repo_git_token_secret_name : var.cd_inventory_repo_git_token_secret_name
  cc_inventory_repo_git_token_secret_name = (var.cc_inventory_repo_git_token_secret_name == "") ? var.inventory_repo_git_token_secret_name : var.cc_inventory_repo_git_token_secret_name
  ci_inventory_repo_secret_group          = (var.ci_inventory_repo_secret_group == "") ? var.inventory_repo_secret_group : var.ci_inventory_repo_secret_group
  cd_inventory_repo_secret_group          = (var.cd_inventory_repo_secret_group == "") ? var.inventory_repo_secret_group : var.cd_inventory_repo_secret_group
  cc_inventory_repo_secret_group          = (var.cc_inventory_repo_secret_group == "") ? var.inventory_repo_secret_group : var.cc_inventory_repo_secret_group
  ci_inventory_group                      = (var.ci_inventory_group == "") ? var.inventory_group : var.ci_inventory_group
  cd_inventory_group                      = (var.cd_inventory_group == "") ? var.inventory_group : var.cd_inventory_group
  cc_inventory_group                      = (var.cc_inventory_group == "") ? var.inventory_group : var.cc_inventory_group
  inventory_repo_existing_git_provider = (
    (var.inventory_repo_existing_git_provider != "") ? var.inventory_repo_existing_git_provider :
    (var.repo_git_provider != "") ? var.repo_git_provider : "hostedgit"
  )

  ci_pipeline_config_repo_auth_type             = (var.ci_pipeline_config_repo_auth_type == "") ? var.pipeline_config_repo_auth_type : var.ci_pipeline_config_repo_auth_type
  cd_pipeline_config_repo_auth_type             = (var.cd_pipeline_config_repo_auth_type == "") ? var.pipeline_config_repo_auth_type : var.cd_pipeline_config_repo_auth_type
  cc_pipeline_config_repo_auth_type             = (var.cc_pipeline_config_repo_auth_type == "") ? var.pipeline_config_repo_auth_type : var.cc_pipeline_config_repo_auth_type
  ci_pipeline_config_repo_git_token_secret_crn  = (var.ci_pipeline_config_repo_git_token_secret_crn == "") ? var.pipeline_config_repo_git_token_secret_crn : var.ci_pipeline_config_repo_git_token_secret_crn
  cd_pipeline_config_repo_git_token_secret_crn  = (var.cd_pipeline_config_repo_git_token_secret_crn == "") ? var.pipeline_config_repo_git_token_secret_crn : var.cd_pipeline_config_repo_git_token_secret_crn
  cc_pipeline_config_repo_git_token_secret_crn  = (var.cc_pipeline_config_repo_git_token_secret_crn == "") ? var.pipeline_config_repo_git_token_secret_crn : var.cc_pipeline_config_repo_git_token_secret_crn
  ci_pipeline_config_repo_git_token_secret_name = (var.ci_pipeline_config_repo_git_token_secret_name == "") ? var.pipeline_config_repo_git_token_secret_name : var.ci_pipeline_config_repo_git_token_secret_name
  cd_pipeline_config_repo_git_token_secret_name = (var.cd_pipeline_config_repo_git_token_secret_name == "") ? var.pipeline_config_repo_git_token_secret_name : var.cd_pipeline_config_repo_git_token_secret_name
  cc_pipeline_config_repo_git_token_secret_name = (var.cc_pipeline_config_repo_git_token_secret_name == "") ? var.pipeline_config_repo_git_token_secret_name : var.cc_pipeline_config_repo_git_token_secret_name
  ci_pipeline_config_repo_secret_group          = (var.ci_pipeline_config_repo_secret_group == "") ? var.pipeline_config_repo_secret_group : var.ci_pipeline_config_repo_secret_group
  cd_pipeline_config_repo_secret_group          = (var.cd_pipeline_config_repo_secret_group == "") ? var.pipeline_config_repo_secret_group : var.cd_pipeline_config_repo_secret_group
  cc_pipeline_config_repo_secret_group          = (var.cc_pipeline_config_repo_secret_group == "") ? var.pipeline_config_repo_secret_group : var.cc_pipeline_config_repo_secret_group
  ci_pipeline_config_group                      = (var.ci_pipeline_config_group == "") ? var.pipeline_config_group : var.ci_pipeline_config_group
  cd_pipeline_config_group                      = (var.cd_pipeline_config_group == "") ? var.pipeline_config_group : var.cd_pipeline_config_group
  cc_pipeline_config_group                      = (var.cc_pipeline_config_group == "") ? var.pipeline_config_group : var.cc_pipeline_config_group


  ci_pipeline_config_repo_existing_url   = (var.ci_pipeline_config_repo_existing_url == "") ? var.pipeline_config_repo_existing_url : var.ci_pipeline_config_repo_existing_url
  cd_pipeline_config_repo_existing_url   = (var.cd_pipeline_config_repo_existing_url == "") ? var.pipeline_config_repo_existing_url : var.cd_pipeline_config_repo_existing_url
  cc_pipeline_config_repo_existing_url   = (var.cc_pipeline_config_repo_existing_url == "") ? var.pipeline_config_repo_existing_url : var.cc_pipeline_config_repo_existing_url
  ci_pipeline_config_repo_clone_from_url = (var.ci_pipeline_config_repo_clone_from_url == "") ? var.pipeline_config_repo_clone_from_url : var.ci_pipeline_config_repo_clone_from_url
  cd_pipeline_config_repo_clone_from_url = (var.cd_pipeline_config_repo_clone_from_url == "") ? var.pipeline_config_repo_clone_from_url : var.cd_pipeline_config_repo_clone_from_url
  cc_pipeline_config_repo_clone_from_url = (var.cc_pipeline_config_repo_clone_from_url == "") ? var.pipeline_config_repo_clone_from_url : var.cc_pipeline_config_repo_clone_from_url
  ci_pipeline_config_repo_branch         = (var.ci_pipeline_config_repo_branch == "") ? var.pipeline_config_repo_branch : var.ci_pipeline_config_repo_branch
  cd_pipeline_config_repo_branch         = (var.cd_pipeline_config_repo_branch == "") ? var.pipeline_config_repo_branch : var.cd_pipeline_config_repo_branch
  cc_pipeline_config_repo_branch         = (var.cc_pipeline_config_repo_branch == "") ? var.pipeline_config_repo_branch : var.cc_pipeline_config_repo_branch

  pipeline_config_repo_git_provider = (
    (var.pipeline_config_repo_git_provider != "") ? var.pipeline_config_repo_git_provider :
    (var.custom_app_repo_git_provider != "") ? var.custom_app_repo_git_provider :
    (var.repo_git_provider != "") ? var.repo_git_provider : "hostedgit"
  )

  change_management_repo_git_provider = (
    (var.cd_change_management_repo_git_provider != "") ? var.cd_change_management_repo_git_provider :
    (var.repo_git_provider != "") ? var.repo_git_provider : "hostedgit"
  )

  calculated_provider = (
    (var.app_repo_existing_git_provider != "") ? var.app_repo_existing_git_provider :
    (var.custom_app_repo_git_provider != "") ? var.custom_app_repo_git_provider :
    (var.repo_git_provider != "") ? var.repo_git_provider :
    (strcontains(var.app_repo_existing_url, "github")) ? "githubconsolidated" :
    (strcontains(var.app_repo_existing_url, "gitlab")) ? "gitlab" :
    (strcontains(var.app_repo_existing_url, "git.cloud.ibm.com")) ? "hostedgit" : ""
  )

  calculated_git_id = (
    (var.app_repo_existing_git_id != "") ? var.app_repo_existing_git_id :
    (var.custom_app_repo_git_id != "") ? var.custom_app_repo_git_id :
    (var.repo_git_id != "") ? var.repo_git_id :
    (strcontains(var.app_repo_existing_url, "github.ibm.com")) ? "integrated" :
    (strcontains(var.app_repo_existing_url, "github")) ? "github" :
    (strcontains(var.app_repo_existing_url, "gitlab")) ? "gitlabcustom" :
    (strcontains(var.app_repo_existing_url, "git.cloud.ibm.com")) ? "" : ""
  )

  app_repo_existing_url = (local.calculated_provider == "") ? "" : var.app_repo_existing_url

  ci_app_group = (var.ci_app_group == "") ? var.app_group : var.ci_app_group
  cc_app_group = (var.cc_app_group == "") ? var.app_group : var.cc_app_group

  # Infer app repo auth type without need to explicitly set it
  # Only set `pat` type if expected. An empty string result will default to `oauth`
  ci_app_repo_auth      = (var.ci_app_repo_auth_type == "") ? var.app_repo_auth_type : var.ci_app_repo_auth_type
  ci_app_git_token_set  = ((var.ci_app_repo_git_token_secret_name == "") && (var.app_repo_git_token_secret_name == "") && (local.ci_app_repo_git_token_secret_crn == "")) ? false : true
  ci_app_repo_auth_type = (local.ci_app_repo_auth == "" && local.ci_app_git_token_set == false) ? "" : "pat"
  cc_app_repo_auth      = (var.cc_app_repo_auth_type == "") ? var.app_repo_auth_type : var.cc_app_repo_auth_type
  cc_app_git_token_set  = ((var.cc_app_repo_git_token_secret_name == "") && (var.app_repo_git_token_secret_name == "") && (local.cc_app_repo_git_token_secret_crn == "")) ? false : true
  cc_app_repo_auth_type = (local.cc_app_repo_auth == "" && local.cc_app_git_token_set == false) ? "" : "pat"

  ci_app_repo_branch                = (var.ci_app_repo_branch == "") ? var.app_repo_branch : var.ci_app_repo_branch
  cc_app_repo_branch                = (var.cc_app_repo_branch == "") ? var.app_repo_branch : var.cc_app_repo_branch
  ci_app_repo_git_token_secret_name = (var.ci_app_repo_git_token_secret_name == "") ? var.app_repo_git_token_secret_name : var.ci_app_repo_git_token_secret_name
  cc_app_repo_git_token_secret_name = (var.cc_app_repo_git_token_secret_name == "") ? var.app_repo_git_token_secret_name : var.cc_app_repo_git_token_secret_name
  ci_app_repo_secret_group          = (var.ci_app_repo_secret_group == "") ? var.app_repo_secret_group : var.ci_app_repo_secret_group
  cc_app_repo_secret_group          = (var.cc_app_repo_secret_group == "") ? var.app_repo_secret_group : var.cc_app_repo_secret_group

  ci_app_repo_existing_url = (var.ci_app_repo_existing_url == "") ? local.app_repo_existing_url : var.ci_app_repo_existing_url
  cc_app_repo_existing_url = (var.cc_app_repo_url == "") ? local.app_repo_existing_url : var.cc_app_repo_url

  ci_app_repo_existing_git_id_temp = (var.ci_app_repo_existing_git_id == "") ? var.app_repo_existing_git_id : var.ci_app_repo_existing_git_id
  ci_app_repo_existing_git_id      = (local.ci_app_repo_existing_git_id_temp == "") ? local.calculated_git_id : local.ci_app_repo_existing_git_id_temp
  cc_app_repo_existing_git_id_temp = (var.cc_app_repo_git_id == "") ? var.app_repo_existing_git_id : var.cc_app_repo_git_id
  cc_app_repo_existing_git_id      = (local.cc_app_repo_existing_git_id_temp == "") ? local.calculated_git_id : local.cc_app_repo_existing_git_id_temp


  ci_app_repo_existing_git_provider_temp = (var.ci_app_repo_existing_git_provider == "") ? var.app_repo_existing_git_provider : var.ci_app_repo_existing_git_provider
  ci_app_repo_existing_git_provider      = (local.ci_app_repo_existing_git_provider_temp == "") ? local.calculated_provider : local.ci_app_repo_existing_git_provider_temp
  cc_app_repo_existing_git_provider_temp = (var.cc_app_repo_git_provider == "") ? var.app_repo_existing_git_provider : var.cc_app_repo_git_provider
  cc_app_repo_existing_git_provider      = (local.cc_app_repo_existing_git_provider_temp == "") ? local.calculated_provider : local.cc_app_repo_existing_git_provider_temp

  ci_app_repo_clone_to_git_id       = (var.ci_app_repo_clone_to_git_id == "") ? var.app_repo_clone_to_git_id : var.ci_app_repo_clone_to_git_id
  ci_app_repo_clone_to_git_provider = (var.ci_app_repo_clone_to_git_provider == "") ? var.app_repo_clone_to_git_provider : var.ci_app_repo_clone_to_git_provider

  deployment_repo_existing_git_id = (
    (var.cd_deployment_repo_existing_git_id != "") ? var.cd_deployment_repo_existing_git_id :
    (var.custom_app_repo_git_id != "") ? var.custom_app_repo_git_id : var.repo_git_id
  )
  deployment_repo_existing_git_provider = (
    (var.cd_deployment_repo_existing_git_provider != "") ? var.cd_deployment_repo_existing_git_provider :
    (var.custom_app_repo_git_provider != "") ? var.custom_app_repo_git_provider :
    (var.repo_git_provider != "") ? var.repo_git_provider : "hostedgit"
  )
}


data "ibm_resource_group" "resource_group" {
  name = var.toolchain_resource_group
}

resource "ibm_resource_instance" "cd_instance" {
  count             = (var.create_cd_instance) ? 1 : 0
  name              = (var.prefix == "") ? var.continuous_delivery_service_name : format("${var.prefix}-%s", var.continuous_delivery_service_name)
  service           = "continuous-delivery"
  plan              = var.cd_service_plan
  location          = var.toolchain_region
  resource_group_id = data.ibm_resource_group.resource_group.id
}

#################### ICR ###########################

resource "random_string" "resource_suffix" {
  count   = (var.add_container_name_suffix) ? 1 : 0
  length  = 4
  special = false
  upper   = false
}

resource "ibm_cr_namespace" "cr_namespace" {
  count             = ((var.registry_namespace != "") && (var.create_icr_namespace == true)) ? 1 : 0
  name              = local.registry_namespace
  resource_group_id = data.ibm_resource_group.resource_group.id
}

module "prereqs" {
  count                                  = (local.enable_prereqs) ? 1 : 0
  source                                 = "./prereqs"
  ibmcloud_api_key                       = var.ibmcloud_api_key
  create_ibmcloud_api_key                = var.create_ibmcloud_api_key
  force_create_standard_api_key          = var.force_create_standard_api_key
  create_cos_api_key                     = var.create_cos_api_key
  create_git_token                       = var.create_git_token
  create_privateworker_secret            = var.create_privateworker_secret
  create_signing_key                     = var.create_signing_key
  service_name_pipeline                  = var.service_name_pipeline
  service_name_cos                       = var.service_name_cos
  sm_name                                = var.sm_name
  sm_location                            = var.sm_location
  sm_secret_group_name                   = var.sm_secret_group
  sm_resource_group                      = var.sm_resource_group
  create_secret_group                    = var.create_secret_group
  cos_api_key_secret_name                = var.cos_api_key_secret_name
  iam_api_key_secret_name                = var.pipeline_ibmcloud_api_key_secret_name
  privateworker_secret_name              = var.privateworker_credentials_secret_name
  privateworker_secret_value             = var.privateworker_secret_value
  signing_key_secret_name                = var.ci_signing_key_secret_name
  signing_certifcate_secret_name         = var.cd_code_signing_cert_secret_name
  repo_git_token_secret_name             = var.repo_git_token_secret_name
  repo_git_token_secret_value            = var.repo_git_token_secret_value
  custom_app_repo_git_token_secret_name  = var.custom_app_repo_git_token_secret_name
  custom_app_repo_git_token_secret_value = var.custom_app_repo_git_token_secret_value
  rotation_period                        = var.rotation_period
  rotate_signing_key                     = var.rotate_signing_key
  sm_secret_expiration_period            = var.sm_secret_expiration_period
  sm_exists                              = var.enable_secrets_manager
  sm_endpoint_type                       = var.sm_endpoint_type
  create_code_engine_access_policy       = var.create_code_engine_access_policy
  create_kubernetes_access_policy        = var.create_kubernetes_access_policy
}

module "devsecops_ci_toolchain" {
  count                    = var.create_ci_toolchain ? 1 : 0
  depends_on               = [ibm_resource_instance.cd_instance]
  source                   = "git::https://github.com/terraform-ibm-modules/terraform-ibm-devsecops-ci-toolchain?ref=v2.3.0"
  ibmcloud_api_key         = var.ibmcloud_api_key
  toolchain_name           = (var.prefix == "") ? local.ci_toolchain_name : format("${var.prefix}-%s", local.ci_toolchain_name)
  toolchain_region         = (var.ci_toolchain_region == "") ? var.toolchain_region : replace(replace(var.ci_toolchain_region, "ibm:yp:", ""), "ibm:ys1:", "")
  toolchain_resource_group = (var.ci_toolchain_resource_group == "") ? var.toolchain_resource_group : var.ci_toolchain_resource_group
  toolchain_description    = var.ci_toolchain_description
  registry_namespace       = local.registry_namespace
  ci_pipeline_branch       = (var.ci_compliance_pipeline_branch == "") ? var.compliance_pipeline_branch : var.ci_compliance_pipeline_branch
  pr_pipeline_branch       = (var.ci_compliance_pipeline_pr_branch == "") ? var.compliance_pipeline_branch : var.ci_compliance_pipeline_pr_branch
  ci_pipeline_git_tag      = (var.ci_pipeline_git_tag == "") ? var.pipeline_git_tag : var.ci_pipeline_git_tag
  pr_pipeline_git_tag      = (var.pr_pipeline_git_tag == "") ? var.pipeline_git_tag : var.pr_pipeline_git_tag
  worker_id                = var.worker_id

  #SECRET PROVIDERS
  enable_key_protect       = (local.ci_enable_key_protect == "true") ? true : false
  enable_secrets_manager   = (local.ci_enable_secrets_manager == "true") ? true : false
  sm_name                  = (var.ci_sm_name == "") ? var.sm_name : var.ci_sm_name
  sm_location              = (var.ci_sm_location == "") ? replace(replace(var.sm_location, "ibm:yp:", ""), "ibm:ys1:", "") : replace(replace(var.ci_sm_location, "ibm:yp:", ""), "ibm:ys1:", "")
  sm_resource_group        = (var.ci_sm_resource_group != "") ? var.ci_sm_resource_group : (var.sm_resource_group != "") ? var.sm_resource_group : var.toolchain_resource_group
  sm_secret_group          = (var.ci_sm_secret_group == "") ? var.sm_secret_group : var.ci_sm_secret_group
  kp_name                  = (var.ci_kp_name == "") ? var.kp_name : var.ci_kp_name
  kp_location              = (var.ci_kp_location == "") ? replace(replace(var.kp_location, "ibm:yp:", ""), "ibm:ys1:", "") : replace(replace(var.ci_kp_location, "ibm:yp:", ""), "ibm:ys1:", "")
  kp_resource_group        = (var.ci_kp_resource_group != "") ? var.ci_kp_resource_group : (var.kp_resource_group != "") ? var.kp_resource_group : var.toolchain_resource_group
  sm_instance_crn          = (var.ci_sm_instance_crn != "") ? var.ci_sm_instance_crn : var.sm_instance_crn
  add_pipeline_definitions = var.add_pipeline_definitions

  #SECRET NAMES
  pipeline_ibmcloud_api_key_secret_name  = (var.ci_pipeline_ibmcloud_api_key_secret_name == "") ? var.pipeline_ibmcloud_api_key_secret_name : var.ci_pipeline_ibmcloud_api_key_secret_name
  pipeline_ibmcloud_api_key_secret_group = (var.ci_pipeline_ibmcloud_api_key_secret_group == "") ? var.pipeline_ibmcloud_api_key_secret_group : var.ci_pipeline_ibmcloud_api_key_secret_group

  cos_api_key_secret_name  = (var.ci_cos_api_key_secret_name == "") ? var.cos_api_key_secret_name : var.ci_cos_api_key_secret_name
  cos_api_key_secret_group = (var.ci_cos_api_key_secret_group == "") ? var.cos_api_key_secret_group : var.ci_cos_api_key_secret_group

  slack_webhook_secret_name  = (var.ci_slack_webhook_secret_name == "") ? var.slack_webhook_secret_name : var.ci_slack_webhook_secret_name
  slack_webhook_secret_group = (var.ci_slack_webhook_secret_group == "") ? var.slack_webhook_secret_group : var.ci_slack_webhook_secret_group

  issues_repo_git_token_secret_name = (local.ci_issues_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : local.ci_issues_repo_git_token_secret_name
  issues_repo_secret_group          = (local.ci_issues_repo_secret_group == "") ? var.repo_secret_group : local.ci_issues_repo_secret_group

  evidence_repo_git_token_secret_name = (local.ci_evidence_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : local.ci_evidence_repo_git_token_secret_name
  evidence_repo_secret_group          = (local.ci_evidence_repo_secret_group == "") ? var.repo_secret_group : local.ci_evidence_repo_secret_group

  inventory_repo_git_token_secret_name = (local.ci_inventory_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : local.ci_inventory_repo_git_token_secret_name
  inventory_repo_secret_group          = (local.ci_inventory_repo_secret_group == "") ? var.repo_secret_group : local.ci_inventory_repo_secret_group

  compliance_pipeline_repo_git_token_secret_name = (local.ci_compliance_pipeline_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : local.ci_compliance_pipeline_repo_git_token_secret_name
  compliance_pipeline_repo_secret_group          = (local.ci_compliance_pipeline_repo_secret_group == "") ? var.repo_secret_group : local.ci_compliance_pipeline_repo_secret_group

  pipeline_config_repo_git_token_secret_name = (
    (local.ci_pipeline_config_repo_git_token_secret_name != "") ? local.ci_pipeline_config_repo_git_token_secret_name :
    (var.custom_app_repo_git_token_secret_name != "") ? var.custom_app_repo_git_token_secret_name : var.repo_git_token_secret_name
  )

  pipeline_config_repo_secret_group = (local.ci_pipeline_config_repo_secret_group == "") ? var.repo_secret_group : local.ci_pipeline_config_repo_secret_group

  app_repo_git_token_secret_name = (
    (local.ci_app_repo_git_token_secret_name != "") ? local.ci_app_repo_git_token_secret_name :
    (var.custom_app_repo_git_token_secret_name != "") ? var.custom_app_repo_git_token_secret_name : var.repo_git_token_secret_name
  )
  app_repo_secret_group = (local.ci_app_repo_secret_group == "") ? var.repo_secret_group : local.ci_app_repo_secret_group

  pipeline_doi_api_key_secret_name  = (var.ci_pipeline_doi_api_key_secret_name == "") ? var.pipeline_doi_api_key_secret_name : var.ci_pipeline_doi_api_key_secret_name
  pipeline_doi_api_key_secret_group = (var.ci_pipeline_doi_api_key_secret_group == "") ? var.pipeline_doi_api_key_secret_group : var.ci_pipeline_doi_api_key_secret_group

  # CRN SECRETS
  app_repo_git_token_secret_crn = (
    (local.ci_app_repo_git_token_secret_crn != "") ? local.ci_app_repo_git_token_secret_crn :
    (var.custom_app_repo_git_token_secret_crn != "") ? var.custom_app_repo_git_token_secret_crn : var.repo_git_token_secret_crn
  )
  issues_repo_git_token_secret_crn              = (local.ci_issues_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : local.ci_issues_repo_git_token_secret_crn
  evidence_repo_git_token_secret_crn            = (local.ci_evidence_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : local.ci_evidence_repo_git_token_secret_crn
  inventory_repo_git_token_secret_crn           = (local.ci_inventory_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : local.ci_inventory_repo_git_token_secret_crn
  compliance_pipeline_repo_git_token_secret_crn = (local.ci_compliance_pipeline_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : local.ci_pipeline_config_repo_git_token_secret_crn
  pipeline_config_repo_git_token_secret_crn = (
    (local.ci_pipeline_config_repo_git_token_secret_crn != "") ? local.ci_pipeline_config_repo_git_token_secret_crn :
    (var.custom_app_repo_git_token_secret_crn != "") ? var.custom_app_repo_git_token_secret_crn : var.repo_git_token_secret_crn
  )
  cos_api_key_secret_crn               = (var.ci_cos_api_key_secret_crn == "") ? var.cos_api_key_secret_crn : var.ci_cos_api_key_secret_crn
  pipeline_ibmcloud_api_key_secret_crn = (var.ci_pipeline_ibmcloud_api_key_secret_crn == "") ? var.pipeline_ibmcloud_api_key_secret_crn : var.ci_pipeline_ibmcloud_api_key_secret_crn
  slack_webhook_secret_crn             = (var.ci_slack_webhook_secret_crn == "") ? var.slack_webhook_secret_crn : var.ci_slack_webhook_secret_crn
  privateworker_credentials_secret_crn = (var.ci_privateworker_credentials_secret_crn == "") ? var.privateworker_credentials_secret_crn : var.ci_privateworker_credentials_secret_crn
  artifactory_token_secret_crn         = var.ci_artifactory_token_secret_crn
  pipeline_doi_api_key_secret_crn      = var.ci_pipeline_doi_api_key_secret_crn
  sonarqube_secret_crn                 = (var.ci_sonarqube_secret_crn == "") ? var.sonarqube_secret_crn : var.ci_sonarqube_secret_crn

  #AUTH TYPE FOR REPOS
  pipeline_config_repo_auth_type = (
    (local.ci_pipeline_config_repo_auth_type != "") ? local.ci_pipeline_config_repo_auth_type :
    (local.custom_app_repo_auth_type != "") ? local.custom_app_repo_auth_type : local.repo_auth_type
  )
  inventory_repo_auth_type = (local.ci_inventory_repo_auth_type == "") ? local.repo_auth_type : local.ci_inventory_repo_auth_type
  issues_repo_auth_type    = (local.ci_issues_repo_auth_type == "") ? local.repo_auth_type : local.ci_issues_repo_auth_type
  evidence_repo_auth_type  = (local.ci_evidence_repo_auth_type == "") ? local.repo_auth_type : local.ci_evidence_repo_auth_type
  app_repo_auth_type = (
    (local.ci_app_repo_auth_type != "") ? local.ci_app_repo_auth_type :
    (local.custom_app_repo_auth_type != "") ? local.custom_app_repo_auth_type : local.repo_auth_type
  )
  compliance_pipeline_repo_auth_type = (var.compliance_pipeline_repo_use_group_settings) ? local.repo_auth_type : local.ci_compliance_pipeline_repo_auth_type

  #GROUPS/USERS FOR REPOS
  app_group = (
    (local.ci_app_group != "") ? local.ci_app_group :
    (var.custom_app_repo_group != "") ? var.custom_app_repo_group : var.repo_group
  )
  issues_group    = (local.ci_issues_group == "") ? var.repo_group : local.ci_issues_group
  inventory_group = (local.ci_inventory_group == "") ? var.repo_group : local.ci_inventory_group
  evidence_group  = (local.ci_evidence_group == "") ? var.repo_group : local.ci_evidence_group
  pipeline_config_group = (
    (local.ci_pipeline_config_group != "") ? local.ci_pipeline_config_group :
    (var.custom_app_repo_group != "") ? var.custom_app_repo_group : var.repo_group
  )
  compliance_pipeline_group = (var.compliance_pipeline_repo_use_group_settings) ? var.repo_group : local.ci_compliance_pipeline_group

  #APP REPO
  app_repo_clone_from_url        = (local.ci_app_repo_clone_from_url == "") ? local.app_source_repo_url : local.ci_app_repo_clone_from_url
  app_repo_branch                = local.ci_app_repo_branch
  app_repo_existing_url          = local.ci_app_repo_existing_url
  app_repo_existing_git_provider = local.ci_app_repo_existing_git_provider
  app_repo_existing_git_id       = local.ci_app_repo_existing_git_id
  app_repo_clone_to_git_provider = local.ci_app_repo_clone_to_git_provider
  app_repo_clone_to_git_id       = local.ci_app_repo_clone_to_git_id
  app_repo_blind_connection      = (var.custom_app_repo_blind_connection == "") ? var.repo_blind_connection : var.custom_app_repo_blind_connection
  app_repo_root_url              = (var.custom_app_repo_root_url == "") ? var.repo_root_url : var.custom_app_repo_root_url
  app_repo_title                 = (var.custom_app_repo_title == "") ? var.repo_title : var.custom_app_repo_title

  #COMPLIANCE PIPELINE REPO
  compliance_pipelines_repo_blind_connection = (var.compliance_pipeline_repo_use_group_settings) ? var.repo_blind_connection : var.compliance_pipeline_repo_blind_connection
  compliance_pipelines_repo_root_url         = (var.compliance_pipeline_repo_use_group_settings) ? var.repo_root_url : var.compliance_pipeline_repo_root_url
  compliance_pipelines_repo_title            = (var.compliance_pipeline_repo_use_group_settings) ? var.repo_title : var.compliance_pipeline_repo_title
  compliance_pipeline_repo_git_provider      = local.compliance_pipeline_repo_existing_git_provider
  compliance_pipelines_repo_git_id           = (var.compliance_pipeline_repo_use_group_settings) ? var.repo_git_id : var.compliance_pipeline_repo_git_id
  compliance_pipeline_existing_repo_url      = var.compliance_pipeline_existing_repo_url
  compliance_pipeline_source_repo_url        = var.compliance_pipeline_source_repo_url
  compliance_pipelines_repo_name             = var.compliance_pipeline_repo_name

  #PIPELINE CONFIG REPO
  pipeline_config_repo_existing_url   = local.ci_pipeline_config_repo_existing_url
  pipeline_config_repo_clone_from_url = local.ci_pipeline_config_repo_clone_from_url
  pipeline_config_repo_git_provider   = local.pipeline_config_repo_git_provider
  pipeline_config_repo_git_id = (
    (var.pipeline_config_repo_git_id != "") ? var.pipeline_config_repo_git_id :
    (var.custom_app_repo_git_id != "") ? var.custom_app_repo_git_id : var.repo_git_id
  )
  pipeline_config_repo_branch           = (local.ci_pipeline_config_repo_branch == "") ? local.ci_app_repo_branch : local.ci_pipeline_config_repo_branch
  pipeline_config_repo_blind_connection = (var.custom_app_repo_blind_connection == "") ? var.repo_blind_connection : var.custom_app_repo_blind_connection
  pipeline_config_repo_root_url         = (var.custom_app_repo_root_url == "") ? var.repo_root_url : var.custom_app_repo_root_url
  pipeline_config_repo_title            = (var.custom_app_repo_title == "") ? var.repo_title : var.custom_app_repo_title

  #EVIDENCE REPO
  evidence_repo_name              = var.evidence_repo_name
  evidence_repo_existing_url      = var.evidence_repo_existing_url
  evidence_repo_git_provider      = local.evidence_repo_existing_git_provider
  evidence_repo_git_id            = (var.evidence_repo_existing_git_id == "") ? var.repo_git_id : var.evidence_repo_existing_git_id
  evidence_repo_integration_owner = var.evidence_repo_integration_owner
  evidence_repo_blind_connection  = var.repo_blind_connection
  evidence_repo_root_url          = var.repo_root_url
  evidence_repo_title             = var.repo_title

  #ISSUES REPO
  issues_repo_name              = var.issues_repo_name
  issues_repo_existing_url      = var.issues_repo_existing_url
  issues_repo_git_provider      = local.issues_repo_existing_git_provider
  issues_repo_git_id            = (var.issues_repo_existing_git_id == "") ? var.repo_git_id : var.issues_repo_existing_git_id
  issues_repo_integration_owner = var.issues_repo_integration_owner
  issues_repo_blind_connection  = var.repo_blind_connection
  issues_repo_root_url          = var.repo_root_url
  issues_repo_title             = var.repo_title

  #INVENTORY REPO
  inventory_repo_name              = var.inventory_repo_name
  inventory_repo_existing_url      = var.inventory_repo_existing_url
  inventory_repo_git_provider      = local.inventory_repo_existing_git_provider
  inventory_repo_git_id            = (var.inventory_repo_existing_git_id == "") ? var.repo_git_id : var.inventory_repo_existing_git_id
  inventory_repo_integration_owner = var.inventory_repo_integration_owner
  inventory_repo_blind_connection  = var.repo_blind_connection
  inventory_repo_root_url          = var.repo_root_url
  inventory_repo_title             = var.repo_title

  app_name                           = var.ci_app_name
  signing_key_secret_name            = var.ci_signing_key_secret_name
  registry_region                    = (var.ci_registry_region == "") ? format("${var.environment_prefix}%s", var.toolchain_region) : format("${var.environment_prefix}%s", replace(replace(var.ci_registry_region, "ibm:yp:", ""), "ibm:ys1:", ""))
  authorization_policy_creation      = (var.ci_authorization_policy_creation == "") ? var.authorization_policy_creation : var.ci_authorization_policy_creation
  repositories_prefix                = (local.ci_repositories_prefix == "compliance" && var.prefix != "") ? format("%s-%s", var.prefix, local.ci_repositories_prefix) : local.ci_repositories_prefix
  doi_toolchain_id                   = var.ci_doi_toolchain_id
  doi_toolchain_id_pipeline_property = var.ci_doi_toolchain_id_pipeline_property
  enable_pipeline_notifications      = (local.ci_enable_pipeline_notifications == "true") ? true : false
  pipeline_properties                = var.ci_pipeline_properties
  pipeline_properties_filepath       = var.ci_pipeline_properties_filepath
  repository_properties              = var.ci_repository_properties
  repository_properties_filepath     = var.ci_repository_properties_filepath

  #CODE ENGINE
  code_engine_project        = local.ci_code_engine_project_name
  code_engine_region         = (var.ci_code_engine_region == "") ? var.toolchain_region : var.ci_code_engine_region
  code_engine_resource_group = (var.ci_code_engine_resource_group == "") ? var.toolchain_resource_group : var.ci_code_engine_resource_group

  #CLUSTER
  dev_region         = format("${var.environment_prefix}%s", replace(replace(local.calculated_ci_cluster_region, "ibm:yp:", ""), "ibm:ys1:", ""))
  dev_resource_group = (var.ci_cluster_resource_group != "") ? var.ci_cluster_resource_group : var.toolchain_resource_group
  cluster_name       = (var.ci_cluster_name == "") ? var.cluster_name : var.ci_cluster_name
  cluster_namespace  = var.ci_cluster_namespace

  #OTHER INTEGRATIONS

  #SLACK INTEGRATION
  enable_slack           = (local.ci_enable_slack == "true") ? true : false
  slack_channel_name     = (var.ci_slack_channel_name == "") ? var.slack_channel_name : var.ci_slack_channel_name
  slack_team_name        = (var.ci_slack_team_name == "") ? var.slack_team_name : var.ci_slack_team_name
  slack_pipeline_fail    = var.ci_slack_pipeline_fail
  slack_pipeline_start   = var.ci_slack_pipeline_start
  slack_pipeline_success = var.ci_slack_pipeline_success
  slack_toolchain_bind   = var.ci_slack_toolchain_bind
  slack_toolchain_unbind = var.ci_slack_toolchain_unbind

  # PRIVATE WORKER
  privateworker_credentials_secret_group = var.privateworker_credentials_secret_group
  privateworker_credentials_secret_name  = var.privateworker_credentials_secret_name
  privateworker_name                     = var.privateworker_name
  enable_privateworker                   = var.enable_privateworker

  #SONARQUBE
  sonarqube_integration_name    = (var.ci_sonarqube_integration_name == "") ? var.sonarqube_integration_name : var.ci_sonarqube_integration_name
  sonarqube_user                = (var.ci_sonarqube_user == "") ? var.sonarqube_user : var.ci_sonarqube_user
  sonarqube_secret_name         = (var.ci_sonarqube_secret_name == "") ? var.sonarqube_secret_name : var.ci_sonarqube_secret_name
  sonarqube_secret_group        = (var.ci_sonarqube_secret_group == "") ? var.sonarqube_secret_group : var.ci_sonarqube_secret_group
  sonarqube_is_blind_connection = (var.ci_sonarqube_is_blind_connection == "") ? var.sonarqube_is_blind_connection : var.ci_sonarqube_is_blind_connection
  sonarqube_server_url          = (var.ci_sonarqube_server_url == "") ? var.sonarqube_server_url : var.ci_sonarqube_server_url

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
  create_triggers              = var.create_triggers
  create_git_triggers          = var.create_git_triggers
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
  depends_on       = [ibm_resource_instance.cd_instance]
  source           = "git::https://github.com/terraform-ibm-modules/terraform-ibm-devsecops-cd-toolchain?ref=v2.3.0"
  ibmcloud_api_key = var.ibmcloud_api_key

  toolchain_name           = (var.prefix == "") ? local.cd_toolchain_name : format("${var.prefix}-%s", local.cd_toolchain_name)
  toolchain_description    = var.cd_toolchain_description
  toolchain_region         = (var.cd_toolchain_region == "") ? var.toolchain_region : replace(replace(var.cd_toolchain_region, "ibm:yp:", ""), "ibm:ys1:", "")
  toolchain_resource_group = (var.cd_toolchain_resource_group == "") ? var.toolchain_resource_group : var.cd_toolchain_resource_group
  pipeline_branch          = (var.cd_compliance_pipeline_branch == "") ? var.compliance_pipeline_branch : var.cd_compliance_pipeline_branch
  pipeline_git_tag         = (var.cd_pipeline_git_tag == "") ? var.pipeline_git_tag : var.cd_pipeline_git_tag
  worker_id                = var.worker_id

  #SECRET PROVIDERS
  enable_key_protect       = (local.cd_enable_key_protect == "true") ? true : false
  enable_secrets_manager   = (local.cd_enable_secrets_manager == "true") ? true : false
  sm_name                  = (var.cd_sm_name == "") ? var.sm_name : var.cd_sm_name
  sm_location              = (var.cd_sm_location == "") ? replace(replace(var.sm_location, "ibm:yp:", ""), "ibm:ys1:", "") : replace(replace(var.cd_sm_location, "ibm:yp:", ""), "ibm:ys1:", "")
  sm_resource_group        = (var.cd_sm_resource_group != "") ? var.cd_sm_resource_group : (var.sm_resource_group != "") ? var.sm_resource_group : var.toolchain_resource_group
  sm_secret_group          = (var.cd_sm_secret_group == "") ? var.sm_secret_group : var.cd_sm_secret_group
  kp_name                  = (var.cd_kp_name == "") ? var.kp_name : var.cd_kp_name
  kp_location              = (var.cd_kp_location == "") ? replace(replace(var.kp_location, "ibm:yp:", ""), "ibm:ys1:", "") : replace(replace(var.cd_kp_location, "ibm:yp:", ""), "ibm:ys1:", "")
  kp_resource_group        = (var.cd_kp_resource_group != "") ? var.cd_kp_resource_group : (var.kp_resource_group != "") ? var.kp_resource_group : var.toolchain_resource_group
  sm_instance_crn          = (var.cd_sm_instance_crn != "") ? var.cd_sm_instance_crn : var.sm_instance_crn
  add_pipeline_definitions = var.add_pipeline_definitions

  #SECRET NAMES AND SECRET GROUPS
  pipeline_ibmcloud_api_key_secret_name  = (var.cd_pipeline_ibmcloud_api_key_secret_name == "") ? var.pipeline_ibmcloud_api_key_secret_name : var.cd_pipeline_ibmcloud_api_key_secret_name
  pipeline_ibmcloud_api_key_secret_group = (var.cd_pipeline_ibmcloud_api_key_secret_group == "") ? var.pipeline_ibmcloud_api_key_secret_group : var.cd_pipeline_ibmcloud_api_key_secret_group

  cos_api_key_secret_name  = (var.cd_cos_api_key_secret_name == "") ? var.cos_api_key_secret_name : var.cd_cos_api_key_secret_name
  cos_api_key_secret_group = (var.cd_cos_api_key_secret_group == "") ? var.cos_api_key_secret_group : var.cd_cos_api_key_secret_group

  issues_repo_git_token_secret_name = (local.cd_issues_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : local.cd_issues_repo_git_token_secret_name
  issues_repo_secret_group          = (local.cd_issues_repo_secret_group == "") ? var.repo_secret_group : local.cd_issues_repo_secret_group

  evidence_repo_git_token_secret_name = (local.cd_evidence_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : local.cd_evidence_repo_git_token_secret_name
  evidence_repo_secret_group          = (local.cd_evidence_repo_secret_group == "") ? var.repo_secret_group : local.cd_evidence_repo_secret_group

  inventory_repo_git_token_secret_name = (local.cd_inventory_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : local.cd_inventory_repo_git_token_secret_name
  inventory_repo_secret_group          = (local.cd_inventory_repo_secret_group == "") ? var.repo_secret_group : local.cd_inventory_repo_secret_group

  compliance_pipeline_repo_git_token_secret_name = (local.cd_compliance_pipeline_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : local.cd_compliance_pipeline_repo_git_token_secret_name
  compliance_pipeline_repo_secret_group          = (local.cd_compliance_pipeline_repo_secret_group == "") ? var.repo_secret_group : local.cd_compliance_pipeline_repo_secret_group

  pipeline_config_repo_git_token_secret_name = (
    (local.cd_pipeline_config_repo_git_token_secret_name != "") ? local.cd_pipeline_config_repo_git_token_secret_name :
    (var.custom_app_repo_git_token_secret_name != "") ? var.custom_app_repo_git_token_secret_name : var.repo_git_token_secret_name
  )

  pipeline_config_repo_secret_group = (local.cd_pipeline_config_repo_secret_group == "") ? var.repo_secret_group : local.cd_pipeline_config_repo_secret_group

  deployment_repo_git_token_secret_name = (
    (var.cd_deployment_repo_git_token_secret_name != "") ? var.cd_deployment_repo_git_token_secret_name :
    (var.custom_app_repo_git_token_secret_name != "") ? var.custom_app_repo_git_token_secret_name : var.repo_git_token_secret_name
  )

  deployment_repo_secret_group = (var.cd_deployment_repo_secret_group == "") ? var.repo_secret_group : var.cd_deployment_repo_secret_group

  change_management_repo_git_token_secret_name = (var.cd_change_management_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : var.cd_change_management_repo_git_token_secret_name
  change_management_repo_secret_group          = (var.cd_change_management_repo_secret_group == "") ? var.repo_secret_group : var.cd_change_management_repo_secret_group

  slack_webhook_secret_name = (var.cd_slack_webhook_secret_name == "") ? var.slack_webhook_secret_name : var.cd_slack_webhook_secret_name

  slack_webhook_secret_group = (var.cd_slack_webhook_secret_group == "") ? var.slack_webhook_secret_group : var.cd_slack_webhook_secret_group

  scc_scc_api_key_secret_name  = var.scc_scc_api_key_secret_name
  scc_scc_api_key_secret_group = var.scc_scc_api_key_secret_group

  pipeline_doi_api_key_secret_name  = (var.cd_pipeline_doi_api_key_secret_name == "") ? var.pipeline_doi_api_key_secret_name : var.cd_pipeline_doi_api_key_secret_name
  pipeline_doi_api_key_secret_group = (var.cd_pipeline_doi_api_key_secret_group == "") ? var.pipeline_doi_api_key_secret_group : var.cd_pipeline_doi_api_key_secret_group

  # CRN SECRETS
  deployment_repo_git_token_secret_crn = (
    (var.cd_deployment_repo_git_token_secret_crn != "") ? var.cd_deployment_repo_git_token_secret_crn :
    (var.custom_app_repo_git_token_secret_crn != "") ? var.custom_app_repo_git_token_secret_crn : var.repo_git_token_secret_crn
  )
  change_management_repo_git_token_secret_crn   = (var.cd_change_management_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : var.cd_change_management_repo_git_token_secret_crn
  issues_repo_git_token_secret_crn              = (local.cd_issues_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : local.cd_issues_repo_git_token_secret_crn
  evidence_repo_git_token_secret_crn            = (local.cd_evidence_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : local.cd_evidence_repo_git_token_secret_crn
  inventory_repo_git_token_secret_crn           = (local.cd_inventory_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : local.cd_inventory_repo_git_token_secret_crn
  compliance_pipeline_repo_git_token_secret_crn = (local.cd_compliance_pipeline_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : local.cd_compliance_pipeline_repo_git_token_secret_crn
  pipeline_config_repo_git_token_secret_crn = (
    (local.cd_pipeline_config_repo_git_token_secret_crn != "") ? local.cd_pipeline_config_repo_git_token_secret_crn :
    (var.custom_app_repo_git_token_secret_crn != "") ? var.custom_app_repo_git_token_secret_crn : var.repo_git_token_secret_crn
  )
  cos_api_key_secret_crn               = (var.cd_cos_api_key_secret_crn == "") ? var.cos_api_key_secret_crn : var.cd_cos_api_key_secret_crn
  pipeline_ibmcloud_api_key_secret_crn = (var.cd_pipeline_ibmcloud_api_key_secret_crn == "") ? var.pipeline_ibmcloud_api_key_secret_crn : var.cd_pipeline_ibmcloud_api_key_secret_crn
  slack_webhook_secret_crn             = (var.cd_slack_webhook_secret_crn == "") ? var.slack_webhook_secret_crn : var.cd_slack_webhook_secret_crn
  privateworker_credentials_secret_crn = (var.cd_privateworker_credentials_secret_crn == "") ? var.privateworker_credentials_secret_crn : var.cd_privateworker_credentials_secret_crn
  artifactory_token_secret_crn         = var.cd_artifactory_token_secret_crn
  scc_scc_api_key_secret_crn           = var.scc_scc_api_key_secret_crn
  pipeline_doi_api_key_secret_crn      = (var.cd_pipeline_doi_api_key_secret_crn == "") ? var.pipeline_doi_api_key_secret_crn : var.cd_pipeline_doi_api_key_secret_crn

  #AUTH TYPE FOR REPOS
  pipeline_config_repo_auth_type = (
    (local.cd_pipeline_config_repo_auth_type != "") ? local.cd_pipeline_config_repo_auth_type :
    (local.custom_app_repo_auth_type != "") ? local.custom_app_repo_auth_type : local.repo_auth_type
  )
  inventory_repo_auth_type = (local.cd_inventory_repo_auth_type == "") ? local.repo_auth_type : local.cd_inventory_repo_auth_type
  issues_repo_auth_type    = (local.cd_issues_repo_auth_type == "") ? local.repo_auth_type : local.cd_issues_repo_auth_type
  evidence_repo_auth_type  = (local.cd_evidence_repo_auth_type == "") ? local.repo_auth_type : local.cd_evidence_repo_auth_type
  deployment_repo_auth_type = (
    (var.cd_deployment_repo_auth_type != "") ? var.cd_deployment_repo_auth_type :
    (local.custom_app_repo_auth_type != "") ? local.custom_app_repo_auth_type : local.repo_auth_type
  )
  compliance_pipeline_repo_auth_type = (var.compliance_pipeline_repo_use_group_settings) ? local.repo_auth_type : local.cd_compliance_pipeline_repo_auth_type
  change_management_repo_auth_type   = (var.cd_change_management_repo_auth_type == "") ? local.repo_auth_type : var.cd_change_management_repo_auth_type

  #GROUPS/USERS FOR REPOS
  issues_group    = (local.cd_issues_group == "") ? var.repo_group : local.cd_issues_group
  inventory_group = (local.cd_inventory_group == "") ? var.repo_group : local.cd_inventory_group
  evidence_group  = (local.cd_evidence_group == "") ? var.repo_group : local.cd_evidence_group
  pipeline_config_group = (
    (local.cd_pipeline_config_group != "") ? local.cd_pipeline_config_group :
    (var.custom_app_repo_group != "") ? var.custom_app_repo_group : var.repo_group
  )
  compliance_pipeline_group = (var.compliance_pipeline_repo_use_group_settings) ? var.repo_group : local.cd_compliance_pipeline_group
  deployment_group = (
    (var.cd_deployment_group != "") ? var.cd_deployment_group :
    (var.custom_app_repo_group != "") ? var.custom_app_repo_group : var.repo_group
  )
  change_management_group = (var.cd_change_management_group == "") ? var.repo_group : var.cd_change_management_group

  #COMPLIANCE PIPELINE REPO
  compliance_pipelines_repo_blind_connection = (var.compliance_pipeline_repo_use_group_settings) ? var.repo_blind_connection : var.compliance_pipeline_repo_blind_connection
  compliance_pipelines_repo_root_url         = (var.compliance_pipeline_repo_use_group_settings) ? var.repo_root_url : var.compliance_pipeline_repo_root_url
  compliance_pipelines_repo_title            = (var.compliance_pipeline_repo_use_group_settings) ? var.repo_title : var.compliance_pipeline_repo_title
  compliance_pipeline_repo_git_provider      = local.compliance_pipeline_repo_existing_git_provider
  compliance_pipelines_repo_git_id           = (var.compliance_pipeline_repo_use_group_settings) ? var.repo_git_id : var.compliance_pipeline_repo_git_id
  compliance_pipeline_existing_repo_url      = var.compliance_pipeline_existing_repo_url
  compliance_pipeline_source_repo_url        = var.compliance_pipeline_source_repo_url
  compliance_pipelines_repo_name             = var.compliance_pipeline_repo_name

  #PIPELINE CONFIG REPO
  pipeline_config_repo_existing_url   = local.cd_pipeline_config_repo_existing_url
  pipeline_config_repo_clone_from_url = local.cd_pipeline_config_repo_clone_from_url
  pipeline_config_repo_git_provider   = local.pipeline_config_repo_git_provider
  pipeline_config_repo_git_id = (
    (var.pipeline_config_repo_git_id != "") ? var.pipeline_config_repo_git_id :
    (var.custom_app_repo_git_id != "") ? var.custom_app_repo_git_id : var.repo_git_id
  )
  pipeline_config_repo_branch           = (local.cd_pipeline_config_repo_branch == "") ? "master" : local.cd_pipeline_config_repo_branch
  pipeline_config_repo_blind_connection = (var.custom_app_repo_blind_connection == "") ? var.repo_blind_connection : var.custom_app_repo_blind_connection
  pipeline_config_repo_root_url         = (var.custom_app_repo_root_url == "") ? var.repo_root_url : var.custom_app_repo_root_url
  pipeline_config_repo_title            = (var.custom_app_repo_title == "") ? var.repo_title : var.custom_app_repo_title

  #EVIDENCE REPO
  evidence_repo_name              = var.evidence_repo_name
  evidence_repo_url               = try(module.devsecops_ci_toolchain[0].evidence_repo_url, var.evidence_repo_existing_url)
  evidence_repo_git_provider      = local.evidence_repo_existing_git_provider
  evidence_repo_git_id            = (var.evidence_repo_existing_git_id == "") ? var.repo_git_id : var.evidence_repo_existing_git_id
  evidence_repo_integration_owner = var.evidence_repo_integration_owner
  evidence_repo_blind_connection  = var.repo_blind_connection
  evidence_repo_root_url          = var.repo_root_url
  evidence_repo_title             = var.repo_title

  #ISSUES REPO
  issues_repo_name              = var.issues_repo_name
  issues_repo_url               = try(module.devsecops_ci_toolchain[0].issues_repo_url, var.issues_repo_existing_url)
  issues_repo_git_provider      = local.issues_repo_existing_git_provider
  issues_repo_git_id            = (var.issues_repo_existing_git_id == "") ? var.repo_git_id : var.issues_repo_existing_git_id
  issues_repo_integration_owner = var.issues_repo_integration_owner
  issues_repo_blind_connection  = var.repo_blind_connection
  issues_repo_root_url          = var.repo_root_url
  issues_repo_title             = var.repo_title

  #INVENTORY REPO
  inventory_repo_name              = var.inventory_repo_name
  inventory_repo_url               = try(module.devsecops_ci_toolchain[0].inventory_repo_url, var.inventory_repo_existing_url)
  inventory_repo_git_provider      = local.inventory_repo_existing_git_provider
  inventory_repo_git_id            = (var.inventory_repo_existing_git_id == "") ? var.repo_git_id : var.inventory_repo_existing_git_id
  inventory_repo_integration_owner = var.inventory_repo_integration_owner
  inventory_repo_blind_connection  = var.repo_blind_connection
  inventory_repo_root_url          = var.repo_root_url
  inventory_repo_title             = var.repo_title

  #CHANGE MANAGEMENT REPO
  enable_change_management_repo           = true
  change_repo_clone_from_url              = var.cd_change_repo_clone_from_url
  change_management_repo_blind_connection = var.repo_blind_connection
  change_management_repo_root_url         = var.repo_root_url
  change_management_repo_title            = var.repo_title
  change_management_repo_git_provider     = local.change_management_repo_git_provider
  change_management_repo_git_id           = (var.change_management_repo_git_id == "") ? var.repo_git_id : var.change_management_repo_git_id
  change_management_existing_url          = var.change_management_existing_url

  #DEPLOYMENT REPO
  deployment_repo_existing_git_provider = (var.use_app_repo_for_cd_deploy) ? try(module.devsecops_ci_toolchain[0].app_repo_git_provider, "") : local.deployment_repo_existing_git_provider
  deployment_repo_existing_git_id       = (var.use_app_repo_for_cd_deploy) ? try(module.devsecops_ci_toolchain[0].app_repo_git_id, "") : local.deployment_repo_existing_git_id
  deployment_repo_clone_to_git_provider = (var.cd_deployment_repo_clone_to_git_provider == "") ? var.repo_git_provider : var.cd_deployment_repo_clone_to_git_provider
  deployment_repo_clone_to_git_id       = (var.cd_deployment_repo_clone_to_git_id == "") ? var.repo_git_id : var.cd_deployment_repo_clone_to_git_id
  deployment_repo_clone_from_url        = var.cd_deployment_repo_clone_from_url
  deployment_repo_clone_from_branch     = var.cd_deployment_repo_clone_from_branch
  deployment_repo_existing_url          = (var.use_app_repo_for_cd_deploy) ? try(module.devsecops_ci_toolchain[0].app_repo_url, "") : var.cd_deployment_repo_existing_url
  deployment_repo_existing_branch       = (var.use_app_repo_for_cd_deploy) ? try(module.devsecops_ci_toolchain[0].app_repo_branch, "") : var.cd_deployment_repo_existing_branch
  deployment_repo_blind_connection      = (var.custom_app_repo_blind_connection == "") ? var.repo_blind_connection : var.custom_app_repo_blind_connection
  deployment_repo_root_url              = (var.custom_app_repo_root_url == "") ? var.repo_root_url : var.custom_app_repo_root_url
  deployment_repo_title                 = (var.custom_app_repo_title == "") ? var.repo_title : var.custom_app_repo_title

  #SCC
  scc_enable_scc       = (local.cd_scc_enable_scc == "true") ? true : false
  scc_integration_name = var.cd_scc_integration_name

  #CODE ENGINE
  code_engine_project        = local.cd_code_engine_project_name
  code_engine_region         = (var.cd_code_engine_region == "") ? var.toolchain_region : var.cd_code_engine_region
  code_engine_resource_group = (var.cd_code_engine_resource_group == "") ? var.toolchain_resource_group : var.cd_code_engine_resource_group

  #CLUSTER
  cluster_name      = (var.cd_cluster_name == "") ? var.cluster_name : var.cd_cluster_name
  cluster_namespace = var.cd_cluster_namespace
  cluster_region    = (var.cd_cluster_region == "") ? format("${var.environment_prefix}%s", var.toolchain_region) : format("${var.environment_prefix}%s", replace(replace(var.cd_cluster_region, "ibm:yp:", ""), "ibm:ys1:", ""))

  #OTHER INTEGRATIONS

  repositories_prefix           = (local.cd_repositories_prefix == "compliance" && var.prefix != "") ? format("%s-%s", var.prefix, local.cd_repositories_prefix) : local.cd_repositories_prefix
  authorization_policy_creation = (var.cd_authorization_policy_creation == "") ? var.authorization_policy_creation : var.cd_authorization_policy_creation
  link_to_doi_toolchain         = var.cd_link_to_doi_toolchain
  doi_toolchain_id              = try(module.devsecops_ci_toolchain[0].toolchain_id, var.cd_doi_toolchain_id)
  region                        = (var.cd_region == "") ? var.toolchain_region : var.cd_region
  scc_attachment_id             = var.scc_attachment_id
  scc_instance_crn              = var.scc_instance_crn
  scc_profile_name              = var.scc_profile_name
  scc_profile_version           = var.scc_profile_version
  scc_use_profile_attachment    = (var.cd_scc_use_profile_attachment == "") ? var.scc_use_profile_attachment : var.cd_scc_use_profile_attachment
  enable_pipeline_notifications = (local.cd_enable_pipeline_notifications == "true") ? true : false
  pipeline_properties           = var.cd_pipeline_properties
  pipeline_properties_filepath  = var.cd_pipeline_properties_filepath

  repository_properties          = var.cd_repository_properties
  repository_properties_filepath = var.cd_repository_properties_filepath

  code_signing_cert_secret_name = var.cd_code_signing_cert_secret_name

  # PRIVATE WORKER
  privateworker_credentials_secret_group = var.privateworker_credentials_secret_group
  privateworker_credentials_secret_name  = var.privateworker_credentials_secret_name
  privateworker_name                     = var.privateworker_name
  enable_privateworker                   = var.enable_privateworker

  #SLACK INTEGRATION
  enable_slack           = (local.cd_enable_slack == "true") ? true : false
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
  create_triggers                       = var.create_triggers
  create_git_triggers                   = var.create_git_triggers
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
}

module "devsecops_cc_toolchain" {
  count                         = var.create_cc_toolchain ? 1 : 0
  source                        = "git::https://github.com/terraform-ibm-modules/terraform-ibm-devsecops-cc-toolchain?ref=v2.3.0"
  ibmcloud_api_key              = var.ibmcloud_api_key
  toolchain_name                = (var.prefix == "") ? local.cc_toolchain_name : format("${var.prefix}-%s", local.cc_toolchain_name)
  toolchain_description         = var.cc_toolchain_description
  toolchain_region              = (var.cc_toolchain_region == "") ? var.toolchain_region : replace(replace(var.cc_toolchain_region, "ibm:yp:", ""), "ibm:ys1:", "")
  toolchain_resource_group      = (var.cc_toolchain_resource_group == "") ? var.toolchain_resource_group : var.cc_toolchain_resource_group
  authorization_policy_creation = (var.cc_authorization_policy_creation == "") ? var.authorization_policy_creation : var.cc_authorization_policy_creation
  pipeline_branch               = (var.cc_compliance_pipeline_branch == "") ? var.compliance_pipeline_branch : var.cc_compliance_pipeline_branch
  pipeline_git_tag              = (var.cc_pipeline_git_tag == "") ? var.pipeline_git_tag : var.cc_pipeline_git_tag
  worker_id                     = var.worker_id

  #SECRET PROVIDERS
  enable_key_protect       = (local.cc_enable_key_protect == "true") ? true : false
  enable_secrets_manager   = (local.cc_enable_secrets_manager == "true") ? true : false
  sm_name                  = (var.cc_sm_name == "") ? var.sm_name : var.cc_sm_name
  sm_location              = (var.cc_sm_location == "") ? replace(replace(var.sm_location, "ibm:yp:", ""), "ibm:ys1:", "") : replace(replace(var.cc_sm_location, "ibm:yp:", ""), "ibm:ys1:", "")
  sm_resource_group        = (var.cc_sm_resource_group != "") ? var.cc_sm_resource_group : (var.sm_resource_group != "") ? var.sm_resource_group : var.toolchain_resource_group
  sm_secret_group          = (var.cc_sm_secret_group == "") ? var.sm_secret_group : var.cc_sm_secret_group
  kp_name                  = (var.cc_kp_name == "") ? var.kp_name : var.cc_kp_name
  kp_location              = (var.cc_sm_location == "") ? replace(replace(var.kp_location, "ibm:yp:", ""), "ibm:ys1:", "") : replace(replace(var.cc_kp_location, "ibm:yp:", ""), "ibm:ys1:", "")
  kp_resource_group        = (var.cc_kp_resource_group != "") ? var.cc_kp_resource_group : (var.kp_resource_group != "") ? var.kp_resource_group : var.toolchain_resource_group
  sm_instance_crn          = (var.cc_sm_instance_crn != "") ? var.cc_sm_instance_crn : var.sm_instance_crn
  add_pipeline_definitions = var.add_pipeline_definitions

  #SECRET NAMES AND SECRET GROUPS
  pipeline_ibmcloud_api_key_secret_name  = (var.cc_pipeline_ibmcloud_api_key_secret_name == "") ? var.pipeline_ibmcloud_api_key_secret_name : var.cc_pipeline_ibmcloud_api_key_secret_name
  pipeline_ibmcloud_api_key_secret_group = (var.cc_pipeline_ibmcloud_api_key_secret_group == "") ? var.pipeline_ibmcloud_api_key_secret_group : var.cc_pipeline_ibmcloud_api_key_secret_group

  cos_api_key_secret_name  = (var.cc_cos_api_key_secret_name == "") ? var.cos_api_key_secret_name : var.cc_cos_api_key_secret_name
  cos_api_key_secret_group = (var.cc_cos_api_key_secret_group == "") ? var.cos_api_key_secret_group : var.cc_cos_api_key_secret_group

  issues_repo_git_token_secret_name = (local.cc_issues_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : local.cc_issues_repo_git_token_secret_name
  issues_repo_secret_group          = (local.cc_issues_repo_secret_group == "") ? var.repo_secret_group : local.cc_issues_repo_secret_group

  evidence_repo_git_token_secret_name = (local.cc_evidence_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : local.cc_evidence_repo_git_token_secret_name
  evidence_repo_secret_group          = (local.cc_evidence_repo_secret_group == "") ? var.repo_secret_group : local.cc_evidence_repo_secret_group

  inventory_repo_git_token_secret_name = (local.cc_inventory_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : local.cc_inventory_repo_git_token_secret_name
  inventory_repo_secret_group          = (local.cc_inventory_repo_secret_group == "") ? var.repo_secret_group : local.cc_inventory_repo_secret_group

  compliance_pipeline_repo_git_token_secret_name = (local.cc_compliance_pipeline_repo_git_token_secret_name == "") ? var.repo_git_token_secret_name : local.cc_compliance_pipeline_repo_git_token_secret_name
  compliance_pipeline_repo_secret_group          = (local.cc_compliance_pipeline_repo_secret_group == "") ? var.repo_secret_group : local.cc_compliance_pipeline_repo_secret_group

  pipeline_config_repo_git_token_secret_name = (
    (local.cc_pipeline_config_repo_git_token_secret_name != "") ? local.cc_pipeline_config_repo_git_token_secret_name :
    (var.custom_app_repo_git_token_secret_name != "") ? var.custom_app_repo_git_token_secret_name : var.repo_git_token_secret_name
  )

  pipeline_config_repo_secret_group = (local.cc_pipeline_config_repo_secret_group == "") ? var.repo_secret_group : local.cc_pipeline_config_repo_secret_group

  app_repo_git_token_secret_name = (
    (local.cc_app_repo_git_token_secret_name != "") ? local.cc_app_repo_git_token_secret_name :
    (var.custom_app_repo_git_token_secret_name != "") ? var.custom_app_repo_git_token_secret_name : var.repo_git_token_secret_name
  )
  app_repo_secret_group = (local.cc_app_repo_secret_group == "") ? var.repo_secret_group : local.cc_app_repo_secret_group

  slack_webhook_secret_name  = (var.cc_slack_webhook_secret_name == "") ? var.slack_webhook_secret_name : var.cc_slack_webhook_secret_name
  slack_webhook_secret_group = (var.cc_slack_webhook_secret_group == "") ? var.slack_webhook_secret_group : var.cc_slack_webhook_secret_group

  scc_scc_api_key_secret_name  = var.scc_scc_api_key_secret_name
  scc_scc_api_key_secret_group = var.scc_scc_api_key_secret_group

  pipeline_doi_api_key_secret_name  = (var.cc_pipeline_doi_api_key_secret_name == "") ? var.pipeline_doi_api_key_secret_name : var.cc_pipeline_doi_api_key_secret_name
  pipeline_doi_api_key_secret_group = (var.cc_pipeline_doi_api_key_secret_group == "") ? var.pipeline_doi_api_key_secret_group : var.cc_pipeline_doi_api_key_secret_group

  # CRN SECRETS
  app_repo_git_token_secret_crn = (
    (local.cc_app_repo_git_token_secret_crn != "") ? local.cc_app_repo_git_token_secret_crn :
    (var.custom_app_repo_git_token_secret_crn != "") ? var.custom_app_repo_git_token_secret_crn : var.repo_git_token_secret_crn
  )
  issues_repo_git_token_secret_crn              = (local.cc_issues_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : local.cc_issues_repo_git_token_secret_crn
  evidence_repo_git_token_secret_crn            = (local.cc_evidence_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : local.cc_evidence_repo_git_token_secret_crn
  inventory_repo_git_token_secret_crn           = (local.cc_inventory_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : local.cc_inventory_repo_git_token_secret_crn
  compliance_pipeline_repo_git_token_secret_crn = (local.cc_compliance_pipeline_repo_git_token_secret_crn == "") ? var.repo_git_token_secret_crn : local.cc_compliance_pipeline_repo_git_token_secret_crn
  pipeline_config_repo_git_token_secret_crn = (
    (local.cc_pipeline_config_repo_git_token_secret_crn != "") ? local.cc_pipeline_config_repo_git_token_secret_crn :
    (var.custom_app_repo_git_token_secret_crn != "") ? var.custom_app_repo_git_token_secret_crn : var.repo_git_token_secret_crn
  )
  cos_api_key_secret_crn               = (var.cc_cos_api_key_secret_crn == "") ? var.cos_api_key_secret_crn : var.cc_cos_api_key_secret_crn
  pipeline_ibmcloud_api_key_secret_crn = (var.cc_pipeline_ibmcloud_api_key_secret_crn == "") ? var.pipeline_ibmcloud_api_key_secret_crn : var.cc_pipeline_ibmcloud_api_key_secret_crn
  slack_webhook_secret_crn             = (var.cc_slack_webhook_secret_crn == "") ? var.slack_webhook_secret_crn : var.cc_slack_webhook_secret_crn
  artifactory_token_secret_crn         = var.cc_artifactory_token_secret_crn
  scc_scc_api_key_secret_crn           = var.scc_scc_api_key_secret_crn
  sonarqube_secret_crn                 = (var.cc_sonarqube_secret_crn == "") ? var.sonarqube_secret_crn : var.cc_sonarqube_secret_crn
  pipeline_doi_api_key_secret_crn      = (var.cc_pipeline_doi_api_key_secret_crn == "") ? var.pipeline_doi_api_key_secret_crn : var.cc_pipeline_doi_api_key_secret_crn

  #AUTH TYPE FOR REPOS
  pipeline_config_repo_auth_type = (
    (local.cc_pipeline_config_repo_auth_type != "") ? local.cc_pipeline_config_repo_auth_type :
    (local.custom_app_repo_auth_type != "") ? local.custom_app_repo_auth_type : local.repo_auth_type
  )
  inventory_repo_auth_type = (local.cc_inventory_repo_auth_type == "") ? local.repo_auth_type : local.cc_inventory_repo_auth_type
  issues_repo_auth_type    = (local.cc_issues_repo_auth_type == "") ? local.repo_auth_type : local.cc_issues_repo_auth_type
  evidence_repo_auth_type  = (local.cc_evidence_repo_auth_type == "") ? local.repo_auth_type : local.cc_evidence_repo_auth_type
  app_repo_auth_type = (
    (local.cc_app_repo_auth_type != "") ? local.cc_app_repo_auth_type :
    (local.custom_app_repo_auth_type != "") ? local.custom_app_repo_auth_type : local.repo_auth_type
  )
  compliance_pipeline_repo_auth_type = (var.compliance_pipeline_repo_use_group_settings) ? local.repo_auth_type : local.cc_compliance_pipeline_repo_auth_type

  #GROUPS/USERS FOR REPOS
  issues_group    = (local.cc_issues_group == "") ? var.repo_group : local.cc_issues_group
  inventory_group = (local.cc_inventory_group == "") ? var.repo_group : local.cc_inventory_group
  evidence_group  = (local.cc_evidence_group == "") ? var.repo_group : local.cc_evidence_group
  pipeline_config_group = (
    (local.cc_pipeline_config_group != "") ? local.cc_pipeline_config_group :
    (var.custom_app_repo_group != "") ? var.custom_app_repo_group : var.repo_group
  )
  compliance_pipeline_group = (var.compliance_pipeline_repo_use_group_settings) ? var.repo_group : local.cc_compliance_pipeline_group
  app_group = (
    (local.cc_app_group != "") ? local.cc_app_group :
    (var.custom_app_repo_group != "") ? var.custom_app_repo_group : var.repo_group
  )

  link_to_doi_toolchain = var.cc_link_to_doi_toolchain

  #COMPLIANCE PIPELINE REPO
  compliance_pipelines_repo_blind_connection = (var.compliance_pipeline_repo_use_group_settings) ? var.repo_blind_connection : var.compliance_pipeline_repo_blind_connection
  compliance_pipelines_repo_root_url         = (var.compliance_pipeline_repo_use_group_settings) ? var.repo_root_url : var.compliance_pipeline_repo_root_url
  compliance_pipelines_repo_title            = (var.compliance_pipeline_repo_use_group_settings) ? var.repo_title : var.compliance_pipeline_repo_title
  compliance_pipeline_repo_git_provider      = local.compliance_pipeline_repo_existing_git_provider
  compliance_pipelines_repo_git_id           = (var.compliance_pipeline_repo_use_group_settings) ? var.repo_git_id : var.compliance_pipeline_repo_git_id
  compliance_pipeline_existing_repo_url      = var.compliance_pipeline_existing_repo_url
  compliance_pipeline_source_repo_url        = var.compliance_pipeline_source_repo_url
  compliance_pipelines_repo_name             = var.compliance_pipeline_repo_name

  #PIPELINE CONFIG REPO
  pipeline_config_repo_existing_url   = local.cc_pipeline_config_repo_existing_url
  pipeline_config_repo_clone_from_url = local.cc_pipeline_config_repo_clone_from_url
  pipeline_config_repo_git_provider   = local.pipeline_config_repo_git_provider
  pipeline_config_repo_git_id = (
    (var.pipeline_config_repo_git_id != "") ? var.pipeline_config_repo_git_id :
    (var.custom_app_repo_git_id != "") ? var.custom_app_repo_git_id : var.repo_git_id
  )
  pipeline_config_repo_branch           = (local.cc_pipeline_config_repo_branch == "") ? local.cc_app_repo_branch : local.cc_pipeline_config_repo_branch
  pipeline_config_repo_blind_connection = (var.custom_app_repo_blind_connection == "") ? var.repo_blind_connection : var.custom_app_repo_blind_connection
  pipeline_config_repo_root_url         = (var.custom_app_repo_root_url == "") ? var.repo_root_url : var.custom_app_repo_root_url
  pipeline_config_repo_title            = (var.custom_app_repo_title == "") ? var.repo_title : var.custom_app_repo_title

  #APP REPO
  app_repo_url              = try(module.devsecops_ci_toolchain[0].app_repo_url, local.cc_app_repo_existing_url)
  app_repo_git_provider     = try(module.devsecops_ci_toolchain[0].app_repo_git_provider, local.cc_app_repo_existing_git_provider)
  app_repo_branch           = try(module.devsecops_ci_toolchain[0].app_repo_branch, local.cc_app_repo_branch)
  app_repo_git_id           = try(module.devsecops_ci_toolchain[0].app_repo_git_id, local.cc_app_repo_existing_git_id)
  app_repo_title            = (var.custom_app_repo_title == "") ? var.repo_title : var.custom_app_repo_title
  app_repo_blind_connection = (var.custom_app_repo_blind_connection == "") ? var.repo_blind_connection : var.custom_app_repo_blind_connection
  app_repo_root_url         = (var.custom_app_repo_root_url == "") ? var.repo_root_url : var.custom_app_repo_root_url

  #EVIDENCE REPO
  evidence_repo_name              = var.evidence_repo_name
  evidence_repo_url               = try(module.devsecops_ci_toolchain[0].evidence_repo_url, var.evidence_repo_existing_url)
  evidence_repo_git_provider      = local.evidence_repo_existing_git_provider
  evidence_repo_git_id            = (var.evidence_repo_existing_git_id == "") ? var.repo_git_id : var.evidence_repo_existing_git_id
  evidence_repo_integration_owner = var.evidence_repo_integration_owner
  evidence_repo_blind_connection  = var.repo_blind_connection
  evidence_repo_root_url          = var.repo_root_url
  evidence_repo_title             = var.repo_title

  #ISSUES REPO
  issues_repo_name              = var.issues_repo_name
  issues_repo_url               = try(module.devsecops_ci_toolchain[0].issues_repo_url, var.issues_repo_existing_url)
  issues_repo_git_provider      = local.issues_repo_existing_git_provider
  issues_repo_git_id            = (var.issues_repo_existing_git_id == "") ? var.repo_git_id : var.issues_repo_existing_git_id
  issues_repo_integration_owner = var.issues_repo_integration_owner
  issues_repo_blind_connection  = var.repo_blind_connection
  issues_repo_root_url          = var.repo_root_url
  issues_repo_title             = var.repo_title

  #INVENTORY REPO
  inventory_repo_name              = var.inventory_repo_name
  inventory_repo_url               = try(module.devsecops_ci_toolchain[0].inventory_repo_url, var.inventory_repo_existing_url)
  inventory_repo_git_provider      = local.inventory_repo_existing_git_provider
  inventory_repo_git_id            = (var.inventory_repo_existing_git_id == "") ? var.repo_git_id : var.inventory_repo_existing_git_id
  inventory_repo_integration_owner = var.inventory_repo_integration_owner
  inventory_repo_blind_connection  = var.repo_blind_connection
  inventory_repo_root_url          = var.repo_root_url
  inventory_repo_title             = var.repo_title

  #SCC
  scc_enable_scc       = (local.cc_scc_enable_scc == "true") ? true : false
  scc_integration_name = var.cc_scc_integration_name

  #OTHER INTEGRATIONS
  repositories_prefix            = (local.cc_repositories_prefix == "compliance" && var.prefix != "") ? format("%s-%s", var.prefix, local.cc_repositories_prefix) : local.cc_repositories_prefix
  doi_toolchain_id               = try(module.devsecops_ci_toolchain[0].toolchain_id, var.cc_doi_toolchain_id)
  environment_tag                = (var.environment_tag == "") ? format("%s_prod_latest", var.toolchain_region) : format("%s_%s", var.toolchain_region, var.environment_tag)
  scc_attachment_id              = var.scc_attachment_id
  scc_instance_crn               = var.scc_instance_crn
  scc_profile_name               = var.scc_profile_name
  scc_profile_version            = var.scc_profile_version
  scc_use_profile_attachment     = (var.cc_scc_use_profile_attachment == "") ? var.scc_use_profile_attachment : var.cc_scc_use_profile_attachment
  enable_pipeline_notifications  = (local.cc_enable_pipeline_notifications == "true") ? true : false
  pipeline_properties            = var.cc_pipeline_properties
  pipeline_properties_filepath   = var.cc_pipeline_properties_filepath
  repository_properties          = var.cc_repository_properties
  repository_properties_filepath = var.cc_repository_properties_filepath


  #SLACK INTEGRATION
  enable_slack           = (local.cc_enable_slack == "true") ? true : false
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

  # PRIVATE WORKER
  privateworker_credentials_secret_crn   = var.privateworker_credentials_secret_crn
  privateworker_credentials_secret_group = var.privateworker_credentials_secret_group
  privateworker_credentials_secret_name  = var.privateworker_credentials_secret_name
  privateworker_name                     = var.privateworker_name
  enable_privateworker                   = var.enable_privateworker


  #SONARQUBE
  sonarqube_integration_name    = (var.cc_sonarqube_integration_name == "") ? var.sonarqube_integration_name : var.cc_sonarqube_integration_name
  sonarqube_user                = (var.cc_sonarqube_user == "") ? var.sonarqube_user : var.cc_sonarqube_user
  sonarqube_secret_name         = (var.cc_sonarqube_secret_name == "") ? var.sonarqube_secret_name : var.cc_sonarqube_secret_name
  sonarqube_secret_group        = (var.cc_sonarqube_secret_group == "") ? var.sonarqube_secret_group : var.cc_sonarqube_secret_group
  sonarqube_is_blind_connection = (var.cc_sonarqube_is_blind_connection == "") ? var.sonarqube_is_blind_connection : var.cc_sonarqube_is_blind_connection
  sonarqube_server_url          = (var.cc_sonarqube_server_url == "") ? var.sonarqube_server_url : var.cc_sonarqube_server_url

  #TRIGGER PROPERTIES
  create_triggers              = var.create_triggers
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

############### Auto Start Webhook ######################

# Random string for webhook token
resource "random_string" "webhook_secret" {
  count      = (var.autostart) ? 1 : 0
  depends_on = [module.devsecops_ci_toolchain[0].ci_pipeline_id, module.devsecops_ci_toolchain[0].app_repo_url, module.prereqs]
  length     = 48
  special    = false
  upper      = false
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
    value    = random_string.webhook_secret[0].result
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
    ibm_cd_tekton_pipeline_trigger_property.ci_pipeline_webhook_branch_property,
    ibm_cd_tekton_pipeline_trigger_property.ci_pipeline_webhook_repo_url_property
  ]
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command     = "${path.root}/../../scripts/ci_start.sh \"${ibm_cd_tekton_pipeline_trigger.ci_pipeline_webhook[0].webhook_url}\" \"${random_string.webhook_secret[0].result}\""
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
