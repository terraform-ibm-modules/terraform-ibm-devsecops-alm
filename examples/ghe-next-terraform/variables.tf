variable "ibmcloud_api_key" {
  type        = string
  description = "IBM Cloud API KEY to fetch/post cloud resources in terraform."
  sensitive   = true
}

variable "sm_instance_crn" {
  type        = string
  description = "Secret Manager Instance CRN."
}

variable "toolchain_name" {
  type        = string
  description = "Toolchain name prefix."
}

variable "toolchain_region" {
  type        = string
  description = "Region where toolchain(s) will be created."
  default     = "us-south"
}

variable "toolchain_resource_group" {
  type        = string
  description = "Resource Group where toolchain(s) will be created."
  default     = "jumpstart"
}

variable "ghe_next_git_id" {
  type        = string
  description = "Set this value to `github` for github.com, or to the GUID of a custom GitHub Enterprise server."
  default     = ""
}

variable "ghe_next_auth_type" {
  type        = string
  description = "Select the method of authentication that is used to access the Git repository. Valid values are `oauth`, `pat` or `github_app`. Defaults to `oauth` when unset. `pat` is a git `personal access token`."
  default     = "pat"
}

variable "ghe_next_github_app_auth_method" {
  type        = string
  description = "The GitHub App authorization method. E.g. `custom` or `managed`."
  default     = ""
}

variable "ghe_next_github_app_credential_app_id" {
  type        = string
  description = "The GitHub App App ID."
  default     = ""
}

variable "ghe_next_github_app_credential_private_key_secret_crn" {
  type        = string
  default     = ""
  description = "CRN of the GitHub App private key secret in the secret provider"
  sensitive   = true
}

variable "app_repo_existing_url" {
  type        = string
  description = "Existing application repo URL."
  default     = ""
}

variable "repo_git_token_secret_crn" {
  type        = string
  description = "Git token used to clone repo(s)."
  sensitive   = true
}

variable "app_repo_branch" {
  type        = string
  description = "Application repo branch."
  default     = "master"
}

variable "inventory_repo_existing_url" {
  type        = string
  description = "Existing inventory repo URL."
  default     = ""
}

variable "issues_repo_existing_url" {
  type        = string
  description = "Existing issues repo URL."
  default     = ""
}

variable "change_management_existing_url" {
  type        = string
  description = "Existing change management repo URL."
  default     = ""
}
