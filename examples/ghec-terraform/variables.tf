variable "ibmcloud_api_key" {
  type        = string
  description = "IBM Cloud API KEY to fetch/post cloud resources in terraform."
  sensitive = true
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
  default = "us-south"
}

variable "toolchain_resource_group" {
  type        = string
  description = "Resource Group where toolchain(s) will be created."
  default = "jumpstart"
}

variable "app_repo_existing_url" {
  type        = string
  description = "Existing application repo URL."
  default = ""
}

variable "repo_git_token_secret_crn" {
  type        = string
  description = "Git token used to clone repo(s)."
  sensitive = true
}

variable "app_repo_branch" {
  type        = string
  description = "Application repo branch."
  default = "master"
}

variable "inventory_repo_existing_url" {
  type        = string
  description = "Existing inventory repo URL."
  default = ""
}

variable "issues_repo_existing_url" {
  type        = string
  description = "Existing issues repo URL."
  default = ""
}
