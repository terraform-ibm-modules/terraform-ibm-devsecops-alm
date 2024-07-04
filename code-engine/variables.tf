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
  description = "The region identifier that will be used, by default, for all resource creation and service instance lookup. This can be overridden on a per resource/service basis. See `ci_toolchain_region`,`cd_toolchain_region`,`cc_toolchain_region`, `ci_registry_region`."
  default     = "us-south"
}

variable "cos_api_key_secret_name" {
  type        = string
  description = "To enable the use of COS, a secret name to a COS API key secret in the secret provider is required. In addition `cos_endpoint` and `cos_bucket_name` must be set. This setting sets the same API key for the COS settings in the CI, CD, and CC toolchains. See `ci_cos_api_key_secret_name`, `cd_cos_api_key_secret_name`, and `cc_cos_api_key_secret_name` to set separately."
  default     = "cos-api-key"
}

variable "inventory_repo_url" {
  type        = string
  description = "Deprecated: Use `inventory_repo_existing_url`. This is a template repository to link compliance-inventory for reference DevSecOps toolchain templates."
  default     = ""
}

variable "evidence_repo_url" {
  type        = string
  description = "Deprecated: Use `evidence_repo_existing_url`. This is a template repository to link compliance-evidence-locker for reference DevSecOps toolchain templates."
  default     = ""
}

variable "issues_repo_url" {
  type        = string
  description = "Deprecated: Use `issues_repo_existing_url`. This is a template repository to link compliance-issues for reference DevSecOps toolchain templates."
  default     = ""
}

variable "evidence_repo_name" {
  type        = string
  description = "The repository name."
  default     = ""
}

variable "evidence_repo_existing_url" {
  type        = string
  description = "This is a template repository to clone compliance-evidence-locker for reference DevSecOps toolchain templates."
  default     = ""
}

variable "evidence_repo_existing_git_provider" {
  type        = string
  default     = "hostedgit"
  description = "Git provider for evidence repo"
  validation {
    condition     = contains(["hostedgit", "githubconsolidated", "gitlab"], var.evidence_repo_existing_git_provider)
    error_message = "Must be either \"hostedgit\" or \"gitlab\" or \"githubconsolidated\" for evidence repo."
  }
}

variable "evidence_repo_existing_git_id" {
  type        = string
  description = "Set this value to `github` for github.com, or to the GUID of a custom GitHub Enterprise server."
  default     = ""
}

variable "evidence_repo_integration_owner" {
  type        = string
  description = "The name of the integration owner."
  default     = ""
}

variable "issues_repo_name" {
  type        = string
  description = "The repository name."
  default     = ""
}

variable "issues_repo_existing_url" {
  type        = string
  description = "This is a template repository to clone compliance-issues for reference DevSecOps toolchain templates."
  default     = ""
}

variable "issues_repo_existing_git_provider" {
  type        = string
  default     = "hostedgit"
  description = "Git provider for issue repo "
  validation {
    condition     = contains(["hostedgit", "githubconsolidated", "gitlab"], var.issues_repo_existing_git_provider)
    error_message = "Must be either \"hostedgit\" or \"gitlab\" or \"githubconsolidated\" for issue repo."
  }
}

variable "issues_repo_existing_git_id" {
  type        = string
  description = "Set this value to `github` for github.com, or to the GUID of a custom GitHub Enterprise server."
  default     = ""
}

variable "issues_repo_integration_owner" {
  type        = string
  description = "The name of the integration owner."
  default     = ""
}

variable "inventory_repo_name" {
  type        = string
  description = "The repository name."
  default     = ""
}

variable "inventory_repo_existing_url" {
  type        = string
  description = "This is a template repository to clone compliance-inventory for reference DevSecOps toolchain templates."
  default     = ""
}

variable "inventory_repo_existing_git_provider" {
  type        = string
  default     = "hostedgit"
  description = "Git provider for inventory repo"
  validation {
    condition     = contains(["hostedgit", "githubconsolidated", "gitlab"], var.inventory_repo_existing_git_provider)
    error_message = "Must be either \"hostedgit\" or \"gitlab\" or \"githubconsolidated\" for Inventory repo."
  }
}

variable "inventory_repo_existing_git_id" {
  type        = string
  description = "Set this value to `github` for github.com, or to the GUID of a custom GitHub Enterprise server."
  default     = ""
}

variable "inventory_repo_integration_owner" {
  type        = string
  description = "The name of the integration owner."
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
  description = "The resource group that will be used, by default, for all resource creation and service instance lookups. This can be overridden on a per resource/service basis. See `ci_toolchain_resource_group`,`cd_toolchain_resource_group`,`cc_toolchain_resource_group`."
  default     = "Default"
}

variable "gosec_repo_ssh_key_secret_group" {
  type        = string
  description = "Secret group prefix for the gosec private repository ssh key secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
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

variable "gosec_repo_ssh_key_secret_name" {
  type        = string
  default     = "git-ssh-key"
  description = "Name of the SSH key token for the private repository in the secret provider."
}

variable "sm_instance_crn" {
  type        = string
  description = "The CRN of the Secrets Manager instance. Will apply to CI, CD and CC toolchains unless set individually."
  default     = ""
}

variable "repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the repositories Git Token."
  default     = ""
  validation {
    condition     = startswith(var.repo_git_token_secret_crn, "crn:") || var.repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "pipeline_ibmcloud_api_key_secret_name" {
  type        = string
  description = "Name of the Cloud API key secret in the secret provider. Applies to the CI, CD and CC toolchains. For specific versions see `ci_pipeline_ibmcloud_api_key_secret_name`, `cd_pipeline_ibmcloud_api_key_secret_name` and `cc_pipeline_ibmcloud_api_key_secret_name`."
  default     = "ibmcloud-api-key"
}

variable "pipeline_ibmcloud_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the IBMCloud apikey."
  default     = ""
  validation {
    condition     = startswith(var.pipeline_ibmcloud_api_key_secret_crn, "crn:") || var.pipeline_ibmcloud_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "pipeline_doi_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the pipeline DOI apikey."
  default     = ""
  validation {
    condition     = startswith(var.pipeline_doi_api_key_secret_crn, "crn:") || var.pipeline_doi_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "sonarqube_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the SonarQube secret."
  default     = ""
  validation {
    condition     = startswith(var.sonarqube_secret_crn, "crn:") || var.sonarqube_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "gosec_private_repository_ssh_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the GoSec repository secret."
  default     = ""
  validation {
    condition     = startswith(var.gosec_private_repository_ssh_key_secret_crn, "crn:") || var.gosec_private_repository_ssh_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cos_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Cloud Object Storage apikey."
  default     = ""
  validation {
    condition     = startswith(var.cos_api_key_secret_crn, "crn:") || var.cos_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "scc_scc_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the SCC apikey."
  default     = ""
  validation {
    condition     = startswith(var.scc_scc_api_key_secret_crn, "crn:") || var.scc_scc_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "slack_webhook_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Slack webhook secret."
  default     = ""
  validation {
    condition     = startswith(var.slack_webhook_secret_crn, "crn:") || var.slack_webhook_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
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

variable "repo_secret_group" {
  type        = string
  description = "Secret group in Secrets Manager that contains the secret for the repo. This variable will set the same secret group for all the repositories. Can be overriden on a per secret group basis. Only applies when using Secrets Manager."
  default     = ""
}

variable "prefix" {
  type        = string
  description = "A prefix that is added to the toolchain names."
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

variable "pipeline_git_tag" {
  type        = string
  description = "The GIT tag within the pipeline definitions repository for the Compliance Pipelines."
  default     = ""
}

variable "repositories_prefix" {
  type        = string
  description = "Prefix name for the cloned compliance repos. For the repositories_prefix value only a-z, A-Z and 0-9 and the special characters `-_` are allowed. In addition the string must not end with a special character or have two consecutive special characters."
  default     = "compliance"
  validation {
    condition = (
      (can(regex("^[0-9A-Za-z\\-\\_]+$", var.repositories_prefix))) && ((endswith(var.repositories_prefix, "-") == false) && (endswith(var.repositories_prefix, "_") == false))
      && (strcontains(var.repositories_prefix, "--") == false) && (strcontains(var.repositories_prefix, "__") == false) && (strcontains(var.repositories_prefix, "_-") == false)
      && (strcontains(var.repositories_prefix, "-_") == false)
    )
    error_message = "For the repositories_prefix value only a-z, A-Z and 0-9 and the special characters `-_` are allowed. In addition the string must not end with a special character or have two consecutive special characters."
  }
}

variable "compliance_pipeline_branch" {
  type        = string
  description = "The Compliance Pipeline branch."
  default     = "open-v9"
}

variable "peer_review_compliance" {
  type        = string
  description = "Set to `0` to disable. Set to `1` to enable peer review evidence collection. This parameter will apply to the CI, CD and CC pipelines. Can be set individually with `ci_peer_review_compliance`, `cd_peer_review_compliance`, `cc_peer_review_compliance`."
  default     = ""
}

variable "event_notifications_tool_name" {
  type        = string
  description = "The name of the Event Notifications integration."
  default     = "Event Notifications"
}

variable "event_notifications_crn" {
  type        = string
  description = "Set the Event Notifications CRN to create an Events Notification integration. This paramater will apply to the CI, CD and CC toolchains. Can be set individually with `ci_event_notifications_crn`, `cd_event_notifications_crn`, `cc_event_notifications_crn`."
  default     = ""
}

variable "sm_integration_name" {
  type        = string
  description = "The name of the Secrets Manager integration."
  default     = "sm-compliance-secrets"
}

variable "kp_integration_name" {
  type        = string
  description = "The name of the Key Protect integration."
  default     = "kp-compliance-secrets"
}

variable "slack_integration_name" {
  type        = string
  description = "The name of the Slack integration."
  default     = "slack-compliance"
}

variable "scc_attachment_id" {
  type        = string
  description = "An attachment ID. An attachment is configured under a profile to define how a scan will be run. To find the attachment ID, in the browser, in the attachments list, click on the attachment link, and a panel appears with a button to copy the attachment ID. This parameter is only relevant when the `scc_use_profile_attachment` parameter is enabled."
  default     = ""
}

variable "scc_instance_crn" {
  type        = string
  description = "The Security and Compliance Center service instance CRN (Cloud Resource Name). This parameter is only relevant when the `scc_use_profile_attachment` parameter is enabled. The value must match the regular expression."
  default     = ""
}

variable "scc_profile_name" {
  type        = string
  description = "The name of a Security and Compliance Center profile. Use the `IBM Cloud Framework for Financial Services` profile, which contains the DevSecOps Toolchain rules. Or use a user-authored customized profile that has been configured to contain those rules. This parameter is only relevant when the `scc_use_profile_attachment` parameter is enabled."
  default     = ""
}

variable "scc_profile_version" {
  type        = string
  description = "The version of a Security and Compliance Center profile, in SemVer format, like `0.0.0`. This parameter is only relevant when the `scc_use_profile_attachment` parameter is enabled."
  default     = ""
}

variable "scc_scc_api_key_secret_name" {
  type        = string
  description = "The Security and Compliance Center api-key secret in the secret provider."
  default     = "scc-api-key"
}

variable "scc_scc_api_key_secret_group" {
  type        = string
  description = "Secret group prefix for the Security and Compliance tool secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "scc_use_profile_attachment" {
  type        = string
  description = "Set to `enabled` to enable use profile with attachment, so that the scripts in the pipeline can interact with the Security and Compliance Center service. When enabled, other parameters become relevant; `scc_scc_api_key_secret_name`, `scc_instance_crn`, `scc_profile_name`, `scc_profile_version`, `scc_attachment_id`. Can individually be `enabled` and `disabled` in the CD and CC toolchains using `cd_scc_use_profile_attachment` and `cc_scc_use_profile_attachment`."
  default     = "disabled"
}

variable "pipeline_doi_api_key_secret_name" {
  type        = string
  description = "Name of the Cloud API key secret in the secret provider to access the toolchain containing the Devops Insights instance. This will apply to the CI, CD and CC toolchains."
  default     = ""
}

variable "pipeline_doi_api_key_secret_group" {
  type        = string
  description = "Secret group prefix for the pipeline DOI api key. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. Applies to the CI, CD and CC toolchains."
  default     = ""
}

variable "opt_in_gosec" {
  type        = string
  description = "Enables gosec scans"
  default     = ""
}

variable "gosec_private_repository_host" {
  type        = string
  description = "Your private repository base URL."
  default     = ""
}

variable "deployment_target" {
  type        = string
  description = "The deployment target, 'cluster' or 'code-engine'. Applies to both the CI and CD toolchains. To set individually use  `ci_deployment_target` and `cd_deployment_target`."
  default     = "code-engine"
}

######## Code Engine Vars #####################
variable "code_engine_project" {
  type        = string
  description = "The name of the Code Engine project to use. Created if it does not exist. Applies to both the CI and CD toolchains. To set individually use `ci_code_engine_project` and `cd_code_engine_project`."
  default     = ""
}

variable "autostart" {
  type        = bool
  description = "Set to `true` to auto run the CI pipeline in the CI toolchain after creation."
  default     = false
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

variable "registry_namespace" {
  type        = string
  description = "A unique namespace within the IBM Cloud Container Registry region where the application image is stored."
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

variable "ci_compliance_pipeline_branch" {
  type        = string
  description = "The CI Pipeline Compliance Pipeline branch."
  default     = ""
}

variable "ci_compliance_pipeline_pr_branch" {
  type        = string
  description = "The PR Pipeline Compliance Pipeline branch."
  default     = ""
}

variable "ci_pipeline_git_tag" {
  type        = string
  description = "The GIT tag within the pipeline definitions repository for the Compliance CI Pipeline."
  default     = ""
}

variable "pr_pipeline_git_tag" {
  type        = string
  description = "The GIT tag within the pipeline definitions repository for the Compliance PR Pipeline."
  default     = ""
}

variable "ci_pipeline_properties" {
  type        = string
  description = "Stringified JSON containing the properties for the CI toolchain pipelines."
  default     = ""
}

variable "ci_pipeline_properties_filepath" {
  type        = string
  description = "The path to the file containing the property JSON. If this is not set, it will by default read the `properties.json` file at the root of the module."
  default     = ""
}

variable "ci_print_code_signing_certificate" {
  type        = string
  description = "Set to `1` to enable printing of the public signing certificate in the logs."
  default     = "1"
}

variable "ci_repository_properties" {
  type        = string
  description = "Stringified JSON containing the repositories and triggers that get created in the CI toolchain pipelines."
  default     = ""
}

variable "ci_repository_properties_filepath" {
  type        = string
  description = "The path to the file containing the repository and triggers JSON. If this is not set, it will by default read the `repositories.json` file at the root of the module."
  default     = ""
}

variable "ci_repositories_prefix" {
  type        = string
  description = "Prefix name for the cloned compliance repos. For the repositories_prefix value only a-z, A-Z and 0-9 and the special characters `-_` are allowed. In addition the string must not end with a special character or have two consecutive special characters."
  default     = ""
  validation {
    condition = (
      ((can(regex("^[0-9A-Za-z\\-\\_]+$", var.ci_repositories_prefix))) && ((endswith(var.ci_repositories_prefix, "-") == false) && (endswith(var.ci_repositories_prefix, "_") == false))
        && (strcontains(var.ci_repositories_prefix, "--") == false) && (strcontains(var.ci_repositories_prefix, "__") == false) && (strcontains(var.ci_repositories_prefix, "_-") == false)
      && (strcontains(var.ci_repositories_prefix, "-_") == false))
      || (length(var.ci_repositories_prefix) == 0)
    )
    error_message = "For the repositories_prefix value only a-z, A-Z and 0-9 and the special characters `-_` are allowed. In addition the string must not end with a special character or have two consecutive special characters."
  }
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

variable "pr_cra_bom_generate" {
  type        = string
  description = "Set this flag to `1` to generate cra bom in PR pipeline"
  default     = "1"
  validation {
    condition     = contains(["0", "1"], var.pr_cra_bom_generate)
    error_message = "Must be either \"0\" or \"1\" ."
  }
}

variable "pr_cra_vulnerability_scan" {
  type        = string
  description = "Set this flag to `1` and `pr-cra-bom-generate` to `1` for cra vulnerability scan in PR pipeline. If this value is set to `1` and `pr-cra-bom-generate` is set to `0`, the scan will be marked as `failure`"
  default     = "1"
  validation {
    condition     = contains(["0", "1"], var.pr_cra_vulnerability_scan)
    error_message = "Must be either \"0\" or \"1\" ."
  }

}

variable "pr_cra_deploy_analysis" {
  type        = string
  description = "Set this flag to `1` for cra deployment analysis to be done in PR pipeline."
  default     = "1"
  validation {
    condition     = contains(["0", "1"], var.pr_cra_deploy_analysis)
    error_message = "Must be either \"0\" or \"1\" ."
  }
}

variable "ci_cra_bom_generate" {
  type        = string
  description = "Set this flag to `1` to generate cra bom in CI pipeline."
  default     = "1"
  validation {
    condition     = contains(["0", "1"], var.ci_cra_bom_generate)
    error_message = "Must be either \"0\" or \"1\" ."
  }
}

variable "ci_cra_vulnerability_scan" {
  type        = string
  description = "Set this flag to `1` and `ci-cra-bom-generate` to `1` for cra vulnerability scan in CI pipeline. If this value is set to 1 and `ci-cra-bom-generate` is set to `0`, the scan will be marked as `failure`"
  default     = "1"
  validation {
    condition     = contains(["0", "1"], var.ci_cra_vulnerability_scan)
    error_message = "Must be either \"0\" or \"1\" ."
  }

}

variable "ci_cra_deploy_analysis" {
  type        = string
  description = "Set this flag to `1` for cra deployment analysis to be done in CI pipeline."
  default     = "1"
  validation {
    condition     = contains(["0", "1"], var.ci_cra_deploy_analysis)
    error_message = "Must be either \"0\" or \"1\" ."
  }
}

variable "ci_enable_pipeline_notifications" {
  type        = bool
  description = "When enabled, pipeline run events will be sent to the Event Notifications and Slack integrations in the enclosing toolchain."
  default     = false
}

variable "ci_event_notifications" {
  type        = string
  description = "To enable event notification, set event_notifications to 1 "
  default     = "0"
  validation {
    condition     = contains(["0", "1"], var.ci_event_notifications)
    error_message = "Must be either \"0\" or \"1\" ."
  }
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

variable "ci_peer_review_compliance" {
  type        = string
  description = "Set to `0` to disable. Set to `1` to enable peer review evidence collection."
  default     = ""
}

variable "ci_opt_in_gosec" {
  type        = string
  description = "Enables gosec scans"
  default     = ""
}

variable "ci_gosec_private_repository_host" {
  type        = string
  description = "Your private repository base URL."
  default     = ""
}

####### CI Trigger properties ###################
variable "ci_trigger_git_name" {
  type        = string
  description = "The name of the CI pipeline GIT trigger."
  default     = "Git CI Trigger"
}
variable "ci_trigger_git_enable" {
  type        = bool
  description = "Set to `true` to enable the CI pipeline Git trigger."
  default     = true
}

variable "ci_trigger_timed_name" {
  type        = string
  description = "The name of the CI pipeline Timed trigger."
  default     = "Git CI Timed Trigger"
}
variable "ci_trigger_timed_enable" {
  type        = bool
  description = "Set to `true` to enable the CI pipeline Timed trigger."
  default     = false
}
variable "ci_trigger_timed_cron_schedule" {
  type        = string
  description = "Only needed for timer triggers. Cron expression that indicates when this trigger will activate. Maximum frequency is every 5 minutes. The string is based on UNIX crontab syntax: minute, hour, day of month, month, day of week. Example: 0 *_/2 * * * - every 2 hours."
  default     = "0 4 * * *"
}

variable "ci_trigger_manual_name" {
  type        = string
  description = "The name of the CI pipeline Manual trigger."
  default     = "Manual Trigger"
}
variable "ci_trigger_manual_enable" {
  type        = bool
  description = "Set to `true` to enable the CI pipeline Manual trigger."
  default     = true
}

variable "ci_trigger_pr_git_name" {
  type        = string
  description = "The name of the PR pipeline GIT trigger."
  default     = "Git PR Trigger"
}
variable "ci_trigger_pr_git_enable" {
  type        = bool
  description = "Set to `true` to enable the PR pipeline Git trigger."
  default     = true
}

variable "ci_trigger_manual_pruner_name" {
  type        = string
  description = "The name of the manual Pruner trigger."
  default     = "Evidence Pruner Manual Trigger"
}
variable "ci_trigger_manual_pruner_enable" {
  type        = bool
  description = "Set to `true` to enable the manual Pruner trigger."
  default     = true
}

variable "ci_trigger_timed_pruner_name" {
  type        = string
  description = "The name of the timed Pruner trigger."
  default     = "Evidence Pruner Timed Trigger"
}
variable "ci_trigger_timed_pruner_enable" {
  type        = bool
  description = "Set to `true` to enable the timed Pruner trigger."
  default     = false
}

######## Deployment Strategy ##################

variable "ci_deployment_target" {
  type        = string
  description = "The deployment target, cluster or code-engine."
  default     = ""
}

######## Code Engine Vars #####################
variable "ci_code_engine_project" {
  type        = string
  description = "The name of the Code Engine project to use for the CI pipeline build. The project is created if it does not already exist."
  default     = "Sample_CI_Project"
}

variable "ci_code_engine_region" {
  type        = string
  description = "The region to create/lookup for the Code Engine project."
  default     = ""
}

variable "ci_code_engine_resource_group" {
  type        = string
  description = "The resource group of the Code Engine project."
  default     = ""
}

variable "ci_code_engine_build_strategy" {
  type        = string
  description = "The build strategy for the Code Engine component. It can be `dockerfile` or `buildpacks`."
  default     = "dockerfile"
}

variable "ci_code_engine_build_use_native_docker" {
  type        = string
  description = "Property to opt-in for using native docker build capabilities as opposed to use Code Engine build to containerize the source. Note this setting only takes effect if the build-strategy is set to `dockerfile`. Valid values are `true` and `false`."
  default     = "false"
}

variable "ci_code_engine_build_size" {
  type        = string
  description = "The size to use for the build, which determines the amount of resources used. Valid values include `small`, `medium`, `large`, `xlarge`."
  default     = "large"
}

variable "ci_code_engine_build_timeout" {
  type        = string
  description = "The amount of time, in seconds, that can pass before the build run must succeed or fail."
  default     = "1200"
}

variable "ci_code_engine_wait_timeout" {
  type        = string
  description = "The maximum timeout for the CLI operation to wait."
  default     = "1300"
}

variable "ci_code_engine_context_dir" {
  type        = string
  description = "The directory in the repository that contains the buildpacks file or the Dockerfile."
  default     = "."
}

variable "ci_code_engine_dockerfile" {
  type        = string
  description = "The path to the `Dockerfile`. Specify this option only if the name is other than `Dockerfile`"
  default     = "Dockerfile"
}

variable "ci_code_engine_image_name" {
  type        = string
  description = "Name of the image that is built."
  default     = "code-engine-compliance-app"
}

variable "ci_code_engine_registry_domain" {
  type        = string
  description = "The container registry URL domain that is used to build and tag the image. Useful when using private-endpoint container registry."
  default     = ""
}

variable "ci_code_engine_source" {
  type        = string
  description = "The path to the location of code to build in the repository. Defaults to the root of source code repository."
  default     = ""
}

variable "ci_code_engine_binding_resource_group" {
  type        = string
  description = "The name of a resource group to use for authentication for the service bindings of the Code Engine project. A service ID is created with Operator and Manager roles for all services in this resource group. Use '*' to specify all resource groups in this account. "
  default     = ""
}

variable "ci_code_engine_deployment_type" {
  type        = string
  description = "type of Code Engine component to create/update as part of deployment. It can be either `application` or `job`."
  default     = "application"
}

variable "ci_code_engine_cpu" {
  type        = string
  description = "The amount of CPU set for the instance of the application or job. "
  default     = "0.25"
}

variable "ci_code_engine_memory" {
  type        = string
  description = "The amount of memory set for the instance of the application or job. Use M for megabytes or G for gigabytes."
  default     = "0.5G"
}

variable "ci_code_engine_ephemeral_storage" {
  type        = string
  description = "The amount of ephemeral storage to set for the instance of the application or for the runs of the job. Use M for megabytes or G for gigabytes."
  default     = "0.4G"
}

variable "ci_code_engine_job_maxexecutiontime" {
  type        = string
  description = "The maximum execution time in seconds for runs of the job."
  default     = "7200"
}

variable "ci_code_engine_job_retrylimit" {
  type        = string
  description = "The number of times to rerun an instance of the job before the job is marked as failed."
  default     = "3"
}

variable "ci_code_engine_job_instances" {
  type        = string
  description = "Specifies the number of instances that are used for runs of the job. When you use this option, the system converts to array indices. For example, if you specify instances of 5, the system converts to array-indices of 0 - 4. This option can only be specified if the --array-indices option is not specified. The default value is 1."
  default     = "1"
}

variable "ci_code_engine_app_port" {
  type        = string
  description = "The port where the application listens. The format is `[NAME:]PORT`, where `[NAME:]` is optional. If `[NAME:]` is specified, valid values are `h2c`, or `http1`. When `[NAME:]` is not specified or is `http1`, the port uses `HTTP/1.1`. When `[NAME:]` is `h2c`, the port uses unencrypted `HTTP/2`."
  default     = "8080"
}

variable "ci_code_engine_app_min_scale" {
  type        = string
  description = "The minimum number of instances that can be used for this application. This option is useful to ensure that no instances are running when not needed."
  default     = "0"
}

variable "ci_code_engine_app_max_scale" {
  type        = string
  description = "The maximum number of instances that can be used for this application. If you set this value to 0, the application scales as needed. The application scaling is limited only by the instances per the resource quota for the project of your application."
  default     = "1"
}

variable "ci_code_engine_app_deployment_timeout" {
  type        = string
  description = "The maximum timeout for the application deployment."
  default     = "300"
}

variable "ci_code_engine_app_concurrency" {
  type        = string
  description = "The maximum number of requests that can be processed concurrently per instance."
  default     = "100"
}

variable "ci_code_engine_app_visibility" {
  type        = string
  description = "The visibility for the application. Valid values are public, private and project. Setting a visibility of public means that your app can receive requests from the public internet or from components within the Code Engine project. Setting a visibility of private means that your app is not accessible from the public internet and network access is only possible from other IBM Cloud using Virtual Private Endpoints (VPE) or Code Engine components that are running in the same project. Visibility can only be private if the project supports application private visibility. Setting a visibility of project means that your app is not accessible from the public internet and network access is only possible from other Code Engine components that are running in the same project."
  default     = "public"
}

#variable "ci_code_engine_CE_ENV_\<XXXX\>" {
#  type        = string
#  description = "Pipeline/trigger property (secured or not) to provide value for code engine environment variable <XXXX>."
#  default     = ""
#}

variable "ci_code_engine_env_from_configmaps" {
  type        = string
  description = "Semi-colon separated list of configmaps to set environment variables."
  default     = ""
}

variable "ci_code_engine_env_from_secrets" {
  type        = string
  description = "Semi-colon separated list of secrets to set environment variables."
  default     = ""
}

variable "ci_code_engine_remove_refs" {
  type        = string
  description = "Remove references to unspecified configuration resources (configmap/secret) references (pulled from env-from-configmaps, env-from-secrets along with auto-managed by CD)."
  default     = "false"
}

variable "ci_code_engine_service_bindings" {
  type        = string
  description = "JSON array including service name(s) (as a simple JSON string."
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

variable "ci_pipeline_ibmcloud_api_key_secret_group" {
  type        = string
  description = "Secret group prefix for the pipeline ibmcloud API key secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "ci_signing_key_secret_group" {
  type        = string
  description = "Secret group prefix for the signing key secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "ci_cos_api_key_secret_group" {
  type        = string
  description = "Secret group prefix for the COS API key secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "ci_slack_webhook_secret_group" {
  type        = string
  description = "Secret group prefix for the Slack webhook secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "ci_pipeline_dockerconfigjson_secret_group" {
  type        = string
  description = "Secret group prefix for the pipeline DockerConfigJson secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "ci_pipeline_git_token_secret_group" {
  type        = string
  description = "Secret group prefix for the pipeline Git token secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "ci_app_repo_secret_group" {
  type        = string
  description = "Secret group prefix for the App repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "ci_issues_repo_secret_group" {
  type        = string
  description = "Secret group prefix for the Issues repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "ci_inventory_repo_secret_group" {
  type        = string
  description = "Secret group prefix for the Inventory repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "ci_evidence_repo_secret_group" {
  type        = string
  description = "Secret group prefix for the Evidence repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "ci_compliance_pipeline_repo_secret_group" {
  type        = string
  description = "Secret group prefix for the Compliance Pipeline repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "ci_pipeline_config_repo_secret_group" {
  type        = string
  description = "Secret group prefix for the Pipeline Config repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "ci_gosec_repo_ssh_key_secret_group" {
  type        = string
  description = "Secret group prefix for the gosec private repository ssh key secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "ci_pipeline_doi_api_key_secret_group" {
  type        = string
  description = "Secret group prefix for the pipeline DOI api key. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
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
  default     = ""
}

######## End Repo auth type ######################

######## Secret Names ###########################

variable "ci_pipeline_ibmcloud_api_key_secret_name" {
  type        = string
  description = "Name of the Cloud API key secret in the secret provider."
  default     = ""
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
  default     = ""
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

variable "ci_pipeline_git_token_secret_name" {
  type        = string
  description = "Name of the pipeline Git token secret in the secret provider."
  default     = "pipeline-git-token"
}

variable "ci_gosec_repo_ssh_key_secret_name" {
  type        = string
  default     = "git-ssh-key"
  description = "Name of the SSH key token for the private repository in the secret provider."
}

variable "ci_pipeline_doi_api_key_secret_name" {
  type        = string
  description = "Name of the Cloud API key secret in the secret provider to access the toolchain containing the Devops Insights instance."
  default     = ""
}

######## End Secret Names #######################

######## CRN Secrets ############################
variable "ci_sm_instance_crn" {
  type        = string
  description = "The CRN of the Secrets Manager instance for the CI toolchain."
  default     = ""
}

variable "ci_app_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the app repository Git Token."
  default     = ""
  validation {
    condition     = startswith(var.ci_app_repo_git_token_secret_crn, "crn:") || var.ci_app_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_issues_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Issues repository Git Token."
  default     = ""
  validation {
    condition     = startswith(var.ci_issues_repo_git_token_secret_crn, "crn:") || var.ci_issues_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_evidence_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Evidence repository Git Token."
  default     = ""
  validation {
    condition     = startswith(var.ci_evidence_repo_git_token_secret_crn, "crn:") || var.ci_evidence_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_inventory_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Inventory repository Git Token."
  default     = ""
  validation {
    condition     = startswith(var.ci_inventory_repo_git_token_secret_crn, "crn:") || var.ci_inventory_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_compliance_pipeline_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Compliance Pipeline repository Git Token."
  default     = ""
  validation {
    condition     = startswith(var.ci_compliance_pipeline_repo_git_token_secret_crn, "crn:") || var.ci_compliance_pipeline_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_pipeline_config_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Pipeline Config repository Git Token."
  default     = ""
  validation {
    condition     = startswith(var.ci_pipeline_config_repo_git_token_secret_crn, "crn:") || var.ci_pipeline_config_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_cos_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Cloud Object Storage apikey."
  default     = ""
  validation {
    condition     = startswith(var.ci_cos_api_key_secret_crn, "crn:") || var.ci_cos_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_pipeline_ibmcloud_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the IBMCloud apikey."
  default     = ""
  validation {
    condition     = startswith(var.ci_pipeline_ibmcloud_api_key_secret_crn, "crn:") || var.ci_pipeline_ibmcloud_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_signing_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for Signing Key secret."
  default     = ""
  validation {
    condition     = startswith(var.ci_signing_key_secret_crn, "crn:") || var.ci_signing_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_pipeline_dockerconfigjson_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for Dockerconfig json secret."
  default     = ""
  validation {
    condition     = startswith(var.ci_pipeline_dockerconfigjson_secret_crn, "crn:") || var.ci_pipeline_dockerconfigjson_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_slack_webhook_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Slack webhook secret."
  default     = ""
  validation {
    condition     = startswith(var.ci_slack_webhook_secret_crn, "crn:") || var.ci_slack_webhook_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_privateworker_credentials_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Private Worker secret secret."
  default     = ""
  validation {
    condition     = startswith(var.ci_privateworker_credentials_secret_crn, "crn:") || var.ci_privateworker_credentials_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_artifactory_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Artifactory secret."
  default     = ""
  validation {
    condition     = startswith(var.ci_artifactory_token_secret_crn, "crn:") || var.ci_artifactory_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_pipeline_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Git Token pipeline property."
  default     = ""
  validation {
    condition     = startswith(var.ci_pipeline_git_token_secret_crn, "crn:") || var.ci_pipeline_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_pipeline_doi_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the pipeline DOI apikey."
  default     = ""
  validation {
    condition     = startswith(var.ci_pipeline_doi_api_key_secret_crn, "crn:") || var.ci_pipeline_doi_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_sonarqube_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the SonarQube secret."
  default     = ""
  validation {
    condition     = startswith(var.ci_sonarqube_secret_crn, "crn:") || var.ci_sonarqube_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_gosec_private_repository_ssh_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the GoSec repository secret."
  default     = ""
  validation {
    condition     = startswith(var.ci_gosec_private_repository_ssh_key_secret_crn, "crn:") || var.ci_gosec_private_repository_ssh_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

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

######SonarQube ############################
variable "ci_sonarqube_config" {
  type        = string
  description = "Runs a SonarQube scan in an isolated Docker-in-Docker container (default configuration) or in an existing Kubernetes cluster (custom configuration). Options: default or custom. Default is default."
  default     = "default"
}

variable "ci_sonarqube_integration_name" {
  type        = string
  description = "The name of the SonarQube integration."
  default     = "SonarQube"
}

variable "ci_sonarqube_user" {
  type        = string
  description = "The name of the SonarQube user."
  default     = ""
}

variable "ci_sonarqube_secret_name" {
  type        = string
  description = "The name of the SonarQube secret."
  default     = "sonarqube-secret"
}

variable "ci_sonarqube_is_blind_connection" {
  type        = string
  description = "When set to `true`, instructs IBM Cloud Continuous Delivery to not validate the configuration of this integration. Set this to true if the SonarQube server is not addressable on the public internet."
  default     = true
}

variable "ci_sonarqube_server_url" {
  type        = string
  description = "The URL to the SonarQube server."
  default     = ""
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

##### EVENT NOTIFICATIONS ################
variable "ci_event_notifications_crn" {
  type        = string
  description = "Set the Event Notifications CRN to create an Events Notification integration."
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

variable "cd_region" {
  type        = string
  description = "IBM Cloud region used to prefix the `prod_latest` inventory repo branch."
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

variable "cd_compliance_pipeline_branch" {
  type        = string
  description = "The CD Pipeline Compliance Pipeline branch."
  default     = ""
}

variable "cd_pipeline_git_tag" {
  type        = string
  description = "The GIT tag within the pipeline definitions repository for the Compliance CD Pipeline."
  default     = ""
}

variable "cd_repositories_prefix" {
  type        = string
  description = "Prefix name for the cloned compliance repos. For the repositories_prefix value only a-z, A-Z and 0-9 and the special characters `-_` are allowed. In addition the string must not end with a special character or have two consecutive special characters."
  default     = ""
  validation {
    condition = (
      ((can(regex("^[0-9A-Za-z\\-\\_]+$", var.cd_repositories_prefix))) && ((endswith(var.cd_repositories_prefix, "-") == false) && (endswith(var.cd_repositories_prefix, "_") == false))
        && (strcontains(var.cd_repositories_prefix, "--") == false) && (strcontains(var.cd_repositories_prefix, "__") == false) && (strcontains(var.cd_repositories_prefix, "_-") == false)
      && (strcontains(var.cd_repositories_prefix, "-_") == false))
      || (length(var.cd_repositories_prefix) == 0)
    )
    error_message = "For the repositories_prefix value only a-z, A-Z and 0-9 and the special characters `-_` are allowed. In addition the string must not end with a special character or have two consecutive special characters."
  }
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

variable "cd_enable_pipeline_notifications" {
  type        = bool
  description = "When enabled, pipeline run events will be sent to the Event Notifications and Slack integrations in the enclosing toolchain."
  default     = false
}

variable "cd_event_notifications" {
  type        = string
  description = "To enable event notification, set event_notifications to 1 "
  default     = "0"
  validation {
    condition     = contains(["0", "1"], var.cd_event_notifications)
    error_message = "Must be either \"0\" or \"1\" ."
  }
}

variable "cd_enable_secrets_manager" {
  description = "Use the Secrets Manager integration."
  type        = bool
  default     = false
}

variable "cd_pipeline_properties" {
  type        = string
  description = "Stringified JSON containing the properties for the CD toolchain pipelines."
  default     = ""
}

variable "cd_pipeline_properties_filepath" {
  type        = string
  description = "The path to the file containing the property JSON. If this is not set, it will by default read the `properties.json` file at the root of the module."
  default     = ""
}

variable "cd_pre_prod_evidence_collection" {
  type        = string
  description = "Set this flag to collect the pre-prod evidences and the change requests in the production deployment (target-environment-purpose set to production). Default value is 0."
  default     = "0"
  validation {
    condition     = contains(["0", "1"], var.cd_pre_prod_evidence_collection)
    error_message = "Must be either \"0\" or \"1\" ."
  }
}

variable "cd_repository_properties" {
  type        = string
  description = "Stringified JSON containing the repositories and triggers that get created in the CI toolchain pipelines."
  default     = ""
}

variable "cd_repository_properties_filepath" {
  type        = string
  description = "The path to the file containing the repository and triggers JSON. If this is not set, it will by default read the `repositories.json` file at the root of the module."
  default     = ""
}

variable "cd_sm_secret_group" {
  type        = string
  description = "Group in Secrets Manager for organizing/grouping secrets."
  default     = ""
}

variable "cd_slack_webhook_secret_group" {
  type        = string
  description = "Secret group prefix for the Slack webhook secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cd_change_management_repo_secret_group" {
  type        = string
  description = "Secret group prefix for the Change Management repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cd_deployment_repo_secret_group" {
  type        = string
  description = "Secret group prefix for the Deployment repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cd_issues_repo_secret_group" {
  type        = string
  description = "Secret group prefix for the Issues repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cd_inventory_repo_secret_group" {
  type        = string
  description = "Secret group prefix for the Inventory repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cd_evidence_repo_secret_group" {
  type        = string
  description = "Secret group prefix for the Evidence repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cd_compliance_pipeline_repo_secret_group" {
  type        = string
  description = "Secret group prefix for the Compliance Pipeline repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cd_pipeline_config_repo_secret_group" {
  type        = string
  description = "Secret group prefix for the Pipeline Config repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cd_cos_api_key_secret_group" {
  type        = string
  description = "Secret group prefix for the COS API key secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cd_pipeline_ibmcloud_api_key_secret_group" {
  type        = string
  description = "Secret group prefix for the pipeline ibmcloud API key secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cd_pipeline_git_token_secret_group" {
  type        = string
  description = "Secret group prefix for the pipeline Git token secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cd_pipeline_doi_api_key_secret_group" {
  type        = string
  description = "Secret group prefix for the pipeline DOI api key. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cd_code_signing_cert_secret_group" {
  type        = string
  description = "Secret group prefix for the pipeline Public signing key cert secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
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
  default     = ""
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
  default     = ""
}

variable "cd_code_signing_cert_secret_name" {
  type        = string
  description = "This is the name of the secret in the secrets provider for storing the code signing certificate."
  default     = "signing-certificate"
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
  default     = ""
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

variable "cd_pipeline_git_token_secret_name" {
  type        = string
  description = "Name of the pipeline Git token secret in the secret provider."
  default     = "pipeline-git-token"
}

variable "cd_pipeline_doi_api_key_secret_name" {
  type        = string
  description = "Name of the Cloud API key secret in the secret provider to access the toolchain containing the Devops Insights instance."
  default     = ""
}

######## End Secret Names #######################

######## CRN secrets ############################
variable "cd_sm_instance_crn" {
  type        = string
  description = "The CRN of the Secrets Manager instance."
  default     = ""
}

variable "cd_code_signing_cert_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the public signing key cert in the secrets provider."
  default     = ""
  validation {
    condition     = startswith(var.cd_code_signing_cert_secret_crn, "crn:") || var.cd_code_signing_cert_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_deployment_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Deployment repository Git Token."
  default     = ""
  validation {
    condition     = startswith(var.cd_deployment_repo_git_token_secret_crn, "crn:") || var.cd_deployment_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_change_management_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Change Management repository Git Token."
  default     = ""
  validation {
    condition     = startswith(var.cd_change_management_repo_git_token_secret_crn, "crn:") || var.cd_change_management_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_issues_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Issues repository Git Token."
  default     = ""
  validation {
    condition     = startswith(var.cd_issues_repo_git_token_secret_crn, "crn:") || var.cd_issues_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_evidence_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Evidence repository Git Token."
  default     = ""
  validation {
    condition     = startswith(var.cd_evidence_repo_git_token_secret_crn, "crn:") || var.cd_evidence_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_inventory_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Inventory repository Git Token."
  default     = ""
  validation {
    condition     = startswith(var.cd_inventory_repo_git_token_secret_crn, "crn:") || var.cd_inventory_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_compliance_pipeline_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Compliance Pipeline repository Git Token."
  default     = ""
  validation {
    condition     = startswith(var.cd_compliance_pipeline_repo_git_token_secret_crn, "crn:") || var.cd_compliance_pipeline_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_pipeline_config_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Config repository Git Token."
  default     = ""
  validation {
    condition     = startswith(var.cd_pipeline_config_repo_git_token_secret_crn, "crn:") || var.cd_pipeline_config_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_cos_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Cloud Object Storage apikey."
  default     = ""
  validation {
    condition     = startswith(var.cd_cos_api_key_secret_crn, "crn:") || var.cd_cos_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_pipeline_ibmcloud_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the pipeline apikey."
  default     = ""
  validation {
    condition     = startswith(var.cd_pipeline_ibmcloud_api_key_secret_crn, "crn:") || var.cd_pipeline_ibmcloud_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_slack_webhook_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Slack webhook secret."
  default     = ""
  validation {
    condition     = startswith(var.cd_slack_webhook_secret_crn, "crn:") || var.cd_slack_webhook_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_privateworker_credentials_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Private Worker apikey."
  default     = ""
  validation {
    condition     = startswith(var.cd_privateworker_credentials_secret_crn, "crn:") || var.cd_privateworker_credentials_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_artifactory_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Artifactory secret."
  default     = ""
  validation {
    condition     = startswith(var.cd_artifactory_token_secret_crn, "crn:") || var.cd_artifactory_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_pipeline_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Git Token secret in the pipeline properties."
  default     = ""
  validation {
    condition     = startswith(var.cd_pipeline_git_token_secret_crn, "crn:") || var.cd_pipeline_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_pipeline_doi_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the DOI apikey."
  default     = ""
  validation {
    condition     = startswith(var.cd_pipeline_doi_api_key_secret_crn, "crn:") || var.cd_pipeline_doi_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

####### Trigger properties ###################
variable "cd_trigger_git_name" {
  type        = string
  description = "The name of the CD pipeline GIT trigger."
  default     = "Git CD Trigger"
}
variable "cd_trigger_git_enable" {
  type        = bool
  description = "Set to `true` to enable the CD pipeline Git trigger."
  default     = false
}

variable "cd_trigger_git_promotion_validation_listener" {
  type        = string
  description = "Select a Tekton EventListener to use when Git promotion validation listener trigger is fired."
  default     = "promotion-validation-listener-gitlab"
}

variable "cd_trigger_git_promotion_validation_enable" {
  type        = bool
  description = "Enable Git promotion validation for Git promotion listener."
  default     = false
}

variable "cd_trigger_git_promotion_validation_branch" {
  type        = string
  description = "Branch for Git promotion validation listener."
  default     = "prod"
}

variable "cd_trigger_git_promotion_validation_name" {
  type        = string
  description = "Name of Git Promotion Validation Trigger"
  default     = "Git Promotion Validation Trigger"
}

variable "cd_trigger_timed_name" {
  type        = string
  description = "The name of the CD pipeline Timed trigger."
  default     = "Git CD Timed Trigger"
}
variable "cd_trigger_timed_enable" {
  type        = bool
  description = "Set to `true` to enable the CD pipeline Timed trigger."
  default     = false
}
variable "cd_trigger_timed_cron_schedule" {
  type        = string
  description = "Only needed for timer triggers. Cron expression that indicates when this trigger will activate. Maximum frequency is every 5 minutes. The string is based on UNIX crontab syntax: minute, hour, day of month, month, day of week. Example: 0 *_/2 * * * - every 2 hours."
  default     = "0 4 * * *"
}

variable "cd_trigger_manual_name" {
  type        = string
  description = "The name of the CI pipeline Manual trigger."
  default     = "Manual CD Trigger"
}
variable "cd_trigger_manual_enable" {
  type        = bool
  description = "Set to `true` to enable the CD pipeline Manual trigger."
  default     = true
}

variable "cd_trigger_manual_promotion_name" {
  type        = string
  description = "The name of the CD pipeline Manual Promotion trigger."
  default     = "Manual Promotion Trigger"
}
variable "cd_trigger_manual_promotion_enable" {
  type        = bool
  description = "Set to `true` to enable the CD pipeline Manual Promotion trigger."
  default     = true
}

variable "cd_trigger_manual_pruner_name" {
  type        = string
  description = "The name of the manual Pruner trigger."
  default     = "Evidence Pruner Manual Trigger"
}

variable "cd_trigger_manual_pruner_enable" {
  type        = bool
  description = "Set to `true` to enable the manual Pruner trigger."
  default     = true
}

variable "cd_trigger_timed_pruner_name" {
  type        = string
  description = "The name of the timed Pruner trigger."
  default     = "Evidence Pruner Timed Trigger"
}
variable "cd_trigger_timed_pruner_enable" {
  type        = bool
  description = "Set to `true` to enable the timed Pruner trigger."
  default     = false
}
######## SCC #####################################


variable "cd_scc_integration_name" {
  type        = string
  description = "The name of the SCC integration."
  default     = "Security and Compliance"
}

variable "cd_scc_enable_scc" {
  type        = bool
  description = "Adds the SCC tool integration to the toolchain."
  default     = true
}

variable "cd_scc_use_profile_attachment" {
  type        = string
  description = "Set to `enabled` to enable use profile with attachment, so that the scripts in the pipeline can interact with the Security and Compliance Center service. When enabled, other parameters become relevant; `scc_scc_api_key_secret_name`, `scc_instance_crn`, `scc_profile_name`, `scc_profile_version`, `scc_attachment_id`."
  default     = ""
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

##### EVENT NOTIFICATIONS ################
variable "cd_event_notifications_crn" {
  type        = string
  description = "Set the Event Notifications CRN to create an Events Notification integration."
  default     = ""
}
#######Code Engine #####################

######## Deployment Strategy ##################

variable "cd_deployment_target" {
  type        = string
  description = "The deployment target, 'cluster' or 'code-engine'."
  default     = ""
}

######## Code Engine Vars #####################
variable "cd_code_engine_project" {
  type        = string
  description = "The name of the Code Engine project to use for the CD pipeline promoted code. The project is created if it does not already exist."
  default     = "Sample_CD_Project"
}

variable "cd_code_engine_region" {
  type        = string
  description = "The region to create/lookup for the Code Engine project."
  default     = ""
}

variable "cd_code_engine_resource_group" {
  type        = string
  description = "The resource group of the Code Engine project."
  default     = ""
}

variable "cd_code_engine_binding_resource_group" {
  type        = string
  description = "The name of a resource group to use for authentication for the service bindings of the Code Engine project. A service ID is created with Operator and Manager roles for all services in this resource group. Use '*' to specify all resource groups in this account. "
  default     = ""
}

variable "cd_code_engine_deployment_type" {
  type        = string
  description = "type of Code Engine component to create/update as part of deployment. It can be either `application` or `job`."
  default     = "application"
}

variable "cd_code_engine_cpu" {
  type        = string
  description = "The amount of CPU set for the instance of the application or job. "
  default     = "0.25"
}

variable "cd_code_engine_memory" {
  type        = string
  description = "The amount of memory set for the instance of the application or job. Use M for megabytes or G for gigabytes."
  default     = "0.5G"
}

variable "cd_code_engine_ephemeral_storage" {
  type        = string
  description = "The amount of ephemeral storage to set for the instance of the application or for the runs of the job. Use M for megabytes or G for gigabytes."
  default     = "0.4G"
}

variable "cd_code_engine_job_maxexecutiontime" {
  type        = string
  description = "The maximum execution time in seconds for runs of the job."
  default     = "7200"
}

variable "cd_code_engine_job_retrylimit" {
  type        = string
  description = "The number of times to rerun an instance of the job before the job is marked as failed."
  default     = "3"
}

variable "cd_code_engine_job_instances" {
  type        = string
  description = "Specifies the number of instances that are used for runs of the job. When you use this option, the system converts to array indices. For example, if you specify instances of 5, the system converts to array-indices of 0 - 4. This option can only be specified if the --array-indices option is not specified. The default value is 1."
  default     = "1"
}

variable "cd_code_engine_app_port" {
  type        = string
  description = "The port where the application listens. The format is `[NAME:]PORT`, where `[NAME:]` is optional. If `[NAME:]` is specified, valid values are `h2c`, or `http1`. When `[NAME:]` is not specified or is `http1`, the port uses `HTTP/1.1`. When `[NAME:]` is `h2c`, the port uses unencrypted `HTTP/2`."
  default     = "8080"
}

variable "cd_code_engine_app_min_scale" {
  type        = string
  description = "The minimum number of instances that can be used for this application. This option is useful to ensure that no instances are running when not needed."
  default     = "0"
}

variable "cd_code_engine_app_max_scale" {
  type        = string
  description = "The maximum number of instances that can be used for this application. If you set this value to 0, the application scales as needed. The application scaling is limited only by the instances per the resource quota for the project of your application."
  default     = "1"
}

variable "cd_code_engine_app_deployment_timeout" {
  type        = string
  description = "The maximum timeout for the application deployment."
  default     = "300"
}

variable "cd_code_engine_app_concurrency" {
  type        = string
  description = "The maximum number of requests that can be processed concurrently per instance."
  default     = "100"
}

variable "cd_code_engine_app_visibility" {
  type        = string
  description = "The visibility for the application. Valid values are public, private and project. Setting a visibility of public means that your app can receive requests from the public internet or from components within the Code Engine project. Setting a visibility of private means that your app is not accessible from the public internet and network access is only possible from other IBM Cloud using Virtual Private Endpoints (VPE) or Code Engine components that are running in the same project. Visibility can only be private if the project supports application private visibility. Setting a visibility of project means that your app is not accessible from the public internet and network access is only possible from other Code Engine components that are running in the same project."
  default     = "public"
}

#variable "cd_code_engine_CE_ENV_\<XXXX\>" {
#  type        = string
#  description = "Pipeline/trigger property (secured or not) to provide value for code engine environment variable <XXXX>."
#  default     = ""
#}

variable "cd_code_engine_env_from_configmaps" {
  type        = string
  description = "Semi-colon separated list of configmaps to set environment variables."
  default     = ""
}

variable "cd_code_engine_env_from_secrets" {
  type        = string
  description = "Semi-colon separated list of secrets to set environment variables."
  default     = ""
}

variable "cd_code_engine_remove_refs" {
  type        = string
  description = "Remove references to unspecified configuration resources (configmap/secret) references (pulled from env-from-configmaps, env-from-secrets along with auto-managed by CD)."
  default     = "false"
}

variable "cd_code_engine_service_bindings" {
  type        = string
  description = "JSON array including service name(s) (as a simple JSON string."
  default     = ""
}


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

variable "cc_gosec_repo_ssh_key_secret_group" {
  type        = string
  description = "Secret group prefix for the gosec private repository ssh key secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cc_sm_secret_group" {
  type        = string
  description = "Group in Secrets Manager for organizing/grouping secrets."
  default     = ""
}

variable "cc_pipeline_ibmcloud_api_key_secret_group" {
  type        = string
  description = "Secret group prefix for the pipeline ibmcloud API key secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cc_cos_api_key_secret_group" {
  type        = string
  description = "Secret group prefix for the COS API key secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cc_slack_webhook_secret_group" {
  type        = string
  description = "Secret group prefix for the Slack webhook secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cc_pipeline_dockerconfigjson_secret_group" {
  type        = string
  description = "Secret group prefix for the pipeline DockerConfigJson secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cc_app_repo_secret_group" {
  type        = string
  description = "Secret group prefix for the App repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cc_issues_repo_secret_group" {
  type        = string
  description = "Secret group prefix for the Issues repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cc_inventory_repo_secret_group" {
  type        = string
  description = "Secret group prefix for the Inventory repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cc_evidence_repo_secret_group" {
  type        = string
  description = "Secret group prefix for the Evidence repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cc_compliance_pipeline_repo_secret_group" {
  type        = string
  description = "Secret group prefix for the Compliance Pipeline repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cc_pipeline_config_repo_secret_group" {
  type        = string
  description = "Secret group prefix for the Pipeline Config repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cc_pipeline_doi_api_key_secret_group" {
  type        = string
  description = "Secret group prefix for the pipeline DOI api key. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`."
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
  default     = ""
}

######## End Repo auth type ######################

######## Secret Names ###########################

variable "cc_pipeline_ibmcloud_api_key_secret_name" {
  type        = string
  description = "Name of the Cloud API key secret in the secret provider."
  default     = ""
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
  default     = ""
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

variable "cc_gosec_repo_ssh_key_secret_name" {
  type        = string
  default     = "git-ssh-key"
  description = "Name of the SSH key token for the private repository in the secret provider."
}

variable "cc_pipeline_doi_api_key_secret_name" {
  type        = string
  description = "Name of the Cloud API key secret in the secret provider to access the toolchain containing the Devops Insights instance."
  default     = ""
}

######## End Secret Names #######################
######## CRN secrets ############################
variable "cc_sm_instance_crn" {
  type        = string
  description = "The CRN of the Secrets Manager instance."
  default     = ""
}

variable "cc_app_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the app repository Git Token."
  default     = ""
  validation {
    condition     = startswith(var.cc_app_repo_git_token_secret_crn, "crn:") || var.cc_app_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_issues_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Issues repository Git Token."
  default     = ""
  validation {
    condition     = startswith(var.cc_issues_repo_git_token_secret_crn, "crn:") || var.cc_issues_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_evidence_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Evidence repository Git Token."
  default     = ""
  validation {
    condition     = startswith(var.cc_evidence_repo_git_token_secret_crn, "crn:") || var.cc_evidence_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_inventory_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Inventory repository Git Token."
  default     = ""
  validation {
    condition     = startswith(var.cc_inventory_repo_git_token_secret_crn, "crn:") || var.cc_inventory_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_compliance_pipeline_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Compliance Pipeline repository Git Token."
  default     = ""
  validation {
    condition     = startswith(var.cc_compliance_pipeline_repo_git_token_secret_crn, "crn:") || var.cc_compliance_pipeline_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_pipeline_config_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Pipeline Config repository Git Token."
  default     = ""
  validation {
    condition     = startswith(var.cc_pipeline_config_repo_git_token_secret_crn, "crn:") || var.cc_pipeline_config_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_cos_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Cloud Object Storage apikey."
  default     = ""
  validation {
    condition     = startswith(var.cc_cos_api_key_secret_crn, "crn:") || var.cc_cos_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_pipeline_ibmcloud_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the IBMCloud apikey."
  default     = ""
  validation {
    condition     = startswith(var.cc_pipeline_ibmcloud_api_key_secret_crn, "crn:") || var.cc_pipeline_ibmcloud_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_pipeline_dockerconfigjson_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Dockerconfig json secret."
  default     = ""
  validation {
    condition     = startswith(var.cc_pipeline_dockerconfigjson_secret_crn, "crn:") || var.cc_pipeline_dockerconfigjson_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_slack_webhook_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for Slack webhook secret."
  default     = ""
  validation {
    condition     = startswith(var.cc_slack_webhook_secret_crn, "crn:") || var.cc_slack_webhook_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_artifactory_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Artifactory secret."
  default     = ""
  validation {
    condition     = startswith(var.cc_artifactory_token_secret_crn, "crn:") || var.cc_artifactory_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_pipeline_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for pipeline Git token property."
  default     = ""
  validation {
    condition     = startswith(var.cc_pipeline_git_token_secret_crn, "crn:") || var.cc_pipeline_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_sonarqube_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the SonarQube secret."
  default     = ""
  validation {
    condition     = startswith(var.cc_sonarqube_secret_crn, "crn:") || var.cc_sonarqube_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_pipeline_doi_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the pipeline DOI apikey."
  default     = ""
  validation {
    condition     = startswith(var.cc_pipeline_doi_api_key_secret_crn, "crn:") || var.cc_pipeline_doi_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_gosec_private_repository_ssh_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Deployment repository Git Token."
  default     = ""
  validation {
    condition     = startswith(var.cc_gosec_private_repository_ssh_key_secret_crn, "crn:") || var.cc_gosec_private_repository_ssh_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

######## End Secret Names #######################

#########Trigger Properties ##########
variable "cc_trigger_timed_name" {
  type        = string
  description = "The name of the CC pipeline Timed trigger."
  default     = "CC Timed Trigger"
}
variable "cc_trigger_timed_enable" {
  type        = bool
  description = "Set to `true` to enable the CI pipeline Timed trigger."
  default     = false
}
variable "cc_trigger_timed_cron_schedule" {
  type        = string
  description = "Only needed for timer triggers. Cron expression that indicates when this trigger will activate. Maximum frequency is every 5 minutes. The string is based on UNIX crontab syntax: minute, hour, day of month, month, day of week. Example: 0 *_/2 * * * - every 2 hours."
  default     = "0 4 * * *"
}

variable "cc_trigger_manual_name" {
  type        = string
  description = "The name of the CC pipeline Manual trigger."
  default     = "CC Manual Trigger"
}
variable "cc_trigger_manual_enable" {
  type        = bool
  description = "Set to `true` to enable the CC pipeline Manual trigger."
  default     = true
}

variable "cc_trigger_manual_pruner_name" {
  type        = string
  description = "The name of the manual Pruner trigger."
  default     = "Evidence Pruner Manual Trigger"
}
variable "cc_trigger_manual_pruner_enable" {
  type        = bool
  description = "Set to `true` to enable the manual Pruner trigger."
  default     = true
}

variable "cc_trigger_timed_pruner_name" {
  type        = string
  description = "The name of the timed Pruner trigger."
  default     = "Evidence Pruner Timed Trigger"
}
variable "cc_trigger_timed_pruner_enable" {
  type        = bool
  description = "Set to `true` to enable the timed Pruner trigger."
  default     = false
}

######## SCC #####################################

variable "cc_scc_integration_name" {
  type        = string
  description = "The name of the SCC integration."
  default     = "Security and Compliance"
}

variable "cc_scc_enable_scc" {
  type        = bool
  description = "Adds the SCC tool integration to the toolchain."
  default     = true
}

variable "cc_scc_use_profile_attachment" {
  type        = string
  description = "Set to `enabled` to enable use profile with attachment, so that the scripts in the pipeline can interact with the Security and Compliance Center service. When enabled, other parameters become relevant; `scc_scc_api_key_secret_name`, `scc_instance_crn`, `scc_profile_name`, `scc_profile_version`, `scc_attachment_id`."
  default     = ""
}

######## End SCC ################################

variable "cc_slack_notifications" {
  type        = string
  description = "The switch that turns the Slack notification on (`1`) or off (`0`)."
  default     = ""
}

######SonarQube ############################
variable "cc_sonarqube_integration_name" {
  type        = string
  description = "The name of the SonarQube integration."
  default     = "SonarQube"
}

variable "cc_sonarqube_user" {
  type        = string
  description = "The name of the SonarQube user."
  default     = ""
}

variable "cc_sonarqube_secret_name" {
  type        = string
  description = "The name of the SonarQube secret."
  default     = "sonarqube-secret"
}

variable "cc_sonarqube_is_blind_connection" {
  type        = string
  description = "When set to `true`, instructs IBM Cloud Continuous Delivery to not validate the configuration of this integration. Set this to true if the SonarQube server is not addressable on the public internet."
  default     = true
}

variable "cc_sonarqube_server_url" {
  type        = string
  description = "The URL to the SonarQube server."
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
  description = "The prefix for the compliance repositories. For the repositories_prefix value only a-z, A-Z and 0-9 and the special characters `-_` are allowed. In addition the string must not end with a special character or have two consecutive special characters."
  default     = ""
  validation {
    condition = (
      ((can(regex("^[0-9A-Za-z\\-\\_]+$", var.cc_repositories_prefix))) && ((endswith(var.cc_repositories_prefix, "-") == false) && (endswith(var.cc_repositories_prefix, "_") == false))
        && (strcontains(var.cc_repositories_prefix, "--") == false) && (strcontains(var.cc_repositories_prefix, "__") == false) && (strcontains(var.cc_repositories_prefix, "_-") == false)
      && (strcontains(var.cc_repositories_prefix, "-_") == false))
      || (length(var.cc_repositories_prefix) == 0)
    )
    error_message = "For the repositories_prefix value only a-z, A-Z and 0-9 and the special characters `-_` are allowed. In addition the string must not end with a special character or have two consecutive special characters."
  }
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

variable "cc_compliance_pipeline_branch" {
  type        = string
  description = "The CC Pipeline Compliance Pipeline branch."
  default     = ""
}

variable "cc_cra_bom_generate" {
  type        = string
  description = "Set this flag to `1` to generate cra bom"
  default     = "1"
  validation {
    condition     = contains(["0", "1"], var.cc_cra_bom_generate)
    error_message = "Must be either \"0\" or \"1\" ."
  }
}

variable "cc_cra_vulnerability_scan" {
  type        = string
  description = "Set this flag to `1` and `cra-bom-generate` to `1` for cra vulnerability scan.  If this value is set to 1 and `cra-bom-generate` is set to 0, the scan will be marked as `failure`"
  default     = "1"
  validation {
    condition     = contains(["0", "1"], var.cc_cra_vulnerability_scan)
    error_message = "Must be either \"0\" or \"1\" ."
  }

}

variable "cc_cra_deploy_analysis" {
  type        = string
  description = "Set this flag to `1` for cra deployment analysis to be done."
  default     = "1"
  validation {
    condition     = contains(["0", "1"], var.cc_cra_deploy_analysis)
    error_message = "Must be either \"0\" or \"1\" ."
  }
}

variable "cc_enable_pipeline_notifications" {
  type        = bool
  description = "When enabled, pipeline run events will be sent to the Event Notifications and Slack integrations in the enclosing toolchain."
  default     = false
}

variable "cc_event_notifications" {
  type        = string
  description = "To enable event notification, set event_notifications to 1 "
  default     = "0"
  validation {
    condition     = contains(["0", "1"], var.cc_event_notifications)
    error_message = "Must be either \"0\" or \"1\" ."
  }
}

variable "cc_pipeline_git_tag" {
  type        = string
  description = "The GIT tag within the pipeline definitions repository for the Compliance CC Pipeline."
  default     = ""
}

variable "cc_pipeline_debug" {
  type        = string
  description = "'0' by default. Set to '1' to enable debug logging."
  default     = "0"
}

variable "cc_pipeline_properties" {
  type        = string
  description = "Stringified JSON containing the properties for the CC toolchain pipelines."
  default     = ""
}

variable "cc_pipeline_properties_filepath" {
  type        = string
  description = "The path to the file containing the property JSON. If this is not set, it will by default read the `properties.json` file at the root of the module."
  default     = ""
}

variable "cc_repository_properties" {
  type        = string
  description = "Stringified JSON containing the repositories and triggers that get created in the CI toolchain pipelines."
  default     = ""
}

variable "cc_repository_properties_filepath" {
  type        = string
  description = "The path to the file containing the repository and triggers JSON. If this is not set, it will by default read the `repositories.json` file at the root of the module."
  default     = ""
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

variable "cc_opt_in_gosec" {
  type        = string
  description = "Enables gosec scans"
  default     = ""
}

variable "cc_gosec_private_repository_host" {
  type        = string
  description = "Your private repository base URL."
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
  default     = ""
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

########## AUTO REMEDIATION #################

variable "cc_opt_in_cra_auto_remediation" {
  type        = bool
  description = "Enables auto-remediation for your pipeline. Set to `true` to enable."
  default     = false
}

variable "cc_opt_in_cra_auto_remediation_force" {
  type        = bool
  description = "Forces a major package update as part of the pull request that is opened."
  default     = false
}

variable "cc_opt_in_cra_auto_remediation_enabled_repos" {
  type        = string
  description = "Specifies specific repos where you want to enable auto-remediation."
  default     = ""
}

##### EVENT NOTIFICATIONS ################
variable "cc_event_notifications_crn" {
  type        = string
  description = "Set the Event Notifications CRN to create an Events Notification integration."
  default     = ""
}

##### END OF CC VARIABLES ################

###### CD  Instance ######################
variable "create_cd_instance" {
  type        = bool
  description = "Set to `true` to create Continuous Delivery Service."
  default     = false
}

variable "cd_instance_name" {
  type        = string
  description = "The name of the CD instance."
  default     = "cd-devsecops"
}

variable "cd_service_plan" {
  type        = string
  description = "The Continuous Delivery service plan. Can be `lite` or `professional`."
  default     = "professional"
}

###### PRE REQS #########################

variable "create_sm_secret_group" {
  type        = bool
  description = "Set to `true` to create a secrets group in Secrets Manager."
  default     = false
}

variable "create_ibmcloud_api_key" {
  type        = bool
  description = "Set to `true` to create and add an `ibmcloud-api-key` to the Secrets Provider."
  default     = false
}

variable "create_cos_api_key" {
  type        = bool
  description = "Set to `true` to create and add a `cos-api-key` to the Secrets Provider."
  default     = false
}

variable "create_signing_key" {
  type        = bool
  description = "Set to `true` to create and add a `signing_key`to the Secrets Provider."
  default     = false
}

variable "create_signing_certificate" {
  type        = bool
  description = "Set to `true` to create and add the `signing-certificate` to the Secrets Provider."
  default     = false
}

variable "create_icr_namespace" {
  type        = bool
  description = "Set to `true` to create the namespace."
  default     = false
}

variable "add_container_name_suffix" {
  type        = bool
  description = "Set to `true` to add a random suffix to the specified ICR name."
  default     = false
}
