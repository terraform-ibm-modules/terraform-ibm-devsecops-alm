##############################################################################
# Input Variables
##############################################################################

##############################################################################
##### START OF COMMON VARIABLES ##########

variable "ibmcloud_api" {
  type        = string
  description = "IBM Cloud API Endpoint."
  default     = "https://cloud.ibm.com"
}

variable "toolchain_region" {
  type        = string
  description = "The region identifier that will be used, by default, for all resource creation and service instance lookup. This can be overridden on a per resource/service basis. See `ci_toolchain_region`,`cd_toolchain_region`,`cc_toolchain_region`, `ci_cluster_region`, `cd_cluster_region`, `ci_registry_region`."
  default     = "us-south"
}

variable "cos_api_key_secret_name" {
  type        = string
  description = "To enable the use of COS, a secret name to a COS API key secret in the secret provider is required. In addition `cos_endpoint` and `cos_bucket_name` must be set. This setting sets the same API key for the COS settings in the CI, CD, and CC toolchains. See `ci_cos_api_key_secret_name`, `cd_cos_api_key_secret_name`, and `cc_cos_api_key_secret_name` to set separately."
  default     = "cos-api-key"
}

variable "inventory_repo_url" {
  type        = string
  description = "This is a template repository to clone compliance-inventory for reference DevSecOps toolchain templates."
  default     = ""
}

variable "evidence_repo_url" {
  type        = string
  description = "This is a template repository to clone compliance-evidence-locker for reference DevSecOps toolchain templates."
  default     = ""
}

variable "issues_repo_url" {
  type        = string
  description = "This is a template repository to clone compliance-issues for reference DevSecOps toolchain templates."
  default     = ""
}

# tflint-ignore: terraform_unused_declarations
variable "deployment_repo_url" {
  type        = string
  description = "This is the repository to clone deployment for DevSecOps toolchain template."
  default     = ""
}

variable "ibmcloud_api_key" {
  type        = string
  description = "API key used to create the toolchains. (See deployment guide.)"
  sensitive   = true
}

#SECRET PROVIDERS
variable "sm_location" {
  type        = string
  description = "The region location of the Secrets Manager instance. This applies to the CI, CD and CC Secret Manager integrations. See `ci_sm_location`, `cd_sm_location`, and `cc_sm_location` to set separately."
  default     = "us-south"
}

variable "sm_name" {
  type        = string
  description = "The name of the Secret Managers instance. This applies to the CI, CD and CC Secret Manager integrations. See `ci_sm_name`, `cd_sm_name`, and `cc_sm_name` to set separately. "
  default     = "sm-instance"
}

variable "sm_resource_group" {
  type        = string
  description = "The resource group containing the Secrets Manager instance. This applies to the CI, CD and CC Secret Manager integrations. See `ci_sm_resource_group`, `cd_sm_resource_group`, and `cc_sm_resource_group` to set separately."
  default     = "Default"
}

variable "sm_secret_group" {
  type        = string
  description = "Group in Secrets Manager for organizing/grouping secrets. This applies to the CI, CD and CC Secret Manager integrations. See `ci_sm_secret_group`, `cd_sm_secret_group`, and `cc_sm_secret_group` to set separately."
  default     = "Default"
}

variable "kp_resource_group" {
  type        = string
  description = "The resource group containing the Key Protect instance. This applies to the CI, CD and CC Key Protect integrations. See `ci_kp_resource_group`, `cd_kp_resource_group`, and `cc_kp_resource_group` to set separately."
  default     = "Default"
}

variable "kp_name" {
  type        = string
  description = "Name of the Key Protect instance where the secrets are stored. This applies to the CI, CD and CC Key Protect integrations. See `ci_kp_name`, `cd_kp_name`, and `cc_kp_name` to set separately."
  default     = "kp-compliance-secrets"
}

variable "kp_location" {
  type        = string
  description = "The region location of the Key Protect instance. This applies to the CI, CD and CC Key Protect integrations. See `ci_kp_location`, `cd_kp_location`, and `cc_kp_location` to set separately."
  default     = "us-south"
}

variable "enable_key_protect" {
  type        = bool
  description = "Set to enable Key Protect Integrations. "
  default     = false
}

variable "enable_secrets_manager" {
  description = "Enable the Secrets Manager integrations."
  type        = bool
  default     = true
}

variable "toolchain_resource_group" {
  type        = string
  description = "The resource group that will be used, by default, for all resource creation and service instance lookups. This can be overridden on a per resource/service basis. See `ci_toolchain_resource_group`,`cd_toolchain_resource_group`,`cc_toolchain_resource_group`, `ci_cluster_resource_group`."
  default     = "Default"
}

variable "cos_endpoint" {
  type        = string
  description = "Set the Cloud Object Storage endpoint for accessing your COS bucket. This setting sets the same endpoint for COS in the CI, CD, and CC toolchains. See `ci_cos_endpoint`, `cd_cos_endpoint`, and `cc_cos_endpoint` to set the endpoints separately."
  default     = ""
}

variable "cos_bucket_name" {
  type        = string
  description = "Set the name of your COS bucket. This applies the same COS bucket name for the CI, CD, and CC toolchains. See `ci_cos_bucket_name`, `cd_cos_bucket_name`, and `cc_cos_bucket_name` to set separately."
  default     = ""
}

variable "enable_slack" {
  type        = bool
  description = "Set to `true` to create the integration. This requires a valid `slack_channel_name`, `slack_team_name`, and a valid `webhook` (see `slack_webhook_secret_name`). This setting applies for CI, CD, and CC toolchains. To enable Slack separately, see `ci_enable_slack`, `cd_enable_slack`, and `cc_enable_slack`."
  default     = false
}

variable "slack_channel_name" {
  type        = string
  description = "The Slack channel that notifications are posted to. This applies to the CI, CD, and CC toolchains. To set separately see `ci_slack_channel_name`, `cd_slack_channel_name`, and `cc_slack_channel_name`"
  default     = ""
}

variable "slack_team_name" {
  type        = string
  description = "The Slack team name, which is the word or phrase before `.slack.com` in the team URL. This applies to the CI, CD, and CC toolchains. To set separately, see `ci_slack_team_name`, `cd_slack_team_name`, and `cc_slack_team_name`."
  default     = ""
}

variable "slack_webhook_secret_name" {
  type        = string
  description = "Name of the webhook secret for Slack in the secret provider. This applies to the CI, CD, and CC toolchains. To set separately, see `ci_slack_webhook_secret_name`, `cd_slack_webhook_secret_name`, and `cc_slack_webhook_secret_name`"
  default     = "slack-webhook"
}

variable "authorization_policy_creation" {
  type        = string
  description = "Disable Toolchain Service to Secrets Manager Service authorization policy creation. To disable set the value to `disabled`. This applies to the CI, CD, and CC toolchains. To set separately, see `ci_authorization_policy_creation`, `cd_authorization_policy_creation`, and `cc_authorization_policy_creation`."
  default     = ""
}

variable "slack_notifications" {
  type        = string
  description = "This is enabled automatically when a Slack integration is created. The switch overrides the Slack notifications. Set `1` for on and `0` for off. This applies to the CI, CD, and CC toolchains. To set separately, see `ci_slack_notifications`, `cd_slack_notifications`, and `cc_slack_notifications`."
  default     = ""
}

variable "repo_group" {
  type        = string
  description = "Specify Git user or group for your application. This must be set if the repository authentication type is `pat` (personal access token)."
  default     = ""
}

variable "repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider. Specifying a secret name for the Git Token automatically sets the authentication type to `pat`."
  default     = ""
}

variable "toolchain_name" {
  type        = string
  description = "Common element of the toolchain name. The toolchain names will be appended with `CI Toolchain` or `CD Toolchain` or `CC Toolchain` followed by a timestamp. Can explicitly be set using `ci_toolchain_name`, `cd_toolchain_name`, and `cc_toolchain_name`."
  default     = "DevSecOps"
}

variable "environment_prefix" {
  type        = string
  description = "By default `ibm:yp:`. This will be set as the prefix to regions automatically where required. For example `ibm:yp:us-south`."
  default     = "ibm:yp:"
}

variable "compliance_base_image" {
  type        = string
  description = "Pipeline baseimage to run most of the built-in pipeline code."
  default     = ""
}

variable "cluster_name" {
  type        = string
  description = "Name of the Kubernetes cluster where the application is deployed. This sets the same cluster for both CI and CD toolchains. See `ci_cluster_name` and `cd_cluster_name` to set different clusters. By default , the cluster namespace for CI will be set to `dev` and CD to `prod`. These can be changed using `ci_cluster_namespace` and `cd_cluster_namespace`."
  default     = "mycluster-free"
}

variable "repositories_prefix" {
  type        = string
  description = "Prefix name for the cloned compliance repos."
  default     = "compliance"
}

variable "peer_review_compliance" {
  type        = string
  description = "Set to `0` to disable. Set to `1` to enable peer review evidence collection. This parameter will apply to the CI, CD and CC pipelines. Can be set individually with `ci_peer_review_compliance`, `cd_peer_review_compliance`, `cc_peer_review_compliance`."
  default     = ""
}

##### END OF COMMON VARIABLES ############
##### START OF CI VARIABLES ##############

variable "ci_toolchain_resource_group" {
  type        = string
  description = "The resource group within which the toolchain is created."
  default     = ""
}

variable "ci_toolchain_name" {
  type        = string
  description = "The name of the CI Toolchain."
  default     = ""
}

variable "ci_toolchain_region" {
  type        = string
  description = "The region containing the CI toolchain. Use the short form of the regions. For example `us-south`."
  default     = ""
}

variable "ci_toolchain_description" {
  type        = string
  description = "Description for the CI Toolchain."
  default     = "Toolchain created with terraform template for DevSecOps CI Best Practices."
}

variable "ci_app_name" {
  type        = string
  description = "Name of the application image and inventory entry."
  default     = "hello-compliance-app"
}

variable "ci_cluster_name" {
  type        = string
  description = "Name of the Kubernetes cluster where the application is deployed. (can be the same cluster used for prod)"
  default     = ""
}

variable "ci_cluster_namespace" {
  type        = string
  description = "Name of the Kubernetes cluster namespace where the application is deployed."
  default     = "dev"
}

variable "ci_dev_region" {
  type        = string
  description = "(Deprecated. Use `ci_cluster_region`) Region of the Kubernetes cluster where the application is deployed. Use the short form of the regions. For example `us-south`"
  default     = ""
}

variable "ci_cluster_region" {
  type        = string
  description = "Region of the Kubernetes cluster where the application is deployed. Use the short form of the regions. For example `us-south`."
  default     = ""
}

variable "ci_dev_resource_group" {
  type        = string
  description = "(Deprecated. Use `ci_cluster_resource_group`) The cluster resource group."
  default     = ""
}

variable "ci_cluster_resource_group" {
  type        = string
  description = "The cluster resource group."
  default     = ""
}

variable "registry_namespace" {
  type        = string
  description = "A unique namespace within the IBM Cloud Container Registry region where the application image is stored."
  default     = ""
}

variable "ci_registry_namespace" {
  type        = string
  description = "A unique namespace within the IBM Cloud Container Registry region where the application image is stored. (deprecated. Use `registry_namespace`)"
  default     = ""
}

variable "ci_registry_region" {
  type        = string
  description = "The IBM Cloud Region where the IBM Cloud Container Registry namespace is to be created. Use the short form of the regions. For example `us-south`."
  default     = ""
}

variable "ci_compliance_base_image" {
  type        = string
  description = "Pipeline baseimage to run most of the built-in pipeline code."
  default     = ""
}

variable "ci_authorization_policy_creation" {
  type        = string
  description = "Disable Toolchain Service to Secrets Manager Service authorization policy creation."
  default     = ""
}

variable "ci_repositories_prefix" {
  type        = string
  description = "Prefix name for the cloned compliance repos."
  default     = ""
}

variable "create_ci_toolchain" {
  description = "Flag which determines if the DevSecOps CI toolchain is created. If this toolchain is not created then values must be set for the following variables, evidence_repo_url, issues_repo_url and inventory_repo_url."
  type        = bool
  default     = true
}

variable "ci_link_to_doi_toolchain" {
  description = "Enable a link to a DevOps Insights instance in another toolchain."
  type        = bool
  default     = false
}

variable "ci_doi_toolchain_id" {
  type        = string
  description = "DevOps Insights toolchain ID to link to."
  default     = ""
}

variable "ci_pipeline_debug" {
  type        = string
  description = "'0' by default. Set to '1' to enable debug logging."
  default     = "0"
}

variable "ci_opt_in_dynamic_api_scan" {
  type        = string
  description = "To enable the OWASP Zap API scan. '1' enable or '0' disable."
  default     = "1"
}

variable "ci_opt_in_dynamic_ui_scan" {
  type        = string
  description = "To enable the OWASP Zap UI scan. '1' enable or '0' disable."
  default     = "1"
}

variable "ci_opt_in_dynamic_scan" {
  type        = string
  description = "To enable the OWASP Zap scan. '1' enable or '0' disable."
  default     = "1"
}

variable "ci_opt_out_v1_evidence" {
  type        = string
  description = "Opt out of Evidence v1"
  default     = "1"
}

variable "ci_peer_review_compliance" {
  type        = string
  description = "Set to `0` to disable. Set to `1` to enable peer review evidence collection."
  default     = ""
}

######## Deployment Strategy ##################

variable "ci_deployment_target" {
  type        = string
  description = "The deployment target, cluster or code-engine."
  default     = "cluster"
}

######## Code Engine Vars #####################

variable "ci_code_engine_project" {
  type        = string
  description = "The name of the Code Engine project to use (or create)."
  default     = "DevSecOps_CE"
}

variable "ci_code_engine_region" {
  type        = string
  description = "The region to create/lookup for the Code Engine project."
  default     = "ibm:yp:us-south"
}

variable "ci_code_engine_resource_group" {
  type        = string
  description = "The resource group of the Code Engine project."
  default     = "Default"
}

variable "ci_code_engine_entity_type" {
  type        = string
  description = "Type of Code Engine entity to create/update as part of deployment. Default type is 'application'. Set as 'job' for 'job' type."
  default     = ""
}

variable "ci_code_engine_build_strategy" {
  type        = string
  description = "The build strategy for the Code Engine entity. Default strategy is 'dockerfile'. Set as 'buildpacks' for 'buildpacks' build."
  default     = ""
}

variable "ci_code_engine_source" {
  type        = string
  description = "The path to the location of code to build in the repository."
  default     = ""
}

######### END Code Engine ######################

######## APP REPO #############################

variable "ci_app_repo_clone_from_url" {
  type        = string
  description = "Override the default sample app by providing your own sample app URL, which is cloned into the app repo. Note, using clone_if_not_exists mode, so if the app repo already exists the repo contents are unchanged."
  default     = ""
}

variable "ci_app_repo_clone_from_branch" {
  type        = string
  description = "Used when app_repo_clone_from_url is provided, the default branch that is used by the CI build, usually either main or master."
  default     = ""
}

variable "ci_app_repo_existing_url" {
  type        = string
  description = "Override to bring your own existing application repository URL, which is used directly instead of cloning the default sample."
  default     = ""
}

variable "ci_app_repo_existing_branch" {
  type        = string
  description = "Used when app_repo_existing_url is provided, the default branch that is used by the CI build, usually either main or master."
  default     = ""
}

variable "ci_app_repo_existing_git_provider" {
  type        = string
  description = "By default 'hostedgit', else use 'githubconsolidated' or 'gitlab'."
  default     = ""
}

variable "ci_app_repo_existing_git_id" {
  type        = string
  description = "By default absent, otherwise use custom server GUID, or other options for `git_id` field in the browser UI."
  default     = ""
}

variable "ci_app_repo_clone_to_git_provider" {
  type        = string
  description = "By default 'hostedgit', else use 'githubconsolidated' or 'gitlab'."
  default     = ""
}

variable "ci_app_repo_clone_to_git_id" {
  type        = string
  description = "By default absent, otherwise use custom server GUID, or other options for `git_id` field in the browser UI."
  default     = ""
}

######## SECRET PROVIDERS #############################

variable "ci_enable_key_protect" {
  type        = bool
  description = "Set to enable Key Protect Integration. "
  default     = false
}

variable "ci_enable_secrets_manager" {
  type        = bool
  description = "Set to enable Secrets Manager Integration."
  default     = false
}

variable "ci_sm_secret_group" {
  type        = string
  description = "Group in Secrets Manager for organizing/grouping secrets."
  default     = ""
}

variable "ci_sm_resource_group" {
  type        = string
  description = "The resource group containing the Secrets Manager instance."
  default     = ""
}

variable "ci_sm_name" {
  type        = string
  description = "Name of the Secrets Manager instance where the secrets are stored."
  default     = ""
}

variable "ci_sm_location" {
  type        = string
  description = "IBM Cloud location/region containing the Secrets Manager instance."
  default     = ""
}

variable "ci_kp_resource_group" {
  type        = string
  description = "The resource group containing the Key Protect instance."
  default     = ""
}

variable "ci_kp_name" {
  type        = string
  description = "Name of the Key Protect instance where the secrets are stored."
  default     = ""
}

variable "ci_kp_location" {
  type        = string
  description = "IBM Cloud location/region containing the Key Protect instance."
  default     = ""
}

######## PIPELINE CONFIG REPO ####################

variable "ci_pipeline_config_repo_existing_url" {
  type        = string
  description = "Specify a repository containing a custom pipeline-config.yaml file."
  default     = ""
}

variable "ci_pipeline_config_repo_clone_from_url" {
  type        = string
  description = "Specify a repository containing a custom pipeline-config.yaml file."
  default     = ""
}

variable "ci_pipeline_config_repo_branch" {
  type        = string
  description = "Specify the branch containing the custom pipeline-config.yaml file."
  default     = ""
}

variable "ci_pipeline_config_path" {
  type        = string
  description = "The name and path of the pipeline-config.yaml file within the pipeline-config repo."
  default     = ".pipeline-config.yaml"
}

######## Repo Groups #############################

variable "ci_app_group" {
  type        = string
  description = "Specify Git user or group for your application."
  default     = ""
}

variable "ci_issues_group" {
  type        = string
  description = "Specify Git user or group for issues repository."
  default     = ""
}

variable "ci_inventory_group" {
  type        = string
  description = "Specify Git user or group for inventory repository."
  default     = ""
}

variable "ci_evidence_group" {
  type        = string
  description = "Specify Git user or group for evidence repository."
  default     = ""
}

variable "ci_pipeline_config_group" {
  type        = string
  description = "Specify user or group for pipeline config repo."
  default     = ""
}

variable "ci_compliance_pipeline_group" {
  type        = string
  description = "Specify user or group for compliance pipline repo."
  default     = ""
}

######## End Repo Groups #########################
######## Repo integration auth type ##############

variable "ci_pipeline_config_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'."
  default     = ""
}

variable "ci_inventory_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'."
  default     = ""
}

variable "ci_issues_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'."
  default     = ""
}

variable "ci_evidence_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'."
  default     = ""
}

variable "ci_app_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'."
  default     = ""
}

variable "ci_compliance_pipeline_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'."
  default     = "oauth"
}

######## End Repo auth type ######################

######## Secret Names ###########################

variable "ci_pipeline_ibmcloud_api_key_secret_name" {
  type        = string
  description = "Name of the Cloud API key secret in the secret provider."
  default     = "ibmcloud-api-key"
}

variable "ci_cos_api_key_secret_name" {
  type        = string
  description = "Name of the COS API key secret in the secret provider."
  default     = ""
}

variable "ci_issues_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider."
  default     = ""
}

variable "ci_evidence_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider."
  default     = ""
}

variable "ci_inventory_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider."
  default     = ""
}

variable "ci_compliance_pipeline_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider."
  default     = "git-token"
}

variable "ci_pipeline_config_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider."
  default     = ""
}

variable "ci_slack_webhook_secret_name" {
  type        = string
  description = "Name of the webhook secret in the secret provider."
  default     = ""
}

variable "ci_app_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider."
  default     = ""
}

variable "ci_signing_key_secret_name" {
  type        = string
  description = "Name of the signing key secret in the secret provider."
  default     = "signing_key"
}

variable "ci_pipeline_dockerconfigjson_secret_name" {
  type        = string
  description = "Name of the pipeline docker config JSON secret in the secret provider."
  default     = "pipeline_dockerconfigjson_secret_name"
}

######## End Secret Names #######################

variable "ci_opt_in_sonar" {
  type        = string
  description = "Opt in for Sonarqube"
  default     = "1"
}

variable "ci_doi_environment" {
  type        = string
  description = "The DevOps Insights target environment."
  default     = ""
}

variable "ci_doi_toolchain_id_pipeline_property" {
  type        = string
  description = "The DevOps Insights instance toolchain ID."
  default     = ""
}

variable "ci_cra_generate_cyclonedx_format" {
  type        = string
  description = "If set to 1, CRA also generates the BOM in cyclonedx format (defaults to 1)."
  default     = "1"
}

variable "ci_custom_image_tag" {
  type        = string
  description = "The custom tag for the image in a comma-separated list."
  default     = ""
}

variable "ci_app_version" {
  type        = string
  description = "The version of the app to deploy."
  default     = "v1"
}

variable "ci_slack_notifications" {
  type        = string
  description = "The switch that turns the Slack notification on (`1`) or off (`0`)."
  default     = ""
}

variable "ci_sonarqube_config" {
  type        = string
  description = "Runs a SonarQube scan in an isolated Docker-in-Docker container (default configuration) or in an existing Kubernetes cluster (custom configuration). Options: default or custom. Default is default."
  default     = "default"
}

variable "ci_enable_pipeline_dockerconfigjson" {
  type        = bool
  description = "Enable to add the pipeline-dockerconfigjson property to the pipeline properties."
  default     = false
}

######## SLACK INTEGRATION ###################

variable "ci_enable_slack" {
  type        = bool
  description = "Default: false. Set to true to create the integration."
  default     = false
}

variable "ci_slack_channel_name" {
  type        = string
  description = "The Slack channel that notifications are posted to."
  default     = ""
}

variable "ci_slack_team_name" {
  type        = string
  description = "The Slack team name, which is the word or phrase before `.slack.com` in the team URL."
  default     = ""
}

variable "ci_slack_pipeline_fail" {
  type        = bool
  description = "Generate pipeline failed notifications."
  default     = true
}

variable "ci_slack_pipeline_start" {
  type        = bool
  description = "Generate pipeline start notifications."
  default     = true
}

variable "ci_slack_pipeline_success" {
  type        = bool
  description = "Generate pipeline succeeded notifications."
  default     = true
}

variable "ci_slack_toolchain_bind" {
  type        = bool
  description = "Generate tool added to toolchain notifications."
  default     = true
}

variable "ci_slack_toolchain_unbind" {
  type        = bool
  description = "Generate tool removed from toolchain notifications."
  default     = true
}

#COS INTEGRATION
variable "ci_cos_endpoint" {
  type        = string
  description = "COS endpoint name."
  default     = ""
}

variable "ci_cos_bucket_name" {
  type        = string
  description = "COS bucket name."
  default     = ""
}

##### END OF CI VARIABLES ################
##### START OF CD VARIABLES ##############

variable "cd_toolchain_resource_group" {
  type        = string
  description = "Resource group within which toolchain is created."
  default     = ""
}

variable "cd_toolchain_name" {
  type        = string
  description = "The name of the CD Toolchain."
  default     = ""
}

variable "cd_toolchain_region" {
  type        = string
  description = "The region containing the CI toolchain. Use the short form of the regions. For example `us-south`."
  default     = ""
}

variable "cd_toolchain_description" {
  type        = string
  description = "Description for the CD toolchain."
  default     = "Toolchain created with terraform template for DevSecOps CD Best Practices."
}

variable "cd_cluster_name" {
  type        = string
  description = "Name of the Kubernetes cluster where the application is deployed."
  default     = ""
}

variable "cd_cluster_namespace" {
  type        = string
  description = "Name of the Kubernetes cluster namespace where the application is deployed."
  default     = "prod"
}

variable "cd_cluster_region" {
  type        = string
  description = "Region of the Kubernetes cluster where the application is deployed. Use the short form of the regions. For example `us-south`."
  default     = ""
}

variable "cd_region" {
  type        = string
  description = "IBM Cloud region used to prefix the `prod_latest` inventory repo branch."
  default     = ""
}

variable "cd_change_management_repo" {
  type        = string
  description = "This repository holds the change management requests created for the deployments."
  default     = ""
}

variable "cd_change_repo_clone_from_url" {
  type        = string
  description = "Override the default management repo, which is cloned into the app repo. Note, using clone_if_not_exists mode, so if the app repo already exists the repo contents are unchanged."
  default     = ""
}

variable "cd_deployment_repo_existing_git_provider" {
  type        = string
  description = "By default 'hostedgit', else use 'githubconsolidated' or 'gitlab'."
  default     = "hostedgit"
}

variable "cd_deployment_repo_existing_git_id" {
  type        = string
  description = "By default absent, else custom server GUID, or other options for 'git_id' field in the browser UI."
  default     = ""
}

variable "cd_deployment_repo_clone_to_git_provider" {
  type        = string
  description = "By default 'hostedgit', else use 'githubconsolidated' or 'gitlab'."
  default     = ""
}

variable "cd_deployment_repo_clone_to_git_id" {
  type        = string
  description = "By default absent, else custom server GUID, or other options for 'git_id' field in the browser UI."
  default     = ""
}
variable "cd_deployment_repo_clone_from_url" {
  type        = string
  description = "Override the default sample app by providing your own sample deployment URL, which is cloned into the app repo. Note, using clone_if_not_exists mode, so if the app repo already exists the repo contents are unchanged."
  default     = ""
}

variable "cd_deployment_repo_clone_from_branch" {
  type        = string
  description = "Used when deployment_repo_clone_from_url is provided, the default branch that is used by the CD build, usually either main or master."
  default     = ""
}
variable "cd_deployment_repo_existing_url" {
  type        = string
  description = "Override to bring your own existing deployment repository URL, which is used directly instead of cloning the default deployment sample."
  default     = ""
}
variable "cd_deployment_repo_existing_branch" {
  type        = string
  description = "Used when deployment_repo_existing_url is provided, the default branch that is by the CD build, usually either main or master."
  default     = ""
}

variable "cd_deployment_group" {
  type        = string
  description = "Specify group for deployment."
  default     = ""
}

variable "cd_change_management_group" {
  type        = string
  description = "Specify group for change management repository"
  default     = ""
}

variable "cd_authorization_policy_creation" {
  type        = string
  description = "Disable Toolchain service to Secrets Manager Service authorization policy creation."
  default     = ""
}

variable "cd_repositories_prefix" {
  type        = string
  description = "Prefix name for the cloned compliance repos."
  default     = ""
}

variable "cd_compliance_base_image" {
  type        = string
  description = "Pipeline baseimage to run most of the built-in pipeline code."
  default     = ""
}

variable "cd_doi_toolchain_id" {
  type        = string
  description = "DevOps Insights toolchain ID to link to."
  default     = ""
}

variable "cd_doi_environment" {
  type        = string
  description = "DevOps Insights environment for DevSecOps CD deployment."
  default     = ""
}

variable "cd_link_to_doi_toolchain" {
  description = "Enable a link to a DevOps Insights instance in another toolchain, true or false."
  type        = bool
  default     = true
}

variable "create_cd_toolchain" {
  description = "Boolean flag which determines if the DevSecOps CD toolchain is created."
  type        = bool
  default     = true
}

variable "cd_enable_key_protect" {
  description = "Use the Key Protect integration."
  type        = bool
  default     = false
}

variable "cd_enable_secrets_manager" {
  description = "Use the Secrets Manager integration."
  type        = bool
  default     = false
}

variable "cd_sm_secret_group" {
  type        = string
  description = "Group in Secrets Manager for organizing/grouping secrets."
  default     = ""
}

variable "cd_sm_resource_group" {
  type        = string
  description = "The resource group containing the Secrets Manager instance for your secrets."
  default     = ""
}

variable "cd_sm_name" {
  type        = string
  description = "Name of the Secrets Manager instance where the secrets are stored."
  default     = ""
}

variable "cd_sm_location" {
  type        = string
  description = "IBM Cloud location/region containing the Secrets Manager instance."
  default     = ""
}

variable "cd_kp_resource_group" {
  type        = string
  description = "The resource group containing the Key Protect instance for your secrets."
  default     = ""
}

variable "cd_kp_name" {
  type        = string
  description = "Name of the Key Protect instance where the secrets are stored."
  default     = ""
}

variable "cd_kp_location" {
  type        = string
  description = "IBM Cloud location/region containing the Key Protect instance."
  default     = ""
}

variable "cd_pipeline_config_repo_existing_url" {
  type        = string
  description = "Specify a repository containing a custom pipeline-config.yaml file."
  default     = ""
}

variable "cd_pipeline_config_repo_clone_from_url" {
  type        = string
  description = "Specify a repository containing a custom pipeline-config.yaml file."
  default     = ""
}

variable "cd_pipeline_config_repo_branch" {
  type        = string
  description = "Specify the branch containing the custom pipeline-config.yaml file."
  default     = ""
}

variable "cd_pipeline_config_path" {
  type        = string
  description = "The name and path of the pipeline-config.yaml file within the pipeline-config repo."
  default     = ".pipeline-config.yaml"
}

######## Repo Groups #############################

variable "cd_issues_group" {
  type        = string
  description = "Specify Git user or group for issues repository."
  default     = ""
}

variable "cd_inventory_group" {
  type        = string
  description = "Specify Git user or group for inventory repository."
  default     = ""
}

variable "cd_evidence_group" {
  type        = string
  description = "Specify Git user or group for evidence repository."
  default     = ""
}

variable "cd_pipeline_config_group" {
  type        = string
  description = "Specify user or group for pipeline config repo."
  default     = ""
}

variable "cd_compliance_pipeline_group" {
  type        = string
  description = "Specify user or group for compliance pipline repo."
  default     = ""
}

######## End Repo Groups #########################
######## Repo integration auth type ##############

variable "cd_pipeline_config_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'."
  default     = ""
}

variable "cd_inventory_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'."
  default     = ""
}

variable "cd_issues_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'."
  default     = ""
}

variable "cd_evidence_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'."
  default     = ""
}

variable "cd_deployment_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'."
  default     = ""
}

variable "cd_compliance_pipeline_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'."
  default     = "oauth"
}

variable "cd_change_management_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'."
  default     = ""
}

######## End Repo auth type ######################

######## Secret Names ###########################

variable "cd_pipeline_ibmcloud_api_key_secret_name" {
  type        = string
  description = "Name of the Cloud API key secret in the secret provider."
  default     = "ibmcloud-api-key"
}

variable "cd_cos_api_key_secret_name" {
  type        = string
  description = "Name of the COS API key secret in the secret provider."
  default     = ""
}

variable "cd_issues_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider."
  default     = ""
}

variable "cd_evidence_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider."
  default     = ""
}

variable "cd_inventory_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider."
  default     = ""
}

variable "cd_compliance_pipeline_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider."
  default     = "git-token"
}

variable "cd_pipeline_config_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider."
  default     = ""
}

variable "cd_deployment_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider."
  default     = ""
}

variable "cd_change_management_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider."
  default     = ""
}

variable "cd_code_signing_cert_secret_name" {
  type        = string
  description = "Name of the code signing certificate secret in the secret provider."
  default     = "code-signing-cert"
}

######## End Secret Names #######################

######## SCC #####################################


variable "cd_scc_integration_name" {
  type        = string
  description = "The name of the SCC integration."
  default     = "Security and Compliance"
}

variable "cd_scc_enable_scc" {
  type        = bool
  description = "Enable the SCC integration."
  default     = true
}

######## End SCC ################################

variable "cd_slack_notifications" {
  type        = string
  description = "The switch that turns the Slack notification on (`1`) or off (`0`)."
  default     = ""
}


variable "cd_target_environment_detail" {
  description = "Details of the environment being updated."
  type        = string
  default     = "Production target environment"
}

variable "cd_customer_impact" {
  description = "Custom impact of the change request."
  type        = string
  default     = "no_impact"
}

variable "cd_target_environment_purpose" {
  description = "Purpose of the environment being updated."
  type        = string
  default     = "production"
}

variable "cd_change_request_id" {
  type        = string
  description = "The ID of an open change request. If this parameter is set to 'notAvailable' by default, a change request is automatically created by the continuous deployment pipeline."
  default     = "notAvailable"
}

variable "cd_satellite_cluster_group" {
  type        = string
  description = "The Satellite cluster group"
  default     = ""
}

variable "cd_source_environment" {
  type        = string
  description = "The source environment that the app is promoted from."
  default     = "master"
}

variable "cd_target_environment" {
  type        = string
  description = "The target environment that the app is deployed to."
  default     = "prod"
}

variable "cd_merge_cra_sbom" {
  type        = string
  description = "Merge the SBOM"
  default     = "1"
}

variable "cd_opt_out_v1_evidence" {
  type        = string
  description = "Opt out of evidence v1."
  default     = "1"
}

variable "cd_emergency_label" {
  type        = string
  description = "Identifies the pull request as an emergency."
  default     = "EMERGENCY"
}

variable "cd_app_version" {
  type        = string
  description = "The version of the app to deploy."
  default     = "v1"
}

variable "cd_pipeline_debug" {
  type        = string
  description = "'0' by default. Set to '1' to enable debug logging."
  default     = "0"
}

variable "cd_enable_signing_validation" {
  type        = bool
  description = "Enable to add the code-signing-certificate property to the pipeline properties."
  default     = false
}

variable "cd_peer_review_compliance" {
  type        = string
  description = "Set to `0` to disable. Set to `1` to enable peer review evidence collection."
  default     = ""
}

#SLACK
variable "cd_slack_webhook_secret_name" {
  type        = string
  description = "Name of the webhook secret in the secret provider."
  default     = ""
}

variable "cd_enable_slack" {
  type        = bool
  description = "Default: false. Set to true to create the integration."
  default     = false
}

variable "cd_slack_channel_name" {
  type        = string
  description = "The Slack channel that notifications are posted to."
  default     = ""
}

variable "cd_slack_team_name" {
  type        = string
  description = "The Slack team name, which is the word or phrase before .slack.com in the team URL."
  default     = ""
}

variable "cd_slack_pipeline_fail" {
  type        = bool
  description = "Generate pipeline failed notifications."
  default     = true
}

variable "cd_slack_pipeline_start" {
  type        = bool
  description = "Generate pipeline start notifications."
  default     = true
}

variable "cd_slack_pipeline_success" {
  type        = bool
  description = "Generate pipeline succeeded notifications."
  default     = true
}

variable "cd_slack_toolchain_bind" {
  type        = bool
  description = "Generate tool added to toolchain notifications."
  default     = true
}

variable "cd_slack_toolchain_unbind" {
  type        = bool
  description = "Generate tool removed from toolchain notifications."
  default     = true
}

#COS
variable "cd_cos_endpoint" {
  type        = string
  description = "COS endpoint name."
  default     = ""
}

variable "cd_cos_bucket_name" {
  type        = string
  description = "COS bucket name."
  default     = ""
}

##### END OF CD VARIABLES ################
##### START OF CC VARIABLES ##############

variable "cc_toolchain_resource_group" {
  type        = string
  description = "Resource group within which the toolchain is created."
  default     = ""
}

variable "cc_toolchain_name" {
  type        = string
  description = "The name of the CC Toolchain."
  default     = ""
}

variable "cc_toolchain_region" {
  type        = string
  description = "The region containing the CI toolchain. Use the short form of the regions. For example `us-south`."
  default     = ""
}

variable "cc_toolchain_description" {
  type        = string
  description = "Description for the CC Toolchain."
  default     = "Toolchain created with terraform template for DevSecOps CC Best Practices."
}

variable "cc_doi_environment" {
  type        = string
  description = "DevOps Insights environment for DevSecOps CD deployment."
  default     = ""
}

variable "cc_link_to_doi_toolchain" {
  description = "Enable a link to a DevOps Insights instance in another toolchain, true or false."
  type        = bool
  default     = true
}

variable "create_cc_toolchain" {
  description = "Boolean flag which determines if the DevSecOps CC toolchain is created."
  type        = bool
  default     = true
}

variable "cc_enable_key_protect" {
  description = "Enable the Key Protect integration."
  type        = bool
  default     = false
}

variable "cc_enable_secrets_manager" {
  description = "Enable the Secrets Manager integration."
  type        = bool
  default     = false
}

variable "cc_sm_secret_group" {
  type        = string
  description = "Group in Secrets Manager for organizing/grouping secrets."
  default     = ""
}

variable "cc_sm_resource_group" {
  type        = string
  description = "The resource group containing the Secrets Manager instance for your secrets."
  default     = ""
}

variable "cc_sm_name" {
  type        = string
  description = "Name of the Secrets Manager instance where the secrets are stored."
  default     = ""
}

variable "cc_sm_location" {
  type        = string
  description = "IBM Cloud location/region containing the Secrets Manager instance."
  default     = ""
}

variable "cc_kp_resource_group" {
  type        = string
  description = "The resource group containing the Key Protect instance for your secrets."
  default     = ""
}

variable "cc_kp_name" {
  type        = string
  description = "Name of the Key Protect instance where the secrets are stored."
  default     = ""
}

variable "cc_kp_location" {
  type        = string
  description = "IBM Cloud location/region containing the Key Protect instance."
  default     = ""
}

variable "cc_pipeline_config_repo_existing_url" {
  type        = string
  description = "Specify a repository containing a custom pipeline-config.yaml file."
  default     = ""
}

variable "cc_pipeline_config_repo_clone_from_url" {
  type        = string
  description = "Specify a repository containing a custom pipeline-config.yaml file."
  default     = ""
}

variable "cc_pipeline_config_repo_branch" {
  type        = string
  description = "Specify the branch containing the custom pipeline-config.yaml file."
  default     = ""
}

variable "cc_pipeline_config_path" {
  type        = string
  description = "The name and path of the pipeline-config.yaml file within the pipeline-config repo."
  default     = ".pipeline-config.yaml"
}

variable "cc_app_repo_url" {
  type        = string
  description = "This Git URL for the application repository."
  default     = ""
}

variable "cc_app_repo_git_provider" {
  type        = string
  description = "The type of the Git provider."
  default     = "hostedgit"
}

variable "cc_app_repo_branch" {
  type        = string
  description = "The default branch of the app repo."
  default     = "master"
}

variable "cc_app_repo_git_id" {
  type        = string
  description = "The Git Id of the repository."
  default     = ""
}

######## Repo Groups #############################

variable "cc_issues_group" {
  type        = string
  description = "Specify Git user or group for issues repository."
  default     = ""
}

variable "cc_inventory_group" {
  type        = string
  description = "Specify Git user or group for inventory repository."
  default     = ""
}

variable "cc_evidence_group" {
  type        = string
  description = "Specify Git user or group for evidence repository."
  default     = ""
}

variable "cc_pipeline_config_group" {
  type        = string
  description = "Specify user or group for pipeline config repo."
  default     = ""
}

variable "cc_app_group" {
  type        = string
  description = "Specify user or group for app repo."
  default     = ""
}

variable "cc_compliance_pipeline_group" {
  type        = string
  description = "Specify user or group for compliance pipline repo."
  default     = ""
}

######## End Repo Groups #########################
######## Repo integration auth type ##############

variable "cc_pipeline_config_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'."
  default     = ""
}

variable "cc_inventory_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'."
  default     = ""
}

variable "cc_issues_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'."
  default     = ""
}

variable "cc_evidence_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'"
  default     = ""
}

variable "cc_app_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'."
  default     = ""
}

variable "cc_compliance_pipeline_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'."
  default     = "oauth"
}

######## End Repo auth type ######################

######## Secret Names ###########################

variable "cc_pipeline_ibmcloud_api_key_secret_name" {
  type        = string
  description = "Name of the Cloud API key secret in the secret provider."
  default     = "ibmcloud-api-key"
}

variable "cc_cos_api_key_secret_name" {
  type        = string
  description = "Name of the COS API key secret in the secret provider."
  default     = ""
}

variable "cc_issues_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider."
  default     = ""
}

variable "cc_evidence_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider."
  default     = ""
}

variable "cc_inventory_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider."
  default     = ""
}

variable "cc_compliance_pipeline_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider."
  default     = "git-token"
}

variable "cc_pipeline_config_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider."
  default     = ""
}

variable "cc_app_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider."
  default     = ""
}

variable "cc_pipeline_dockerconfigjson_secret_name" {
  type        = string
  description = "Name of the pipeline docker config JSON secret in the secret provider."
  default     = "pipeline_dockerconfigjson_secret_name"
}

######## End Secret Names #######################

######## SCC #####################################

variable "cc_scc_integration_name" {
  type        = string
  description = "The name of the SCC integration."
  default     = "Security and Compliance"
}

variable "cc_scc_enable_scc" {
  type        = bool
  description = "Enable the SCC integration"
  default     = true
}

######## End SCC ################################

variable "cc_slack_notifications" {
  type        = string
  description = "The switch that turns the Slack notification on (`1`) or off (`0`)."
  default     = ""
}

variable "cc_sonarqube_config" {
  type        = string
  description = "Runs a SonarQube scan in an isolated Docker-in-Docker container (default configuration) or in an existing Kubernetes cluster (custom configuration). Options: default or custom. Default is default."
  default     = "default"
}

######### SLACK ###############################

variable "cc_slack_webhook_secret_name" {
  type        = string
  description = "Name of the webhook secret in the secret provider."
  default     = ""
}

variable "cc_enable_slack" {
  type        = bool
  description = "Set to true to create the integration."
  default     = false
}

variable "cc_slack_channel_name" {
  type        = string
  description = "The Slack channel that notifications are posted to."
  default     = ""
}

variable "cc_slack_team_name" {
  type        = string
  description = "The Slack team name, which is the word or phrase before .slack.com in the team URL."
  default     = ""
}

variable "cc_slack_pipeline_fail" {
  type        = bool
  description = "Generate pipeline failed notifications."
  default     = true
}

variable "cc_slack_pipeline_start" {
  type        = bool
  description = "Generate pipeline start notifications."
  default     = true
}

variable "cc_slack_pipeline_success" {
  type        = bool
  description = "Generate pipeline succeeded notifications."
  default     = true
}

variable "cc_slack_toolchain_bind" {
  type        = bool
  description = "Generate tool added to toolchain notifications."
  default     = true
}

variable "cc_slack_toolchain_unbind" {
  type        = bool
  description = "Generate tool removed from toolchain notifications."
  default     = true
}

#COS
variable "cc_cos_endpoint" {
  type        = string
  description = "COS endpoint name."
  default     = ""
}

variable "cc_cos_bucket_name" {
  type        = string
  description = "COS bucket name."
  default     = ""
}

variable "cc_doi_toolchain_id" {
  type        = string
  description = "DevOps Insights toolchain ID to link to."
  default     = ""
}

variable "cc_repositories_prefix" {
  type        = string
  description = "The prefix for the compliance repositories."
  default     = ""
}

variable "cc_compliance_base_image" {
  type        = string
  description = "Pipeline baseimage to run most of the built-in pipeline code."
  default     = ""
}

variable "cc_authorization_policy_creation" {
  type        = string
  description = "Disable Toolchain service to Secrets Manager Service authorization policy creation."
  default     = ""
}

variable "cc_pipeline_debug" {
  type        = string
  description = "'0' by default. Set to '1' to enable debug logging."
  default     = "0"
}

variable "cc_opt_in_dynamic_api_scan" {
  type        = string
  description = "To enable the OWASP Zap API scan. '1' enable or '0' disable."
  default     = ""
}

variable "cc_opt_in_dynamic_ui_scan" {
  type        = string
  description = "To enable the OWASP Zap UI scan. '1' enable or '0' disable."
  default     = ""
}

variable "cc_opt_in_dynamic_scan" {
  type        = string
  description = "To enable the OWASP Zap scan. '1' enable or '0' disable."
  default     = ""
}

variable "cc_opt_in_auto_close" {
  type        = string
  description = "Enables auto-closing of issues coming from vulnerabilities, once the vulnerability is no longer detected by the CC pipeline run."
  default     = "1"
}

variable "cc_environment_tag" {
  type        = string
  description = "Tag name that represents the target environment in the inventory. Example: prod_latest."
  default     = "prod_latest"
}

variable "cc_enable_pipeline_dockerconfigjson" {
  type        = bool
  description = "Enable to add the pipeline-dockerconfigjson property to the pipeline properties."
  default     = false
}

variable "cc_peer_review_compliance" {
  type        = string
  description = "Set to `0` to disable. Set to `1` to enable peer review evidence collection."
  default     = ""
}

##### END OF CC VARIABLES ################
