##############################################################################
# Input Variables
##############################################################################
variable "ibmcloud_api_key" {
  type        = string
  description = "IBM Cloud API KEY to fetch/post cloud resources in terraform. Not used in the pipeline, where a secret reference is used instead."
  sensitive   = true
}

variable "toolchain_resource_group" {
  type        = string
  description = "The resource group within which the toolchain will be created."
  default     = "Default"
}

variable "toolchain_region" {
  type        = string
  description = "IBM Cloud region where your toolchain will be created"
  default     = "us-south"
}

variable "registry_namespace" {
  type        = string
  description = "Unique namespace within the IBM Cloud Container Registry where application image need to be stored."
  default     = "my-registry-namespace"
}

variable "cluster_name" {
  type        = string
  description = "Name of the Kubernetes cluster where the application will be deployed."
  default     = "mycluster-free"
}

variable "enable_key_protect" {
  type        = bool
  description = "Set to enable Key Protect Integrations. "
  default     = false
}

variable "enable_secrets_manager" {
  description = "Enable the Secrets Manager integrations."
  type        = bool
  default     = false
}

variable "kp_resource_group" {
  type        = string
  description = "The resource group containing the Key Protect instance for your secrets."
  default     = "Default"
}

variable "kp_name" {
  type        = string
  description = "Name of the Key Protect instance where the secrets are stored."
  default     = "prodkeys"
}

variable "kp_location" {
  type        = string
  description = "IBM Cloud location/region containing the Key Protect instance."
  default     = "us-south"
}

variable "create_ci_toolchain" {
  description = "Flag which determines if the DevSecOps CI toolchain is created. If this toolchain is not created then values must be set for the following variables, evidence_repo_url, issues_repo_url and inventory_repo_url."
  type        = bool
  default     = true
}

variable "create_cd_toolchain" {
  description = "Boolean flag which determines if the DevSecOps CD toolchain is created."
  type        = bool
  default     = false
}

variable "create_cc_toolchain" {
  description = "Boolean flag which determines if the DevSecOps CC toolchain is created."
  type        = bool
  default     = false
}
