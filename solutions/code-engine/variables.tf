##############################################################################
# Input Variables
##############################################################################
##### START OF COMMON VARIABLES ##########


variable "add_code_engine_prefix" {
  type        = bool
  description = "Set to `true` to use `prefix` to add a prefix to the code engine project names."
  default     = true
}

variable "add_container_name_suffix" {
  type        = bool
  description = "Set to `true` to add a random suffix to the specified ICR name."
  default     = false
}

variable "app_group" {
  type        = string
  description = "Specify the Git user or group for the application repository."
  default     = ""
}

variable "app_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are 'oauth' or 'pat'. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = ""
}

variable "app_repo_branch" {
  type        = string
  description = "This is the repository branch used by the default sample application. Alternatively if `app_repo_existing_url` is provided, then the branch must reflect the default branch for that repository. Typically these branches are `main` or `master`."
  default     = "main"
}

variable "app_repo_clone_from_url" {
  type        = string
  description = "Override the default sample app by providing your own sample app URL, which is cloned into the app repository. Note, uses `clone_if_not_exists` mode, so if the app repository already exists the repository contents are unchanged."
  default     = ""
}

variable "app_repo_clone_to_git_id" {
  type        = string
  description = "Set this value to `github` for github.com, or to the GUID of a custom GitHub Enterprise server."
  default     = ""
}

variable "app_repo_clone_to_git_provider" {
  type        = string
  description = "By default this gets set as 'hostedgit', else set to 'githubconsolidated' for GitHub repositories."
  default     = ""
}

variable "app_repo_existing_git_id" {
  type        = string
  description = "Set this value to `github` for github.com, or to the GUID of a custom GitHub Enterprise server."
  default     = ""
}

variable "app_repo_existing_git_provider" {
  type        = string
  description = "By default this gets set as 'hostedgit', else set to 'githubconsolidated' for GitHub repositories."
  default     = ""
}

variable "app_repo_existing_url" {
  type        = string
  description = "Bring your own existing application repository by providing the URL. This will create an integration for your application repository instead of cloning the default sample. Repositories existing in a different org will require the use of Git token. See `app_repo_git_token_secret_name` under optional variables. "
  default     = "__NOTSET__"
}

variable "app_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider used for accessing the sample (or bring your own) application repository."
  default     = ""
}

variable "app_repo_secret_group" {
  type        = string
  description = "Secret group for the App repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "app_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Git token used for accessing the sample application repository."
  default     = ""
  validation {
    condition     = startswith(var.app_repo_git_token_secret_crn, "crn:") || var.app_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "authorization_policy_creation" {
  type        = string
  description = "Disable Toolchain Service to Secrets Manager/Key Protect/Notifications Service authorization policy creation. To disable set the value to `disabled`. This applies to the CI, CD, and CC toolchains. To set independently, see `ci_authorization_policy_creation`, `cd_authorization_policy_creation`, and `cc_authorization_policy_creation`."
  default     = ""
}

variable "autostart" {
  type        = bool
  description = "Set to `true` to auto run the CI pipeline in the CI toolchain after creation."
  default     = false
}

variable "cluster_name" {
  type        = string
  description = "Name of the Kubernetes cluster where the application is deployed. This sets the same cluster name for both CI and CD toolchains. See `ci_cluster_name` and `cd_cluster_name` to set different cluster names. By default , the cluster namespace for CI will be set to `dev` and CD to `prod`. These can be changed using `ci_cluster_namespace` and `cd_cluster_namespace`."
  default     = "mycluster-free"
}

variable "code_engine_project" {
  type        = string
  description = "The name of the Code Engine project to use. Created if it does not exist. Applies to both the CI and CD toolchains. To set individually use `ci_code_engine_project` and `cd_code_engine_project`."
  default     = ""
}

variable "compliance_pipeline_branch" {
  type        = string
  description = "The Compliance Pipeline definitions branch. See `ci_compliance_pipeline_branch`, `cd_compliance_pipeline_branch` and `cc_compliance_pipeline_branch` to set independently."
  default     = "open-v10"
}

variable "compliance_pipeline_existing_repo_url" {
  type        = string
  default     = ""
  description = "The URL of an existing compliance pipelines repository."
}

variable "compliance_pipeline_group" {
  type        = string
  description = "Specify user or group for compliance pipline repository."
  default     = ""
}

variable "compliance_pipeline_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are 'oauth' or 'pat'. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = ""
}

variable "compliance_pipeline_repo_git_id" {
  type        = string
  description = "Set this value to `github` for github.com, or to the ID of a custom GitHub Enterprise server."
  default     = ""
}

variable "compliance_pipeline_repo_blind_connection" {
  type        = bool
  description = "Setting this value to `true` means the server is not addressable on the public internet. IBM Cloud will not be able to validate the connection details you provide. Certain functionality that requires API access to the git server will be disabled. Delivery pipeline will only work using a private worker that has network access to the git server."
  default     = false
}

variable "compliance_pipeline_repo_name" {
  type        = string
  description = "Sets the name for the compliance pipelines repository if cloned. The expected behaviour is to link to an existing compliance-pipelines repository."
  default     = ""
}

variable "compliance_pipeline_repo_root_url" {
  type        = string
  description = "(Optional) The Root URL of the server. e.g. https://git.example.com."
  default     = ""
}

variable "compliance_pipeline_repo_use_group_settings" {
  type        = bool
  description = "Set to `true` to apply group level repository settings to the compliance pipeline repository. See `repo_git_provider` as an example."
  default     = true
}

variable "compliance_pipeline_repo_title" {
  type        = string
  description = "(Optional) The title of the server. e.g. My Git Enterprise Server."
  default     = ""
}

variable "compliance_pipeline_repo_git_provider" {
  type        = string
  default     = ""
  description = "Git provider for pipeline repo"
  validation {
    condition     = contains(["hostedgit", "githubconsolidated", "gitlab", ""], var.compliance_pipeline_repo_git_provider)
    error_message = "Must be either \"hostedgit\" or \"gitlab\" or \"githubconsolidated\" for pipeline repo."
  }
}

variable "compliance_pipeline_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Git token used for accessing the sample application repository."
  default     = ""
  validation {
    condition     = startswith(var.compliance_pipeline_repo_git_token_secret_crn, "crn:") || var.compliance_pipeline_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "compliance_pipeline_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider used for accessing the compliance pipelines repository."
  default     = ""
}

variable "compliance_pipeline_repo_secret_group" {
  type        = string
  description = "Secret group for the Compliance Pipeline repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "compliance_pipeline_source_repo_url" {
  type        = string
  default     = ""
  description = "The URL of a compliance pipelines repository to clone."
}

variable "cos_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Cloud Object Storage apikey. Applies to the CI, CD and CC toolchains. Can beset independently using `ci_cos_api_key_secret_crn`,`cd_cos_api_key_secret_crn`,`cc_cos_api_key_secret_crn`."
  default     = ""
  validation {
    condition     = startswith(var.cos_api_key_secret_crn, "crn:") || var.cos_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cos_api_key_secret_group" {
  type        = string
  description = "Secret group for the COS api key secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cos_api_key_secret_name" {
  type        = string
  description = "Name of the Cloud Object Storage API key secret in the secret provider for accessing the evidence COS bucket. In addition `cos_endpoint` and `cos_bucket_name` must be set. This setting sets the same API key for the COS settings in the CI, CD, and CC toolchains."
  default     = ""
}

variable "cos_api_key_secret_value" {
  type        = string
  description = "A user provided api key with COS access permissions that can be pushed to Secrets Manager. See `cos_api_key_secret_name` and `create_cos_api_key`."
  sensitive   = true
  default     = ""
}

variable "cos_bucket_name" {
  type        = string
  description = "Set the name of your COS bucket. This applies the same COS bucket name for the CI, CD, and CC toolchains. See `ci_cos_bucket_name`, `cd_cos_bucket_name`, and `cc_cos_bucket_name` to set separately."
  default     = ""
}

variable "cos_endpoint" {
  type        = string
  description = "The endpoint for the Cloud Object Stroage instance containing the evidence bucket. This setting sets the same endpoint for COS in the CI, CD, and CC toolchains. See `ci_cos_endpoint`, `cd_cos_endpoint`, and `cc_cos_endpoint` to set the endpoints independently."
  default     = ""
}

variable "create_cc_toolchain" {
  description = "Boolean flag which determines if the DevSecOps CC toolchain is created."
  type        = bool
  default     = true
}

variable "create_cd_instance" {
  type        = bool
  description = "Set to `true` to create Continuous Delivery Service."
  default     = false
}

variable "create_cd_toolchain" {
  description = "Boolean flag which determines if the DevSecOps CD toolchain is created."
  type        = bool
  default     = true
}

variable "create_code_engine_access_policy" {
  type        = bool
  description = "Add a Code Engine access policy to the generated IAM access key. See `create_ibmcloud_api_key`."
  default     = true
}

variable "create_ci_toolchain" {
  description = "Flag which determines if the DevSecOps CI toolchain is created. If this toolchain is not created then values must be set for the following variables, evidence_repo_url, issues_repo_url and inventory_repo_url."
  type        = bool
  default     = true
}

variable "create_cos_api_key" {
  type        = bool
  description = "Set to `true` to create and add a `cos-api-key` to the Secrets Provider."
  default     = false
}

variable "create_git_token" {
  type        = bool
  description = "Set to `true` to create and add the specified personal access token secret to the Secrets Provider. Use `repo_git_token_secret_value` for setting the value."
  default     = false
}

variable "create_ibmcloud_api_key" {
  type        = bool
  description = "Set to `true` to create and add an `ibmcloud-api-key` to the Secrets Provider."
  default     = false
}

variable "create_icr_namespace" {
  type        = bool
  description = "Set to `true` to have Terraform create the registry namespace. Setting to `false` will have the CI pipeline create the namespace if it does not already exist. Note: If a Terraform destroy is used, the ICR namespace along with all images will be removed."
  default     = false
}

variable "create_kubernetes_access_policy" {
  type        = bool
  description = "Add a Kubernetes access policy to the generated IAM access key. See `create_ibmcloud_api_key`."
  default     = false
}

variable "create_privateworker_secret" {
  type        = bool
  description = "Set to `true` to add a specified private worker service api key to the Secrets Provider. This also enables a private worker tool integration in the toolchains."
  default     = false
}

variable "create_secret_group" {
  type        = bool
  description = "Set to `true` to create the specified Secrets Manager secret group."
  default     = false
}

variable "create_signing_key" {
  type        = bool
  description = "Set to `true` to create and add a `signing-key` and the `signing-certificate` to the Secrets Provider."
  default     = false
}

variable "create_triggers" {
  type        = string
  description = "Set to `true` to create the default triggers associated with the compliance repos and sample app."
  default     = "true"
}

variable "enable_key_protect" {
  type        = string
  description = "Set to `true` to the enable Key Protect integrations."
  default     = "false"
}

variable "enable_pipeline_notifications" {
  type        = string
  description = "When enabled, pipeline run events will be sent to the Event Notifications and Slack integrations in the enclosing toolchain."
  default     = ""
}

variable "enable_privateworker" {
  type        = string
  default     = "false"
  description = "Set to `true` to enable private workers for the CI, CD, CC and PR pipelines. A valid service api key must be set in Secrets Manager. The name of this secret can be specified using `privateworker_credentials_secret_name`."
}

variable "enable_secrets_manager" {
  description = "Set to `true` to enable the Secrets Manager integrations."
  type        = string
  default     = "true"
}

variable "enable_slack" {
  type        = string
  description = "Set to `true` to create the Slack toolchain integration. This requires a valid `slack_channel_name`, `slack_team_name`, and a valid `webhook` (see `slack_webhook_secret_name`). This setting applies for CI, CD, and CC toolchains."
  default     = "false"
}

variable "environment_prefix" {
  type        = string
  description = "By default `ibm:yp:`. This will be set as the prefix to regions automatically where required. For example `ibm:yp:us-south`."
  default     = "ibm:yp:"
}

variable "environment_tag" {
  type        = string
  description = "Tag name that represents the target environment in the inventory. Example: prod_latest."
  default     = "prod_latest"
}

variable "event_notifications_crn" {
  type        = string
  description = "Set the Event Notifications CRN to create an Events Notification integration. This paramater will apply to the CI, CD and CC toolchains. Can be set independently with `ci_event_notifications_crn`, `cd_event_notifications_crn`, `cc_event_notifications_crn`."
  default     = ""
}

variable "event_notifications_tool_name" {
  type        = string
  description = "The name of the Event Notifications integration."
  default     = "Event Notifications"
}

variable "evidence_group" {
  type        = string
  description = "Specify the Git user or group for the evidence repository."
  default     = ""
}

variable "evidence_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are 'oauth' or 'pat'. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = ""
}

variable "evidence_repo_existing_git_id" {
  type        = string
  description = "Set this value to `github` for github.com, or to the GUID of a custom GitHub Enterprise server."
  default     = ""
}

variable "evidence_repo_existing_git_provider" {
  type        = string
  default     = ""
  description = "Git provider for evidence repo. If not set will default to `hostedgit`."
  validation {
    condition     = contains(["hostedgit", "githubconsolidated", "gitlab", ""], var.evidence_repo_existing_git_provider)
    error_message = "Must be either \"hostedgit\" or \"gitlab\" or \"githubconsolidated\" for evidence repository."
  }
}

variable "evidence_repo_existing_url" {
  type        = string
  description = "Set to use an existing evidence repository."
  default     = ""
}

variable "evidence_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Git token used for accessing the Evidence repository."
  default     = ""
  validation {
    condition     = startswith(var.evidence_repo_git_token_secret_crn, "crn:") || var.evidence_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "evidence_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider used for accessing the evidence repository."
  default     = ""
}

variable "evidence_repo_integration_owner" {
  type        = string
  description = "The name of the repository integration owner."
  default     = ""
}

variable "evidence_repo_name" {
  type        = string
  description = "Set to use a custom name for the Evidence repository."
  default     = ""
}

variable "evidence_repo_secret_group" {
  type        = string
  description = "Secret group for the Evidence repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "force_create_standard_api_key" {
  type        = bool
  description = "Set to `true` to force create a standard api key. By default the generated apikey will be a service api key. It is recommended to use a Git Token when using the service api key. In the case where the user has been invited to an account and that user not the account owner, during toolchain creation the default compliance repositories will be created in that user's account and the service api will not have access to those repositories. In this case a Git Token for the repositories is required. See `repo_git_token_secret_name` for more details. The alternative is to set `force_create_standard_api_key` to `true` to create a standard api key."
  default     = false
}

variable "ibmcloud_api_key" {
  type        = string
  description = "The API key used to create the toolchains. (See deployment guide.)"
  sensitive   = true
}

variable "inventory_group" {
  type        = string
  description = "Specify the Git user or group for the inventory repository."
  default     = ""
}

variable "inventory_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are 'oauth' or 'pat'. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = ""
}

variable "inventory_repo_existing_git_id" {
  type        = string
  description = "Set this value to `github` for github.com, or to the GUID of a custom GitHub Enterprise server."
  default     = ""
}

variable "inventory_repo_existing_git_provider" {
  type        = string
  default     = ""
  description = "Git provider for the inventory repo. If not set will default to `hostedgit`."
  validation {
    condition     = contains(["hostedgit", "githubconsolidated", "gitlab", ""], var.inventory_repo_existing_git_provider)
    error_message = "Must be either \"hostedgit\" or \"gitlab\" or \"githubconsolidated\" for Inventory repository."
  }
}

variable "inventory_repo_existing_url" {
  type        = string
  description = "Set to use an existing inventory repository."
  default     = ""
}

variable "inventory_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Git token used for acessing the Inventory repository."
  default     = ""
  validation {
    condition     = startswith(var.inventory_repo_git_token_secret_crn, "crn:") || var.inventory_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "inventory_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider used for accessing the inventory repository."
  default     = ""
}

variable "inventory_repo_integration_owner" {
  type        = string
  description = "The name of the repository integration owner."
  default     = ""
}

variable "inventory_repo_name" {
  type        = string
  description = "Set to use a custom name for the Inventory repository."
  default     = ""
}

variable "inventory_repo_secret_group" {
  type        = string
  description = "Secret group for the Inventory repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "issues_group" {
  type        = string
  description = "Specify the Git user or group for the issues repository."
  default     = ""
}

variable "issues_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are 'oauth' or 'pat'. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = ""
}

variable "issues_repo_existing_git_id" {
  type        = string
  description = "Set this value to `github` for github.com, or to the GUID of a custom GitHub Enterprise server."
  default     = ""
}

variable "issues_repo_existing_git_provider" {
  type        = string
  default     = ""
  description = "Git provider for the issues repo. If not set will default to `hostedgit`."
  validation {
    condition     = contains(["hostedgit", "githubconsolidated", "gitlab", ""], var.issues_repo_existing_git_provider)
    error_message = "Must be either \"hostedgit\" or \"gitlab\" or \"githubconsolidated\" for issue repository."
  }
}

variable "issues_repo_existing_url" {
  type        = string
  description = "By default this gets set as 'hostedgit', else set to 'githubconsolidated' for GitHub repositories."
  default     = ""
}

variable "issues_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Git token used for accessing the Issues repository."
  default     = ""
  validation {
    condition     = startswith(var.issues_repo_git_token_secret_crn, "crn:") || var.issues_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "issues_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider used for accessing the issues repository."
  default     = ""
}

variable "issues_repo_integration_owner" {
  type        = string
  description = "The name of the repository integration owner."
  default     = ""
}

variable "issues_repo_name" {
  type        = string
  description = "Set to use a custom name for the Issues repository."
  default     = ""
}

variable "issues_repo_secret_group" {
  type        = string
  description = "Secret group for the Issues repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "kp_integration_name" {
  type        = string
  description = "The name of the Key Protect integration."
  default     = "kp-compliance-secrets"
}

variable "kp_location" {
  type        = string
  description = "The region hosting the Key Protect instance. This applies to the CI, CD and CC Key Protect integrations. See `ci_kp_location`, `cd_kp_location`, and `cc_kp_location` to set these values ."
  default     = "us-south"
}

variable "kp_name" {
  type        = string
  description = "Name of the Key Protect instance where the secrets are stored. This applies to the CI, CD and CC Key Protect integrations. See `ci_kp_name`, `cd_kp_name`, and `cc_kp_name` to set these values independently."
  default     = "kp-compliance-secrets"
}

variable "kp_resource_group" {
  type        = string
  description = "The resource group containing the Key Protect instance. This applies to the CI, CD and CC Key Protect integrations. See `ci_kp_resource_group`, `cd_kp_resource_group`, and `cc_kp_resource_group` to set these values independently."
  default     = "Default"
}

variable "pipeline_config_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are 'oauth' or 'pat'. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = ""
}

variable "pipeline_config_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Git token for accessing the pipeline config repository."
  default     = ""
  validation {
    condition     = startswith(var.pipeline_config_repo_git_token_secret_crn, "crn:") || var.pipeline_config_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "pipeline_config_repo_existing_url" {
  type        = string
  description = "Specify and link to an existing repository containing a custom pipeline-config.yaml file."
  default     = ""
}

variable "pipeline_config_repo_clone_from_url" {
  type        = string
  description = "Specify a repository containing a custom pipeline-config.yaml file."
  default     = ""
}

variable "pipeline_config_repo_branch" {
  type        = string
  description = "Specify the branch containing the custom pipeline-config.yaml file."
  default     = ""
}

variable "pipeline_ibmcloud_api_key_secret_group" {
  type        = string
  description = "Secret group for the pipeline ibmcloud API key secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "pipeline_config_group" {
  type        = string
  description = "Specify the Git user or group for the compliance pipeline repository."
  default     = ""
}

variable "pipeline_config_repo_git_id" {
  type        = string
  description = "Set this value to `github` for github.com, or to the GUID of a custom GitHub Enterprise server."
  default     = ""
}

variable "pipeline_config_repo_git_provider" {
  type        = string
  default     = ""
  description = "Git provider for pipeline repo config"
  validation {
    condition     = contains(["hostedgit", "githubconsolidated", "gitlab", ""], var.pipeline_config_repo_git_provider)
    error_message = "Must be either \"hostedgit\" or \"gitlab\" or \"githubconsolidated\" for pipeline config repo."
  }
}

variable "pipeline_config_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider used for accessing the pipeline config repository."
  default     = ""
}

variable "pipeline_config_repo_secret_group" {
  type        = string
  description = "Secret group for the Pipeline Config repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "pipeline_doi_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the DOI (DevOps Insights) apikey used for accessing a specific toolchain Insights instance. Applies to the CI, CD and CC toolchains."
  default     = ""
  validation {
    condition     = startswith(var.pipeline_doi_api_key_secret_crn, "crn:") || var.pipeline_doi_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "pipeline_doi_api_key_secret_group" {
  type        = string
  description = "Secret group for the pipeline DOI api key. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`. Applies to the CI, CD and CC toolchains."
  default     = ""
}

variable "pipeline_doi_api_key_secret_name" {
  type        = string
  description = "Name of the Cloud API key secret in the secret provider to access the toolchain containing the Devops Insights instance. This will apply to the CI, CD and CC toolchains."
  default     = ""
}

variable "pipeline_git_tag" {
  type        = string
  description = "The GIT tag selector for the Compliance Pipelines definitions."
  default     = ""
}

variable "pipeline_ibmcloud_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the IBMCloud apikey used for running the pipelines."
  default     = ""
  validation {
    condition     = startswith(var.pipeline_ibmcloud_api_key_secret_crn, "crn:") || var.pipeline_ibmcloud_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "pipeline_ibmcloud_api_key_secret_name" {
  type        = string
  description = "Name of the Cloud API key secret in the secret provider for running the pipelines. Applies to the CI, CD and CC toolchains."
  default     = "ibmcloud-api-key"
}

variable "pipeline_ibmcloud_api_key_secret_value" {
  type        = string
  description = "A user provided api key for running the toolchain pipelines that can be pushed to Secrets Manager. See `pipeline_ibmcloud_api_key_secret_name` and `create_ibmcloud_api_key`."
  sensitive   = true
  default     = ""
}

variable "privateworker_credentials_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Private Worker secret secret."
  default     = ""
  validation {
    condition     = startswith(var.privateworker_credentials_secret_crn, "crn:") || var.privateworker_credentials_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "privateworker_credentials_secret_group" {
  type        = string
  description = "Secret group prefix for the Private Worker secret. Defaults to using `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "privateworker_credentials_secret_name" {
  type        = string
  default     = ""
  description = "Name of the privateworker secret in the secret provider."
}

variable "privateworker_name" {
  type        = string
  description = "The name of the private worker tool integration."
  default     = "private-worker-tool-01"
}

variable "privateworker_secret_value" {
  type        = string
  sensitive   = true
  description = "The private worker service api key that will be added to the `privateworker_credentials_secret_name` secret in the secrets provider."
  default     = ""
}

variable "pr_pipeline_git_tag" {
  type        = string
  description = "The GIT tag selector for the Compliance Pipelines definitions."
  default     = ""
}

variable "prefix" {
  type        = string
  description = "A prefix that is added to the toolchain resources."
  default     = ""
}

variable "registry_namespace" {
  type        = string
  description = "A unique namespace within the IBM Cloud Container Registry region where the application image is stored."
  default     = ""
}

variable "repo_apply_settings_to_compliance_repos" {
  type        = bool
  description = "Set to `true` to apply the same settings to all the default compliance repositories. Set to `false` to apply these settings to only the sample application, pipeline config and the deployment repositories."
  default     = true
}

variable "repo_blind_connection" {
  type        = bool
  description = "Setting this value to `true` means the server is not addressable on the public internet. IBM Cloud will not be able to validate the connection details you provide. Certain functionality that requires API access to the git server will be disabled. Delivery pipeline will only work using a private worker that has network access to the git server."
  default     = false
}

variable "repo_git_id" {
  type        = string
  description = "The Git ID for the compliance repositories."
  default     = ""
}

variable "repo_git_provider" {
  type        = string
  description = "The Git provider type."
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

variable "repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider. Specifying a secret name for the Git Token automatically sets the authentication type to `pat`."
  default     = ""
}

variable "repo_git_token_secret_value" {
  type        = string
  sensitive   = true
  description = "The personal access token that will be added to the `repo_git_token_secret_name` secret in the secrets provider."
  default     = ""
}

variable "repo_group" {
  type        = string
  description = "Specify the Git user or group for your application. This must be set if the repository authentication type is `pat` (personal access token)."
  default     = ""
}

variable "repo_secret_group" {
  type        = string
  description = "Secret group in Secrets Manager that contains the secret for the repository. This variable will set the same secret group for all the repositories. Can be overriden on a per secret group basis. Only applies when using Secrets Manager."
  default     = ""
}

variable "repo_root_url" {
  type        = string
  description = "(Optional) The Root URL of the server. e.g. https://git.example.com."
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

variable "repo_title" {
  type        = string
  description = "(Optional) The title of the server. e.g. My Git Enterprise Server."
  default     = ""
}

variable "rotation_period" {
  type        = number
  description = "The number of days until the `ibmcloud-api-key` and the `cos-api-key` are auto rotated."
  default     = 90
}

variable "rotate_signing_key" {
  type        = bool
  description = "Set to `true` to rotate the signing key and signing certificate. It is important to make a back up for the current code signing certificate as pending CD deployments might require image validation against the previous signing key."
  default     = false
}

variable "scc_attachment_id" {
  type        = string
  description = "An attachment ID. An attachment is configured under a profile to define how a scan will be run. To find the attachment ID, in the browser, in the attachments list, click on the attachment link, and a panel appears with a button to copy the attachment ID. This parameter is only relevant when the `scc_use_profile_attachment` parameter is enabled."
  default     = ""
}

variable "scc_enable_scc" {
  type        = string
  description = "Adds the SCC tool integration to the toolchain."
  default     = "true"
}

variable "scc_instance_crn" {
  type        = string
  description = "The Security and Compliance Center service instance CRN (Cloud Resource Name). This parameter is only relevant when the `scc_use_profile_attachment` parameter is enabled."
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

variable "scc_scc_api_key_secret_group" {
  type        = string
  description = "Secret group for the Security and Compliance tool secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "scc_scc_api_key_secret_name" {
  type        = string
  description = "The name of the Security and Compliance Center api-key secret in the secret provider."
  default     = "scc-api-key"
}

variable "scc_use_profile_attachment" {
  type        = string
  description = "Set to `enabled` to enable use profile with attachment, so that the scripts in the pipeline can interact with the Security and Compliance Center service. When enabled, other parameters become relevant; `scc_scc_api_key_secret_name`, `scc_instance_crn`, `scc_profile_name`, `scc_profile_version`, `scc_attachment_id`. Can individually be `enabled` and `disabled` in the CD and CC toolchains using `cd_scc_use_profile_attachment` and `cc_scc_use_profile_attachment`."
  default     = "disabled"
}

variable "slack_channel_name" {
  type        = string
  description = "The name of the Slack channel where notifications are posted. This applies to the CI, CD, and CC toolchains. To set independently see `ci_slack_channel_name`, `cd_slack_channel_name`, and `cc_slack_channel_name`."
  default     = ""
}

variable "slack_integration_name" {
  type        = string
  description = "The name of the Slack integration."
  default     = "slack-compliance"
}

variable "slack_team_name" {
  type        = string
  description = "The Slack team name, which is the word or phrase before `.slack.com` in the team URL. This applies to the CI, CD, and CC toolchains. To set independently, see `ci_slack_team_name`, `cd_slack_team_name`, and `cc_slack_team_name`."
  default     = ""
}

variable "slack_webhook_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Slack webhook secret used for accessing the specified Slack channel."
  default     = ""
  validation {
    condition     = startswith(var.slack_webhook_secret_crn, "crn:") || var.slack_webhook_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "slack_webhook_secret_group" {
  type        = string
  description = "Secret group for the Slack webhook secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "slack_webhook_secret_name" {
  type        = string
  description = "Name of the webhook secret in the secret provider used for accessing the configured Slack channel. This applies to the CI, CD, and CC toolchains. To set independently, see `ci_slack_webhook_secret_name`, `cd_slack_webhook_secret_name`, and `cc_slack_webhook_secret_name`."
  default     = "slack-webhook"
}

variable "sm_endpoint_type" {
  type        = string
  description = "The types of service endpoints to target for Secrets Manager. Valid values are `private` and `public`."
  default     = "private"
}

variable "sm_instance_crn" {
  type        = string
  description = "The CRN of the Secrets Manager instance. Will apply to CI, CD and CC toolchains unless set individually. Setting up the Secrets Manager integration using a CRN takes precendence over the non CRN setup."
  default     = ""
}

variable "sm_integration_name" {
  type        = string
  description = "The name of the Secrets Manager integration."
  default     = "sm-compliance-secrets"
}

variable "sm_location" {
  type        = string
  description = "The region hosting the Secrets Manager instance. This applies to the CI, CD and CC Secret Manager integrations."
  default     = "us-south"
}

variable "sm_name" {
  type        = string
  description = "The name of an existing Secret Managers instance. This applies to the CI, CD and CC Secret Manager integrations."
  default     = "sm-instance"
}

variable "sm_resource_group" {
  type        = string
  description = "The name of the existing resource group containing the Secrets Manager instance for your secrets.. This applies to the CI, CD and CC Secret Manager integrations."
  default     = "Default"
}

variable "sm_secret_expiration_period" {
  type        = string
  description = "The number of days until the secrets expire. Leave empty to not set an expiration for the created secrets."
  default     = ""
}

variable "sm_secret_group" {
  type        = string
  description = "The Secrets Manager secret group containing the secrets for the DevSecOps pipelines. This applies to the CI, CD and CC Secret Manager integrations."
  default     = "Default"
}

variable "sonarqube_integration_name" {
  type        = string
  description = "The name of the SonarQube integration."
  default     = "SonarQube"
}

variable "sonarqube_is_blind_connection" {
  type        = string
  description = "When set to `true`, instructs IBM Cloud Continuous Delivery to not validate the configuration of this integration. Set this to `true` if the SonarQube server is not addressable on the public internet."
  default     = "true"
}

variable "sonarqube_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the secret used to access SonarQube."
  default     = ""
  validation {
    condition     = startswith(var.sonarqube_secret_crn, "crn:") || var.sonarqube_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "sonarqube_secret_group" {
  type        = string
  description = "Secret group for the SonarQube secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "sonarqube_secret_name" {
  type        = string
  description = "The name of the SonarQube secret in the secrets provider."
  default     = "sonarqube-secret"
}

variable "sonarqube_server_url" {
  type        = string
  description = "The URL to the SonarQube server."
  default     = ""
}

variable "sonarqube_user" {
  type        = string
  description = "The name of the SonarQube user."
  default     = ""
}

variable "toolchain_name" {
  type        = string
  description = "This variable specifies the root name for the CI, CD and CC toolchain names. A fixed suffix will automatically be appended. Setting `DevSecOps` will generate toolchains with the names `DevSecOps-CI-Toolchain`,  `DevSecOps-CD-Toolchain` and `DevSecOps-CC-Toolchain`. The full name of each toolchain can be set independently using `ci_toolchain_name`, `cd_toolchain_name`, and `cc_toolchain_name`."
  default     = "DevSecOps"
}

variable "toolchain_region" {
  type        = string
  description = "The region identifier that will be used, by default, for all resource creation and service instance lookup. This can be overridden on a per resource/service basis."
  default     = "us-south"
}

variable "toolchain_resource_group" {
  type        = string
  description = "The resource group that will be used, by default, for all resource creation and service instance lookups. This can be overridden on a per resource/service basis."
  default     = "Default"
}

variable "worker_id" {
  type        = string
  default     = "public"
  description = "The identifier for the pipeline worker. Applies to the CI, CD and CC pipelines."
}

########################################################
##### START OF CC VARIABLES ##############
########################################################

variable "cc_app_group" {
  type        = string
  description = "Specify user or group for app repository."
  default     = ""
}

variable "cc_app_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are 'oauth' or 'pat'. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = ""
}

variable "cc_app_repo_branch" {
  type        = string
  description = "The default branch of the app repository."
  default     = ""
}

variable "cc_app_repo_git_id" {
  type        = string
  description = "The Git Id of the repository."
  default     = ""
}

variable "cc_app_repo_git_provider" {
  type        = string
  description = "Git provider for the application repo. If not set will default to `hostedgit`."
  default     = ""
  validation {
    condition     = contains(["hostedgit", "githubconsolidated", "gitlab", ""], var.cc_app_repo_git_provider)
    error_message = "Must be either \"hostedgit\" or \"gitlab\" or \"githubconsolidated\" for evidence repository."
  }
}

variable "cc_app_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Git token used for accessing the application repository."
  default     = ""
  validation {
    condition     = startswith(var.cc_app_repo_git_token_secret_crn, "crn:") || var.cc_app_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_app_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider used for accessing the sample (or bring your own) application repository."
  default     = ""
}

variable "cc_app_repo_secret_group" {
  type        = string
  description = "Secret group for the App repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cc_app_repo_url" {
  type        = string
  description = "This Git URL for the application repository."
  default     = ""
}

variable "cc_artifactory_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Artifactory access secret."
  default     = ""
  validation {
    condition     = startswith(var.cc_artifactory_token_secret_crn, "crn:") || var.cc_artifactory_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_authorization_policy_creation" {
  type        = string
  description = "Disable Toolchain Service to Secrets Manager/Key Protect/Notifications Service authorization policy creation. To disable set the value to `disabled`."
  default     = ""
}

variable "cc_compliance_pipeline_branch" {
  type        = string
  description = "The CC Pipeline Compliance Pipeline branch."
  default     = ""
}

variable "cc_compliance_pipeline_group" {
  type        = string
  description = "Specify user or group for compliance pipline repository."
  default     = ""
}

variable "cc_compliance_pipeline_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are 'oauth' or 'pat'. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = ""
}

variable "cc_compliance_pipeline_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Git token used for accessing the Compliance Pipelines repository."
  default     = ""
  validation {
    condition     = startswith(var.cc_compliance_pipeline_repo_git_token_secret_crn, "crn:") || var.cc_compliance_pipeline_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_compliance_pipeline_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider used for accessing the compliance pipelines repository."
  default     = ""
}

variable "cc_compliance_pipeline_repo_secret_group" {
  type        = string
  description = "Secret group for the Compliance Pipeline repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cc_cos_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Cloud Object Storage apikey."
  default     = ""
  validation {
    condition     = startswith(var.cc_cos_api_key_secret_crn, "crn:") || var.cc_cos_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_cos_api_key_secret_group" {
  type        = string
  description = "Secret group for the COS API key secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cc_cos_api_key_secret_name" {
  type        = string
  description = "Name of the Cloud Object Storage API key secret in the secret provider used for accessing the evidence COS bucket."
  default     = ""
}

variable "cc_cos_bucket_name" {
  type        = string
  description = "The name of the Cloud Object Storage bucket used for storing the evidence."
  default     = ""
}

variable "cc_cos_endpoint" {
  type        = string
  description = "The endpoint for the Cloud Object Stroage instance containing the evidence bucket."
  default     = ""
}

variable "cc_doi_toolchain_id" {
  type        = string
  description = "The ID of the toolchain containing the DevOps Insights integration. This variable is used to link the DevOps Insights toolcard to a specific instance."
  default     = ""
}

variable "cc_enable_key_protect" {
  description = "Set to `true` to the enable Key Protect integrations."
  type        = string
  default     = ""
}

variable "cc_enable_pipeline_notifications" {
  type        = string
  description = "When enabled, pipeline run events will be sent to the Event Notifications and Slack integrations in the enclosing toolchain."
  default     = ""
}

variable "cc_enable_secrets_manager" {
  description = "Set to `true` to enable the Secrets Manager integrations."
  type        = string
  default     = ""
}

variable "cc_enable_slack" {
  type        = string
  description = "Set to `true` to create the Slack toolchain integration."
  default     = ""
}

variable "cc_event_notifications_crn" {
  type        = string
  description = "Set the Event Notifications CRN to create an Events Notification integration."
  default     = ""
}

variable "cc_evidence_group" {
  type        = string
  description = "Specify the Git user or group for the evidence repository."
  default     = ""
}

variable "cc_evidence_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'"
  default     = ""
}

variable "cc_evidence_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Git token used for accessing the Evidence repository."
  default     = ""
  validation {
    condition     = startswith(var.cc_evidence_repo_git_token_secret_crn, "crn:") || var.cc_evidence_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_evidence_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider used for accessing the evidence repository."
  default     = ""
}

variable "cc_evidence_repo_secret_group" {
  type        = string
  description = "Secret group for the Evidence repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cc_inventory_group" {
  type        = string
  description = "Specify the Git user or group for the inventory repository."
  default     = ""
}

variable "cc_inventory_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are 'oauth' or 'pat'. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = ""
}

variable "cc_inventory_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Git token used for acessing the Inventory repository."
  default     = ""
  validation {
    condition     = startswith(var.cc_inventory_repo_git_token_secret_crn, "crn:") || var.cc_inventory_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_inventory_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider used for accessing the inventory repository."
  default     = ""
}

variable "cc_inventory_repo_secret_group" {
  type        = string
  description = "Secret group for the Inventory repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cc_issues_group" {
  type        = string
  description = "Specify the Git user or group for the issues repository."
  default     = ""
}

variable "cc_issues_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are 'oauth' or 'pat'. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = ""
}

variable "cc_issues_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Git token used for accessing the Issues repository."
  default     = ""
  validation {
    condition     = startswith(var.cc_issues_repo_git_token_secret_crn, "crn:") || var.cc_issues_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_issues_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider used for accessing the issues repository."
  default     = ""
}

variable "cc_issues_repo_secret_group" {
  type        = string
  description = "Secret group for the Issues repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cc_kp_location" {
  type        = string
  description = "The region hosting the Key Protect instance."
  default     = ""
}

variable "cc_kp_name" {
  type        = string
  description = "Name of the Key Protect instance where the secrets are stored."
  default     = ""
}

variable "cc_kp_resource_group" {
  type        = string
  description = "The resource group containing the Key Protect instance."
  default     = ""
}

variable "cc_link_to_doi_toolchain" {
  description = "Enable a link to a DevOps Insights instance in another toolchain, true or false."
  type        = bool
  default     = true
}

variable "cc_pipeline_config_group" {
  type        = string
  description = "Specify the Git user or group for the compliance pipeline repository."
  default     = ""
}

variable "cc_pipeline_config_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are 'oauth' or 'pat'. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = ""
}

variable "cc_pipeline_config_repo_branch" {
  type        = string
  description = "Specify the branch containing the custom pipeline-config.yaml file."
  default     = ""
}

variable "cc_pipeline_config_repo_clone_from_url" {
  type        = string
  description = "Specify a repository containing a custom pipeline-config.yaml file."
  default     = ""
}

variable "cc_pipeline_config_repo_existing_url" {
  type        = string
  description = "Specify a repository containing a custom pipeline-config.yaml file."
  default     = ""
}

variable "cc_pipeline_config_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Git token for accessing the pipeline config repository."
  default     = ""
  validation {
    condition     = startswith(var.cc_pipeline_config_repo_git_token_secret_crn, "crn:") || var.cc_pipeline_config_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_pipeline_config_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider used for accessing the pipeline config repository."
  default     = ""
}

variable "cc_pipeline_config_repo_secret_group" {
  type        = string
  description = "Secret group for the Pipeline Config repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cc_pipeline_doi_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the DOI (DevOps Insights) apikey used for accessing a specific toolchain Insights instance."
  default     = ""
  validation {
    condition     = startswith(var.cc_pipeline_doi_api_key_secret_crn, "crn:") || var.cc_pipeline_doi_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_pipeline_doi_api_key_secret_group" {
  type        = string
  description = "Secret group for the pipeline DOI api key. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cc_pipeline_doi_api_key_secret_name" {
  type        = string
  description = "Name of the Cloud API key secret in the secret provider to access the toolchain containing the Devops Insights instance."
  default     = ""
}

variable "cc_pipeline_git_tag" {
  type        = string
  description = "The GIT tag selector for the Compliance Pipelines definitions."
  default     = ""
}

variable "cc_pipeline_ibmcloud_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the IBMCloud apikey used for running the pipelines."
  default     = ""
  validation {
    condition     = startswith(var.cc_pipeline_ibmcloud_api_key_secret_crn, "crn:") || var.cc_pipeline_ibmcloud_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_pipeline_ibmcloud_api_key_secret_group" {
  type        = string
  description = "Secret group for the pipeline ibmcloud API key secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cc_pipeline_ibmcloud_api_key_secret_name" {
  type        = string
  description = "Name of the Cloud API key secret in the secret provider for running the pipelines."
  default     = ""
}

variable "cc_pipeline_properties_filepath" {
  type        = string
  description = "The path to the file containing the property JSON. If this is not set, it will by default read the `properties.json` file at the root of the module."
  default     = ""
}

variable "cc_pipeline_properties" {
  type        = string
  description = "This JSON represents the pipeline properties belonging to the CC pipeline in the CC toolchain. Each element in the JSON represents a seperate pipeline property. Three attributes are required to create a property. These are the `name` field (how the name appears in the pipeline properties), the `type` (text, secure and enum) and then the `value`. Do not put secrets directly into JSON for the `secure` type, instead the value for a `secret` type should be a CRN to a secret in the configured secrets provider or a secret reference to a secret in the configured secrets provider."
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

variable "cc_repository_properties_filepath" {
  type        = string
  description = "The path to the file containing the repository and triggers JSON. If this is not set, it will by default read the `repositories.json` file at the root of the module."
  default     = ""
}

variable "cc_repository_properties" {
  type        = string
  description = "Stringified JSON containing the repositories and triggers that get created in the CI toolchain pipelines."
  default     = ""
}

variable "cc_scc_enable_scc" {
  type        = string
  description = "Adds the SCC tool integration to the toolchain."
  default     = ""
}

variable "cc_scc_integration_name" {
  type        = string
  description = "The name of the SCC integration."
  default     = "Security and Compliance"
}

variable "cc_scc_use_profile_attachment" {
  type        = string
  description = "Set to `enabled` to enable use profile with attachment, so that the scripts in the pipeline can interact with the Security and Compliance Center service. When enabled, other parameters become relevant; `scc_scc_api_key_secret_name`, `scc_instance_crn`, `scc_profile_name`, `scc_profile_version`, `scc_attachment_id`."
  default     = ""
}

variable "cc_slack_channel_name" {
  type        = string
  description = "The name of the Slack channel where notifications are posted."
  default     = ""
}

variable "cc_slack_pipeline_fail" {
  type        = bool
  description = "Set to `true` to generate pipeline failed notifications."
  default     = true
}

variable "cc_slack_pipeline_start" {
  type        = bool
  description = "Set to `true` to generate pipeline start notifications."
  default     = true
}

variable "cc_slack_pipeline_success" {
  type        = bool
  description = "Set to `true` to generate pipeline succeeded notifications."
  default     = true
}

variable "cc_slack_team_name" {
  type        = string
  description = "The Slack team name, which is the word or phrase before .slack.com in the team URL."
  default     = ""
}

variable "cc_slack_toolchain_bind" {
  type        = bool
  description = "Generate tool added to toolchain notifications."
  default     = true
}

variable "cc_slack_toolchain_unbind" {
  type        = bool
  description = "Set to `true` to generate tool removed from toolchain notifications."
  default     = true
}

variable "cc_slack_webhook_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Slack webhook secret used for accessing the specified Slack channel."
  default     = ""
  validation {
    condition     = startswith(var.cc_slack_webhook_secret_crn, "crn:") || var.cc_slack_webhook_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_slack_webhook_secret_group" {
  type        = string
  description = "Secret group for the Slack webhook secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cc_slack_webhook_secret_name" {
  type        = string
  description = "Name of the webhook secret in the secret provider used for accessing the configured Slack channel."
  default     = ""
}

variable "cc_sm_instance_crn" {
  type        = string
  description = "The CRN of the Secrets Manager instance."
  default     = ""
}

variable "cc_sm_location" {
  type        = string
  description = "The region hosting the Secrets Manager instance."
  default     = ""
}

variable "cc_sm_name" {
  type        = string
  description = "The name of an existing Secrets Manager instance where the secrets are stored."
  default     = ""
}

variable "cc_sm_resource_group" {
  type        = string
  description = "The name of the existing resource group containing the Secrets Manager instance for your secrets."
  default     = ""
}

variable "cc_sm_secret_group" {
  type        = string
  description = "The Secrets Manager secret group containing the secrets for the DevSecOps pipelines."
  default     = ""
}

variable "cc_sonarqube_integration_name" {
  type        = string
  description = "The name of the SonarQube integration."
  default     = ""
}

variable "cc_sonarqube_is_blind_connection" {
  type        = string
  description = "When set to `true`, instructs IBM Cloud Continuous Delivery to not validate the configuration of this integration. Set this to `true` if the SonarQube server is not addressable on the public internet."
  default     = ""
}

variable "cc_sonarqube_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the secret used to access SonarQube."
  default     = ""
  validation {
    condition     = startswith(var.cc_sonarqube_secret_crn, "crn:") || var.cc_sonarqube_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cc_sonarqube_secret_group" {
  type        = string
  description = "Secret group for the SonarQube secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cc_sonarqube_secret_name" {
  type        = string
  description = "The name of the SonarQube secret in the secrets provider."
  default     = ""
}

variable "cc_sonarqube_server_url" {
  type        = string
  description = "The URL to the SonarQube server."
  default     = ""
}

variable "cc_sonarqube_user" {
  type        = string
  description = "The name of the SonarQube user."
  default     = ""
}

variable "cc_toolchain_description" {
  type        = string
  description = "Description for the CC Toolchain."
  default     = "Toolchain created with terraform template for DevSecOps CC Best Practices."
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

variable "cc_toolchain_resource_group" {
  type        = string
  description = "Resource group within which the toolchain is created."
  default     = ""
}

variable "cc_trigger_manual_enable" {
  type        = bool
  description = "Set to `true` to enable the CC pipeline Manual trigger."
  default     = true
}

variable "cc_trigger_manual_name" {
  type        = string
  description = "The name of the CC pipeline Manual trigger."
  default     = "CC Manual Trigger"
}

variable "cc_trigger_manual_pruner_enable" {
  type        = bool
  description = "Set to `true` to enable the manual Pruner trigger."
  default     = true
}

variable "cc_trigger_manual_pruner_name" {
  type        = string
  description = "The name of the manual Pruner trigger."
  default     = "Evidence Pruner Manual Trigger"
}

variable "cc_trigger_timed_cron_schedule" {
  type        = string
  description = "Only needed for timer triggers. Cron expression that indicates when this trigger will activate. Maximum frequency is every 5 minutes. The string is based on UNIX crontab syntax: minute, hour, day of month, month, day of week. Example: 0 *_/2 * * * - every 2 hours."
  default     = "0 4 * * *"
}

variable "cc_trigger_timed_enable" {
  type        = bool
  description = "Set to `true` to enable the CI pipeline Timed trigger."
  default     = false
}

variable "cc_trigger_timed_name" {
  type        = string
  description = "The name of the CC pipeline Timed trigger."
  default     = "CC Timed Trigger"
}

variable "cc_trigger_timed_pruner_enable" {
  type        = bool
  description = "Set to `true` to enable the timed Pruner trigger."
  default     = false
}

variable "cc_trigger_timed_pruner_name" {
  type        = string
  description = "The name of the timed Pruner trigger."
  default     = "Evidence Pruner Timed Trigger"
}

########################################################
##### START OF CD VARIABLES ##############
########################################################

variable "cd_artifactory_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Artifactory access secret."
  default     = ""
  validation {
    condition     = startswith(var.cd_artifactory_token_secret_crn, "crn:") || var.cd_artifactory_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_authorization_policy_creation" {
  type        = string
  description = "Disable Toolchain Service to Secrets Manager/Key Protect/Notifications Service authorization policy creation. To disable set the value to `disabled`."
  default     = ""
}

variable "cd_change_management_group" {
  type        = string
  description = "Specify group for change management repository"
  default     = ""
}

variable "cd_change_management_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are 'oauth' or 'pat'. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = ""
}

variable "change_management_existing_url" {
  type        = string
  description = "The URL for an existing Change Management repository."
  default     = ""
}

variable "change_management_repo_git_id" {
  type        = string
  description = "Set this value to `github` for github.com, or to the ID of a custom GitHub Enterprise server."
  default     = ""
}

variable "cd_change_management_repo_git_provider" {
  type        = string
  default     = ""
  description = "By default this gets set as 'hostedgit', else set to 'githubconsolidated' for GitHub repositories."
  validation {
    condition     = contains(["hostedgit", "githubconsolidated", "gitlab", ""], var.cd_change_management_repo_git_provider)
    error_message = "Must be either \"hostedgit\" or \"gitlab\" or \"githubconsolidated\" for evidence repository."
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

variable "cd_change_management_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider."
  default     = ""
}

variable "cd_change_management_repo_secret_group" {
  type        = string
  description = "Secret group for the Change Management repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cd_change_repo_clone_from_url" {
  type        = string
  description = "Override the default management repository, which is cloned into the application repository. Note, using clone_if_not_exists mode, so if the application repository already exists the repository contents are unchanged."
  default     = ""
}

variable "cd_cluster_name" {
  type        = string
  description = "Name of the cluster where the application is deployed."
  default     = ""
}

variable "cd_cluster_namespace" {
  type        = string
  description = "Name of the cluster namespace where the application is deployed."
  default     = "prod"
}

variable "cd_cluster_region" {
  type        = string
  description = "Region hosting the cluster where the application is deployed. Use the short form of the regions. For example `us-south`."
  default     = ""
}

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

variable "cd_code_signing_cert_secret_name" {
  type        = string
  description = "This is the name of the secret in the secrets provider for storing the code signing certificate."
  default     = "signing-certificate"
}

variable "cd_compliance_pipeline_branch" {
  type        = string
  description = "The CD Pipeline Compliance Pipeline branch."
  default     = ""
}

variable "cd_compliance_pipeline_group" {
  type        = string
  description = "Specify user or group for compliance pipline repository."
  default     = ""
}

variable "cd_compliance_pipeline_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are 'oauth' or 'pat'. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = ""
}

variable "cd_compliance_pipeline_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Git token used for accessing the Compliance Pipelines repository."
  default     = ""
  validation {
    condition     = startswith(var.cd_compliance_pipeline_repo_git_token_secret_crn, "crn:") || var.cd_compliance_pipeline_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_compliance_pipeline_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider used for accessing the compliance pipelines repository."
  default     = ""
}

variable "cd_compliance_pipeline_repo_secret_group" {
  type        = string
  description = "Secret group for the Compliance Pipeline repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cd_cos_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Cloud Object Storage apikey."
  default     = ""
  validation {
    condition     = startswith(var.cd_cos_api_key_secret_crn, "crn:") || var.cd_cos_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_cos_api_key_secret_group" {
  type        = string
  description = "Secret group for the COS API key secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cd_cos_api_key_secret_name" {
  type        = string
  description = "Name of the Cloud Object Storage API key secret in the secret provider used for accessing the evidence COS bucket."
  default     = ""
}

variable "cd_cos_bucket_name" {
  type        = string
  description = "The name of the Cloud Object Storage bucket used for storing the evidence."
  default     = ""
}

variable "cd_cos_endpoint" {
  type        = string
  description = "The endpoint for the Cloud Object Stroage instance containing the evidence bucket."
  default     = ""
}

variable "cd_deployment_group" {
  type        = string
  description = "Specify group for deployment."
  default     = ""
}

variable "cd_deployment_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are 'oauth' or 'pat'. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = ""
}

variable "cd_deployment_repo_clone_from_branch" {
  type        = string
  description = "Used when deployment_repo_clone_from_url is provided, the default branch that is used by the CD build, usually either main or master."
  default     = ""
}

variable "cd_deployment_repo_clone_from_url" {
  type        = string
  description = "Override the default sample app by providing your own sample deployment URL, which is cloned into the app repository. Note, using clone_if_not_exists mode, so if the app repository already exists the repository contents are unchanged."
  default     = ""
}

variable "cd_deployment_repo_clone_to_git_id" {
  type        = string
  description = "By default absent, else custom server GUID, or other options for 'git_id' field in the browser UI."
  default     = ""
}

variable "cd_deployment_repo_clone_to_git_provider" {
  type        = string
  description = "By default 'hostedgit', else use 'githubconsolidated' or 'gitlab'."
  default     = ""
}

variable "cd_deployment_repo_existing_branch" {
  type        = string
  description = "Used when deployment_repo_existing_url is provided, the default branch that is by the CD build, usually either main or master."
  default     = ""
}

variable "cd_deployment_repo_existing_git_id" {
  type        = string
  description = "Set this value to `github` for github.com, or to the GUID of a custom GitHub Enterprise server."
  default     = ""
}

variable "cd_deployment_repo_existing_git_provider" {
  type        = string
  description = "Git provider for the deployment repo. If not set will default to `hostedgit`."
  default     = ""
  validation {
    condition     = contains(["hostedgit", "githubconsolidated", "gitlab", ""], var.cd_deployment_repo_existing_git_provider)
    error_message = "Must be either \"hostedgit\" or \"gitlab\" or \"githubconsolidated\" for evidence repository."
  }
}

variable "cd_deployment_repo_existing_url" {
  type        = string
  description = "Override to bring your own existing deployment repository URL, which is used directly instead of cloning the default deployment sample."
  default     = ""
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

variable "cd_deployment_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider."
  default     = ""
}

variable "cd_deployment_repo_secret_group" {
  type        = string
  description = "Secret group for the Deployment repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cd_doi_toolchain_id" {
  type        = string
  description = "The ID of the toolchain containing the DevOps Insights integration. This variable is used to link the DevOps Insights toolcard to a specific instance."
  default     = ""
}

variable "cd_enable_key_protect" {
  description = "Set to `true` to the enable Key Protect integrations."
  type        = string
  default     = ""
}

variable "cd_enable_pipeline_notifications" {
  type        = string
  description = "When enabled, pipeline run events will be sent to the Event Notifications and Slack integrations in the enclosing toolchain."
  default     = ""
}

variable "cd_enable_secrets_manager" {
  description = "Set to `true` to enable the Secrets Manager integrations."
  type        = string
  default     = ""
}

variable "cd_enable_slack" {
  type        = string
  description = "Set to `true` to create the Slack toolchain integration."
  default     = ""
}

variable "cd_event_notifications_crn" {
  type        = string
  description = "Set the Event Notifications CRN to create an Events Notification integration."
  default     = ""
}

variable "cd_evidence_group" {
  type        = string
  description = "Specify the Git user or group for the evidence repository."
  default     = ""
}

variable "cd_evidence_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are 'oauth' or 'pat'. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = ""
}

variable "cd_evidence_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Git token used for accessing the Evidence repository."
  default     = ""
  validation {
    condition     = startswith(var.cd_evidence_repo_git_token_secret_crn, "crn:") || var.cd_evidence_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_evidence_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider used for accessing the evidence repository."
  default     = ""
}

variable "cd_evidence_repo_secret_group" {
  type        = string
  description = "Secret group for the Evidence repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "continuous_delivery_service_name" {
  type        = string
  description = "The name of the CD instance."
  default     = "cd-devsecops"
}

variable "cd_inventory_group" {
  type        = string
  description = "Specify the Git user or group for the inventory repository."
  default     = ""
}

variable "cd_inventory_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are 'oauth' or 'pat'. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = ""
}

variable "cd_inventory_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Git token used for acessing the Inventory repository."
  default     = ""
  validation {
    condition     = startswith(var.cd_inventory_repo_git_token_secret_crn, "crn:") || var.cd_inventory_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_inventory_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider used for accessing the inventory repository."
  default     = ""
}

variable "cd_inventory_repo_secret_group" {
  type        = string
  description = "Secret group for the Inventory repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cd_issues_group" {
  type        = string
  description = "Specify the Git user or group for the issues repository."
  default     = ""
}

variable "cd_issues_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are 'oauth' or 'pat'. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = ""
}

variable "cd_issues_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Git token used for accessing the Issues repository."
  default     = ""
  validation {
    condition     = startswith(var.cd_issues_repo_git_token_secret_crn, "crn:") || var.cd_issues_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_issues_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider used for accessing the issues repository."
  default     = ""
}

variable "cd_issues_repo_secret_group" {
  type        = string
  description = "Secret group for the Issues repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cd_kp_location" {
  type        = string
  description = "The region hosting the Key Protect instance."
  default     = ""
}

variable "cd_kp_name" {
  type        = string
  description = "Name of the Key Protect instance where the secrets are stored."
  default     = ""
}

variable "cd_kp_resource_group" {
  type        = string
  description = "The resource group containing the Key Protect instance."
  default     = ""
}

variable "cd_link_to_doi_toolchain" {
  description = "Enable a link to a DevOps Insights instance in another toolchain, true or false."
  type        = bool
  default     = true
}

variable "cd_pipeline_config_group" {
  type        = string
  description = "Specify the Git user or group for the compliance pipeline repository."
  default     = ""
}

variable "cd_pipeline_config_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are 'oauth' or 'pat'. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = ""
}

variable "cd_pipeline_config_repo_branch" {
  type        = string
  description = "Specify the branch containing the custom pipeline-config.yaml file."
  default     = "main"
}

variable "cd_pipeline_config_repo_clone_from_url" {
  type        = string
  description = "Specify a repository containing a custom pipeline-config.yaml file."
  default     = ""
}

variable "cd_pipeline_config_repo_existing_url" {
  type        = string
  description = "Specify a repository containing a custom pipeline-config.yaml file."
  default     = ""
}

variable "cd_pipeline_config_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Git token for accessing the pipeline config repository."
  default     = ""
  validation {
    condition     = startswith(var.cd_pipeline_config_repo_git_token_secret_crn, "crn:") || var.cd_pipeline_config_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_pipeline_config_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider used for accessing the pipeline config repository."
  default     = ""
}

variable "cd_pipeline_config_repo_secret_group" {
  type        = string
  description = "Secret group for the Pipeline Config repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cd_pipeline_doi_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the DOI (DevOps Insights) apikey used for accessing a specific toolchain Insights instance."
  default     = ""
  validation {
    condition     = startswith(var.cd_pipeline_doi_api_key_secret_crn, "crn:") || var.cd_pipeline_doi_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_pipeline_doi_api_key_secret_group" {
  type        = string
  description = "Secret group for the pipeline DOI api key. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cd_pipeline_doi_api_key_secret_name" {
  type        = string
  description = "Name of the Cloud API key secret in the secret provider to access the toolchain containing the Devops Insights instance."
  default     = ""
}

variable "cd_pipeline_git_tag" {
  type        = string
  description = "The GIT tag selector for the Compliance Pipelines definitions."
  default     = ""
}

variable "cd_pipeline_ibmcloud_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the IBMCloud apikey used for running the pipelines."
  default     = ""
  validation {
    condition     = startswith(var.cd_pipeline_ibmcloud_api_key_secret_crn, "crn:") || var.cd_pipeline_ibmcloud_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_pipeline_ibmcloud_api_key_secret_group" {
  type        = string
  description = "Secret group for the pipeline ibmcloud API key secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cd_pipeline_ibmcloud_api_key_secret_name" {
  type        = string
  description = "Name of the Cloud API key secret in the secret provider for running the pipelines."
  default     = ""
}

variable "cd_pipeline_properties_filepath" {
  type        = string
  description = "The path to the file containing the property JSON. If this is not set, it will by default read the `properties.json` file at the root of the module."
  default     = ""
}

variable "cd_pipeline_properties" {
  type        = string
  description = "This JSON represents the pipeline properties belonging to the CD pipeline in the CD toolchain. Each element in the JSON represents a seperate pipeline property. Three attributes are required to create a property. These are the `name` field (how the name appears in the pipeline properties), the `type` (text, secure and enum) and then the `value`. Do not put secrets directly into JSON for the `secure` type, instead the value for a `secret` type should be a CRN to a secret in the configured secrets provider or a secret reference to a secret in the configured secrets provider."
  default     = ""
}

variable "cd_privateworker_credentials_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the private worker service apikey that runs the pipeline tasks."
  default     = ""
  validation {
    condition     = startswith(var.cd_privateworker_credentials_secret_crn, "crn:") || var.cd_privateworker_credentials_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_region" {
  type        = string
  description = "IBM Cloud region used to prefix the `prod_latest` inventory repository branch."
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

variable "cd_repository_properties_filepath" {
  type        = string
  description = "The path to the file containing the repository and triggers JSON. If this is not set, it will by default read the `repositories.json` file at the root of the module."
  default     = ""
}

variable "cd_repository_properties" {
  type        = string
  description = "Stringified JSON containing the repositories and triggers that get created in the CI toolchain pipelines."
  default     = ""
}

variable "cd_scc_enable_scc" {
  type        = string
  description = "Adds the SCC tool integration to the toolchain."
  default     = ""
}

variable "cd_scc_integration_name" {
  type        = string
  description = "The name of the SCC integration."
  default     = "Security and Compliance"
}

variable "cd_scc_use_profile_attachment" {
  type        = string
  description = "Set to `enabled` to enable use profile with attachment, so that the scripts in the pipeline can interact with the Security and Compliance Center service. When enabled, other parameters become relevant; `scc_scc_api_key_secret_name`, `scc_instance_crn`, `scc_profile_name`, `scc_profile_version`, `scc_attachment_id`."
  default     = ""
}

variable "cd_service_plan" {
  type        = string
  description = "The Continuous Delivery service plan. Can be `lite` or `professional`."
  default     = "professional"
}

variable "cd_slack_channel_name" {
  type        = string
  description = "The name of the Slack channel where notifications are posted."
  default     = ""
}

variable "cd_slack_pipeline_fail" {
  type        = bool
  description = "Set to `true` to generate pipeline failed notifications."
  default     = true
}

variable "cd_slack_pipeline_start" {
  type        = bool
  description = "Set to `true` to generate pipeline start notifications."
  default     = true
}

variable "cd_slack_pipeline_success" {
  type        = bool
  description = "Set to `true` to generate pipeline succeeded notifications."
  default     = true
}

variable "cd_slack_team_name" {
  type        = string
  description = "The Slack team name, which is the word or phrase before .slack.com in the team URL."
  default     = ""
}

variable "cd_slack_toolchain_bind" {
  type        = bool
  description = "Set to `true` to Generate tool added to toolchain notifications."
  default     = true
}

variable "cd_slack_toolchain_unbind" {
  type        = bool
  description = "Set to `true` to generate tool removed from toolchain notifications."
  default     = true
}

variable "cd_slack_webhook_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Slack webhook secret used for accessing the specified Slack channel."
  default     = ""
  validation {
    condition     = startswith(var.cd_slack_webhook_secret_crn, "crn:") || var.cd_slack_webhook_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "cd_slack_webhook_secret_group" {
  type        = string
  description = "Secret group for the Slack webhook secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "cd_slack_webhook_secret_name" {
  type        = string
  description = "Name of the webhook secret in the secret provider used for accessing the configured Slack channel."
  default     = ""
}

variable "cd_sm_instance_crn" {
  type        = string
  description = "The CRN of the Secrets Manager instance."
  default     = ""
}

variable "cd_sm_location" {
  type        = string
  description = "The region hosting the Secrets Manager instance."
  default     = ""
}

variable "cd_sm_name" {
  type        = string
  description = "The name of an existing Secrets Manager instance where the secrets are stored."
  default     = ""
}

variable "cd_sm_resource_group" {
  type        = string
  description = "The name of the existing resource group containing the Secrets Manager instance for your secrets."
  default     = ""
}

variable "cd_sm_secret_group" {
  type        = string
  description = "The Secrets Manager secret group containing the secrets for the DevSecOps pipelines."
  default     = ""
}

variable "cd_toolchain_description" {
  type        = string
  description = "Description for the CD toolchain."
  default     = "Toolchain created with terraform template for DevSecOps CD Best Practices."
}

variable "cd_toolchain_name" {
  type        = string
  description = "The name of the CD Toolchain."
  default     = ""
}

variable "cd_toolchain_region" {
  type        = string
  description = "The region containing the CD toolchain. Use the short form of the regions. For example `us-south`."
  default     = ""
}

variable "cd_toolchain_resource_group" {
  type        = string
  description = "Resource group within which the toolchain is created."
  default     = ""
}

variable "cd_trigger_git_enable" {
  type        = bool
  description = "Set to `true` to enable the CD pipeline Git trigger."
  default     = false
}

variable "cd_trigger_git_name" {
  type        = string
  description = "The name of the CD pipeline GIT trigger."
  default     = "Git CD Trigger"
}

variable "cd_trigger_git_promotion_validation_branch" {
  type        = string
  description = "Branch for Git promotion validation listener."
  default     = "prod"
}

variable "cd_trigger_git_promotion_validation_enable" {
  type        = bool
  description = "Enable Git promotion validation for Git promotion listener."
  default     = false
}

variable "cd_trigger_git_promotion_validation_listener" {
  type        = string
  description = "Select a Tekton EventListener to use when Git promotion validation listener trigger is fired."
  default     = "promotion-validation-listener-gitlab"
}

variable "cd_trigger_git_promotion_validation_name" {
  type        = string
  description = "Name of Git Promotion Validation Trigger"
  default     = "Git Promotion Validation Trigger"
}

variable "cd_trigger_manual_enable" {
  type        = bool
  description = "Set to `true` to enable the CD pipeline Manual trigger."
  default     = true
}

variable "cd_trigger_manual_name" {
  type        = string
  description = "The name of the CI pipeline Manual trigger."
  default     = "Manual CD Trigger"
}

variable "cd_trigger_manual_promotion_enable" {
  type        = bool
  description = "Set to `true` to enable the CD pipeline Manual Promotion trigger."
  default     = true
}

variable "cd_trigger_manual_promotion_name" {
  type        = string
  description = "The name of the CD pipeline Manual Promotion trigger."
  default     = "Manual Promotion Trigger"
}

variable "cd_trigger_manual_pruner_enable" {
  type        = bool
  description = "Set to `true` to enable the manual Pruner trigger."
  default     = true
}

variable "cd_trigger_manual_pruner_name" {
  type        = string
  description = "The name of the manual Pruner trigger."
  default     = "Evidence Pruner Manual Trigger"
}

variable "cd_trigger_timed_cron_schedule" {
  type        = string
  description = "Only needed for timer triggers. Cron expression that indicates when this trigger will activate. Maximum frequency is every 5 minutes. The string is based on UNIX crontab syntax: minute, hour, day of month, month, day of week. Example: 0 *_/2 * * * - every 2 hours."
  default     = "0 4 * * *"
}

variable "cd_trigger_timed_enable" {
  type        = bool
  description = "Set to `true` to enable the CD pipeline Timed trigger."
  default     = false
}

variable "cd_trigger_timed_name" {
  type        = string
  description = "The name of the CD pipeline Timed trigger."
  default     = "Git CD Timed Trigger"
}

variable "cd_trigger_timed_pruner_enable" {
  type        = bool
  description = "Set to `true` to enable the timed Pruner trigger."
  default     = false
}

variable "cd_trigger_timed_pruner_name" {
  type        = string
  description = "The name of the timed Pruner trigger."
  default     = "Evidence Pruner Timed Trigger"
}

########################################################
##### START OF CI VARIABLES ##############
########################################################

variable "ci_app_group" {
  type        = string
  description = "Specify the Git user or group for the application repository."
  default     = ""
}

variable "ci_app_name" {
  type        = string
  description = "Name of the application image and inventory entry."
  default     = "hello-compliance-app"
}

variable "ci_app_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are 'oauth' or 'pat'. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = ""
}

variable "ci_app_repo_branch" {
  type        = string
  description = "This is the repository branch used by the default sample application. Alternatively if `app_repo_existing_url` is provided, then the branch must reflect the default branch for that repository. Typically these branches are `main` or `master`."
  default     = ""
}

variable "ci_app_repo_clone_from_url" {
  type        = string
  description = "Override the default sample app by providing your own sample app URL, which is cloned into the app repository. Note, uses `clone_if_not_exists` mode, so if the app repository already exists the repository contents are unchanged."
  default     = ""
}

variable "ci_app_repo_clone_to_git_id" {
  type        = string
  description = "Set this value to `github` for github.com, or to the GUID of a custom GitHub Enterprise server."
  default     = ""
}

variable "ci_app_repo_clone_to_git_provider" {
  type        = string
  description = "By default this gets set as 'hostedgit', else set to 'githubconsolidated' for GitHub repositories."
  default     = ""
}

variable "ci_app_repo_existing_git_id" {
  type        = string
  description = "Set this value to `github` for github.com, or to the GUID of a custom GitHub Enterprise server."
  default     = ""
}

variable "ci_app_repo_existing_git_provider" {
  type        = string
  description = "By default this gets set as 'hostedgit', else set to 'githubconsolidated' for GitHub repositories."
  default     = ""
}

variable "ci_app_repo_existing_url" {
  type        = string
  description = "Bring your own existing application repository by providing the URL. This will create an integration for your application repository instead of cloning the default sample. Repositories existing in a different org will require the use of Git token. See `app_repo_git_token_secret_name` under optional variables. "
  default     = ""
}

variable "ci_app_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Git token used for accessing the application repository."
  default     = ""
  validation {
    condition     = startswith(var.ci_app_repo_git_token_secret_crn, "crn:") || var.ci_app_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_app_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider used for accessing the sample (or bring your own) application repository."
  default     = ""
}

variable "ci_app_repo_secret_group" {
  type        = string
  description = "Secret group for the App repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "ci_artifactory_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN for the Artifactory access secret."
  default     = ""
  validation {
    condition     = startswith(var.ci_artifactory_token_secret_crn, "crn:") || var.ci_artifactory_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_authorization_policy_creation" {
  type        = string
  description = "Disable Toolchain Service to Secrets Manager/Key Protect/Notifications Service authorization policy creation. To disable set the value to `disabled`."
  default     = ""
}

variable "ci_cluster_name" {
  type        = string
  description = "Name of the cluster where the application is deployed. (can be the same cluster used for prod)"
  default     = ""
}

variable "ci_cluster_namespace" {
  type        = string
  description = "Name of the cluster namespace where the application is deployed."
  default     = "dev"
}

variable "ci_cluster_region" {
  type        = string
  description = "Region hosting the cluster where the application is deployed. Use the short form of the regions. For example `us-south`."
  default     = ""
}

variable "ci_cluster_resource_group" {
  type        = string
  description = "The cluster resource group."
  default     = ""
}

variable "ci_code_engine_project" {
  type        = string
  description = "The name of the Code Engine project to use."
  default     = "DevSecOps_CE"
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

variable "ci_compliance_pipeline_branch" {
  type        = string
  description = "The CI Pipeline Compliance Pipeline branch."
  default     = ""
}

variable "ci_compliance_pipeline_group" {
  type        = string
  description = "Specify the Git user or group for the compliance pipeline repository."
  default     = ""
}

variable "ci_compliance_pipeline_pr_branch" {
  type        = string
  description = "The PR Pipeline Compliance Pipeline branch."
  default     = ""
}

variable "ci_compliance_pipeline_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are 'oauth' or 'pat'. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = ""
}

variable "ci_compliance_pipeline_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Git token used for accessing the Compliance Pipelines repository."
  default     = ""
  validation {
    condition     = startswith(var.ci_compliance_pipeline_repo_git_token_secret_crn, "crn:") || var.ci_compliance_pipeline_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_compliance_pipeline_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider used for accessing the compliance pipelines repository."
  default     = ""
}

variable "ci_compliance_pipeline_repo_secret_group" {
  type        = string
  description = "Secret group for the Compliance Pipeline repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "ci_cos_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Cloud Object Storage apikey."
  default     = ""
  validation {
    condition     = startswith(var.ci_cos_api_key_secret_crn, "crn:") || var.ci_cos_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_cos_api_key_secret_group" {
  type        = string
  description = "Secret group for the COS API key secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "ci_cos_api_key_secret_name" {
  type        = string
  description = "Name of the Cloud Object Storage API key secret in the secret provider used for accessing the evidence COS bucket."
  default     = ""
}

variable "ci_cos_bucket_name" {
  type        = string
  description = "The name of the Cloud Object Storage bucket used for storing the evidence."
  default     = ""
}

variable "ci_cos_endpoint" {
  type        = string
  description = "The endpoint for the Cloud Object Stroage instance containing the evidence bucket."
  default     = ""
}

variable "ci_doi_toolchain_id_pipeline_property" {
  type        = string
  description = "The pipeline property for the DevOps Insights instance toolchain ID."
  default     = ""
}

variable "ci_doi_toolchain_id" {
  type        = string
  description = "The ID of the toolchain containing the DevOps Insights integration. This variable is used to link the DevOps Insights toolcard to a specific instance."
  default     = ""
}

variable "ci_enable_key_protect" {
  type        = string
  description = "Set to `true` to the enable Key Protect integrations."
  default     = ""
}

variable "ci_enable_pipeline_notifications" {
  type        = string
  description = "When enabled, pipeline run events will be sent to the Event Notifications and Slack integrations in the enclosing toolchain."
  default     = ""
}

variable "ci_enable_secrets_manager" {
  type        = string
  description = "Set to `true` to enable the Secrets Manager integrations."
  default     = ""
}

variable "ci_enable_slack" {
  type        = string
  description = "Set to `true` to create the Slack toolchain integration."
  default     = ""
}

variable "ci_event_notifications_crn" {
  type        = string
  description = "Set the Event Notifications CRN to create an Events Notification integration."
  default     = ""
}

variable "ci_evidence_group" {
  type        = string
  description = "Specify the Git user or group for the evidence repository."
  default     = ""
}

variable "ci_evidence_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are 'oauth' or 'pat'. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = ""
}

variable "ci_evidence_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Git token used for accessing the Evidence repository."
  default     = ""
  validation {
    condition     = startswith(var.ci_evidence_repo_git_token_secret_crn, "crn:") || var.ci_evidence_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_evidence_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider used for accessing the evidence repository."
  default     = ""
}

variable "ci_evidence_repo_secret_group" {
  type        = string
  description = "Secret group for the Evidence repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "ci_inventory_group" {
  type        = string
  description = "Specify the Git user or group for the inventory repository."
  default     = ""
}

variable "ci_inventory_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are 'oauth' or 'pat'. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = ""
}

variable "ci_inventory_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Git token used for acessing the Inventory repository."
  default     = ""
  validation {
    condition     = startswith(var.ci_inventory_repo_git_token_secret_crn, "crn:") || var.ci_inventory_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_inventory_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider used for accessing the inventory repository."
  default     = ""
}

variable "ci_inventory_repo_secret_group" {
  type        = string
  description = "Secret group for the Inventory repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "ci_issues_group" {
  type        = string
  description = "Specify the Git user or group for the issues repository."
  default     = ""
}

variable "ci_issues_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are 'oauth' or 'pat'. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = ""
}

variable "ci_issues_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Git token used for accessing the Issues repository."
  default     = ""
  validation {
    condition     = startswith(var.ci_issues_repo_git_token_secret_crn, "crn:") || var.ci_issues_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_issues_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider used for accessing the issues repository."
  default     = ""
}

variable "ci_issues_repo_secret_group" {
  type        = string
  description = "Secret group for the Issues repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "ci_kp_location" {
  type        = string
  description = "The region hosting the Key Protect instance."
  default     = ""
}

variable "ci_kp_name" {
  type        = string
  description = "Name of the Key Protect instance where the secrets are stored."
  default     = ""
}

variable "ci_kp_resource_group" {
  type        = string
  description = "The resource group containing the Key Protect instance."
  default     = ""
}

variable "ci_link_to_doi_toolchain" {
  description = "Enable a link to a DevOps Insights instance in another toolchain."
  type        = bool
  default     = false
}

variable "ci_pipeline_config_group" {
  type        = string
  description = "Specify the Git user or group for the pipeline config repository."
  default     = ""
}

variable "ci_pipeline_config_repo_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are 'oauth' or 'pat'. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = ""
}

variable "ci_pipeline_config_repo_branch" {
  type        = string
  description = "Specify the branch containing the custom pipeline-config.yaml file."
  default     = ""
}

variable "ci_pipeline_config_repo_clone_from_url" {
  type        = string
  description = "Specify a repository containing a custom pipeline-config.yaml file."
  default     = ""
}

variable "ci_pipeline_config_repo_existing_url" {
  type        = string
  description = "Specify and link to an existing repository containing a custom pipeline-config.yaml file."
  default     = ""
}

variable "ci_pipeline_config_repo_git_token_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Git token for accessing the pipeline config repository."
  default     = ""
  validation {
    condition     = startswith(var.ci_pipeline_config_repo_git_token_secret_crn, "crn:") || var.ci_pipeline_config_repo_git_token_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_pipeline_config_repo_git_token_secret_name" {
  type        = string
  description = "Name of the Git token secret in the secret provider used for accessing the pipeline config repository."
  default     = ""
}

variable "ci_pipeline_config_repo_secret_group" {
  type        = string
  description = "Secret group for the Pipeline Config repository secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "ci_pipeline_doi_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the DOI (DevOps Insights) apikey used for accessing a specific toolchain Insights instance."
  default     = ""
  validation {
    condition     = startswith(var.ci_pipeline_doi_api_key_secret_crn, "crn:") || var.ci_pipeline_doi_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_pipeline_doi_api_key_secret_group" {
  type        = string
  description = "Secret group for the pipeline DOI api key. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "ci_pipeline_doi_api_key_secret_name" {
  type        = string
  description = "Name of the Cloud API key secret in the secret provider to access the toolchain containing the Devops Insights instance."
  default     = ""
}

variable "ci_pipeline_git_tag" {
  type        = string
  description = "The GIT tag selector for the Compliance Pipelines definitions."
  default     = ""
}

variable "ci_pipeline_ibmcloud_api_key_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the IBMCloud apikey used for running the pipelines."
  default     = ""
  validation {
    condition     = startswith(var.ci_pipeline_ibmcloud_api_key_secret_crn, "crn:") || var.ci_pipeline_ibmcloud_api_key_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_pipeline_ibmcloud_api_key_secret_group" {
  type        = string
  description = "Secret group for the pipeline ibmcloud API key secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "ci_pipeline_ibmcloud_api_key_secret_name" {
  type        = string
  description = "Name of the Cloud API key secret in the secret provider for running the pipelines."
  default     = ""
}

variable "ci_pipeline_properties_filepath" {
  type        = string
  description = "The path to the file containing the properties JSON. If this is not set, it will by default read the `properties.json` file at the root of the CI module."
  default     = ""
}

variable "ci_pipeline_properties" {
  type        = string
  description = "This JSON represents the pipeline properties belonging to the both the CI and PR pipelines in the CI toolchain. Each element in the JSON represents a seperate pipeline property. Three attributes are required to create a property. These are the `name` field (how the name appears in the pipeline properties), the `type` (text, secure and enum) and then the `value`. Do not put secrets directly into JSON for the `secure` type, instead the value for a `secret` type should be a CRN to a secret in the configured secrets provider or a secret reference to a secret in the configured secrets provider."
  default     = ""
}

variable "ci_privateworker_credentials_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the private worker service apikey that runs the pipeline tasks."
  default     = ""
  validation {
    condition     = startswith(var.ci_privateworker_credentials_secret_crn, "crn:") || var.ci_privateworker_credentials_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_registry_region" {
  type        = string
  description = "The IBM Cloud Region where the IBM Cloud Container Registry namespace is to be created. Use the short form of the regions. For example `us-south`."
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

variable "ci_repository_properties_filepath" {
  type        = string
  description = "The path to a file containing the repository and triggers JSON. If this is not set, it will by default read the `repositories.json` file at the root of the CI module."
  default     = ""
}

variable "ci_repository_properties" {
  type        = string
  description = "Stringified JSON containing the repositories and triggers that get created in the CI toolchain pipelines."
  default     = ""
}

variable "ci_signing_key_secret_name" {
  type        = string
  description = "Name of the signing key secret in the secret provider used for signing images/artifacts."
  default     = "signing-key"
}

variable "ci_slack_channel_name" {
  type        = string
  description = "The name of the Slack channel where notifications are posted."
  default     = ""
}

variable "ci_slack_pipeline_fail" {
  type        = bool
  description = "Set to `true` to generate pipeline failed notifications."
  default     = true
}

variable "ci_slack_pipeline_start" {
  type        = bool
  description = "Set to `true` to generate pipeline start notifications."
  default     = true
}

variable "ci_slack_pipeline_success" {
  type        = bool
  description = "Set to `true` to generate pipeline succeeded notifications."
  default     = true
}

variable "ci_slack_team_name" {
  type        = string
  description = "The Slack team name, which is the word or phrase before `.slack.com` in the team URL."
  default     = ""
}

variable "ci_slack_toolchain_bind" {
  type        = bool
  description = "Set to `true` to Generate tool added to toolchain notifications."
  default     = true
}

variable "ci_slack_toolchain_unbind" {
  type        = bool
  description = "Set to `true` to generate tool removed from toolchain notifications."
  default     = true
}

variable "ci_slack_webhook_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the Slack webhook secret used for accessing the specified Slack channel."
  default     = ""
  validation {
    condition     = startswith(var.ci_slack_webhook_secret_crn, "crn:") || var.ci_slack_webhook_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_slack_webhook_secret_group" {
  type        = string
  description = "Secret group for the Slack webhook secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "ci_slack_webhook_secret_name" {
  type        = string
  description = "Name of the webhook secret in the secret provider used for accessing the configured Slack channel."
  default     = ""
}

variable "ci_sm_instance_crn" {
  type        = string
  description = "The CRN of the Secrets Manager instance."
  default     = ""
}

variable "ci_sm_location" {
  type        = string
  description = "The region hosting the Secrets Manager instance."
  default     = ""
}

variable "ci_sm_name" {
  type        = string
  description = "The name of an existing Secrets Manager instance where the secrets are stored."
  default     = ""
}

variable "ci_sm_resource_group" {
  type        = string
  description = "The name of the existing resource group containing the Secrets Manager instance for your secrets."
  default     = ""
}

variable "ci_sm_secret_group" {
  type        = string
  description = "The Secrets Manager secret group containing the secrets for the DevSecOps pipelines."
  default     = ""
}

variable "ci_sonarqube_integration_name" {
  type        = string
  description = "The name of the SonarQube integration."
  default     = ""
}

variable "ci_sonarqube_is_blind_connection" {
  type        = string
  description = "When set to `true`, instructs IBM Cloud Continuous Delivery to not validate the configuration of this integration. Set this to `true` if the SonarQube server is not addressable on the public internet."
  default     = ""
}

variable "ci_sonarqube_secret_crn" {
  type        = string
  sensitive   = true
  description = "The CRN of the secret used to access SonarQube."
  default     = ""
  validation {
    condition     = startswith(var.ci_sonarqube_secret_crn, "crn:") || var.ci_sonarqube_secret_crn == ""
    error_message = "Must be a CRN or left empty."
  }
}

variable "ci_sonarqube_secret_group" {
  type        = string
  description = "Secret group for the SonarQube secret. Defaults to the value set in `sm_secret_group` if not set. Only used with `Secrets Manager`."
  default     = ""
}

variable "ci_sonarqube_secret_name" {
  type        = string
  description = "The name of the SonarQube secret in the secrets provider."
  default     = ""
}

variable "ci_sonarqube_server_url" {
  type        = string
  description = "The URL to the SonarQube server."
  default     = ""
}

variable "ci_sonarqube_user" {
  type        = string
  description = "The name of the SonarQube user."
  default     = ""
}

variable "ci_toolchain_description" {
  type        = string
  description = "Description for the CI Toolchain."
  default     = "Toolchain created with terraform template for DevSecOps CI Best Practices."
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

variable "ci_toolchain_resource_group" {
  type        = string
  description = "The resource group within which the toolchain is created."
  default     = ""
}

variable "ci_trigger_git_enable" {
  type        = bool
  description = "Set to `true` to enable the CI pipeline Git trigger."
  default     = true
}

variable "ci_trigger_git_name" {
  type        = string
  description = "The name of the CI pipeline GIT trigger."
  default     = "Git CI Trigger"
}

variable "ci_trigger_manual_enable" {
  type        = bool
  description = "Set to `true` to enable the CI pipeline Manual trigger."
  default     = true
}

variable "ci_trigger_manual_name" {
  type        = string
  description = "The name of the CI pipeline Manual trigger."
  default     = "Manual Trigger"
}

variable "ci_trigger_manual_pruner_enable" {
  type        = bool
  description = "Set to `true` to enable the manual Pruner trigger."
  default     = true
}

variable "ci_trigger_manual_pruner_name" {
  type        = string
  description = "The name of the manual Pruner trigger."
  default     = "Evidence Pruner Manual Trigger"
}

variable "ci_trigger_pr_git_enable" {
  type        = bool
  description = "Set to `true` to enable the PR pipeline Git trigger."
  default     = true
}

variable "ci_trigger_pr_git_name" {
  type        = string
  description = "The name of the PR pipeline GIT trigger."
  default     = "Git PR Trigger"
}

variable "ci_trigger_timed_cron_schedule" {
  type        = string
  description = "Only needed for timer triggers. Cron expression that indicates when this trigger will activate. Maximum frequency is every 5 minutes. The string is based on UNIX crontab syntax: minute, hour, day of month, month, day of week. Example: 0 *_/2 * * * - every 2 hours."
  default     = "0 4 * * *"
}

variable "ci_trigger_timed_enable" {
  type        = bool
  description = "Set to `true` to enable the CI pipeline Timed trigger."
  default     = false
}

variable "ci_trigger_timed_name" {
  type        = string
  description = "The name of the CI pipeline Timed trigger."
  default     = "Git CI Timed Trigger"
}

variable "ci_trigger_timed_pruner_enable" {
  type        = bool
  description = "Set to `true` to enable the timed Pruner trigger."
  default     = false
}

variable "ci_trigger_timed_pruner_name" {
  type        = string
  description = "The name of the timed Pruner trigger."
  default     = "Evidence Pruner Timed Trigger"
}

variable "sample_default_application" {
  type        = string
  description = "The name of the sample application repository. The repository source URL is automatically computed based on the toolchain region. The other currently supported name is `code-engine-compliance-app`. Alternatively an integration can be created that can link to or clone from an existing repository. See `app_repo_existing_url` and `app_repo_clone_from_url` to override the sample application default behavior."
  default     = "code-engine-compliance-app"
}

variable "use_app_repo_for_cd_deploy" {
  type        = bool
  description = "Set to `true` to use the CI sample application repository as the deployment repository in the CD pipeline. This will be set in the pipeline config integration."
  default     = true
}

variable "add_pipeline_definitions" {
  type        = string
  description = "Set to `true` to add pipeline definitions."
  default     = "true"
}

variable "create_git_triggers" {
  type        = string
  description = "Set to `true` to create the default Git triggers associated with the compliance repos and sample app."
  default     = "true"
}

############### ACCESS GROUPS  ################

variable "toolchain_access_group_name" {
  type        = string
  description = "The name of the DevSecOps access group."
  default     = "devsecops-toolchain"
}

variable "create_access_group" {
  type        = bool
  description = "Set to `true` to create an access group for the operations of the DevSecOps toolchains."
  default     = false
}

variable "use_legacy_ref" {
  type        = bool
  description = "Set to `true` to use the legacy secret reference format for Secrets Manager secrets."
  default     = true
}
