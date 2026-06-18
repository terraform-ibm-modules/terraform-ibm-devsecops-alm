variable "ibmcloud_api_key" {
  sensitive = true
}

variable "sm_instance_crn" {
}

variable "toolchain_name" {
}

variable "toolchain_region" {
  default = "us-south"
}

variable "toolchain_resource_group" {
  default = "jumpstart"
}

variable "app_repo_existing_url" {
  default = ""
}

variable "repo_git_id" {
  default = ""
}

variable "repo_git_token_secret_crn" {
  default = ""
}

variable "app_repo_branch" {
  default = "master"
}

variable "inventory_repo_existing_url" {
  default = ""
}

variable "issues_repo_existing_url" {
  default = ""
}

variable "ghec_git_token_secret_crn" {
  default = ""
}
