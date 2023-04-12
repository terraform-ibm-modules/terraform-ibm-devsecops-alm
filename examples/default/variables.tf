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

variable "ci_registry_namespace" {
  type        = string
  description = "Unique namespace within the IBM Cloud Container Registry where application image need to be stored."
  default     = "my-registry-namespace"
}

variable "ci_registry_region" {
  type        = string
  description = "The IBM Cloud Region where the IBM Cloud Container Registry namespace is to be created."
  default     = "ibm:yp:us-south"
}

variable "ci_cluster_name" {
  type        = string
  description = "Name of the Kubernetes cluster where the application will be deployed."
  default     = "mycluster-free"
}

variable "ci_cluster_namespace" {
  type        = string
  description = "Name of the Kubernetes cluster namespace where the application will be deployed."
  default     = "dev"
}

variable "ci_dev_region" {
  type        = string
  description = "Region of the Kubernetes cluster where the application will be deployed."
  default     = "ibm:yp:us-south"
}

variable "ci_dev_resource_group" {
  type        = string
  description = "The cluster resource group."
  default     = "Default"
}

variable "cd_cluster_name" {
  type        = string
  description = "Name of the Kubernetes cluster where the application is deployed."
  default     = "mycluster-free"
}

variable "cd_cluster_namespace" {
  type        = string
  description = "Name of the Kubernetes cluster namespace where the application is deployed."
  default     = "prod"
}

variable "enable_key_protect" {
  type        = bool
  description = "Set to enable Key Protect Integrations. "
  default     = true
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

variable "sm_location" {
  type        = string
  description = "The region location of the Secrets Manager instance."
  default     = "us-south"
}

variable "sm_name" {
  type        = string
  description = "The name of the Secret Managers instance."
  default     = "sm-instance"
}

variable "sm_resource_group" {
  type        = string
  description = "The resource group containing the Secrets Manager instance."
  default     = "Default"
}

variable "sm_secret_group" {
  type        = string
  description = "Group in Secrets Manager for organizing/grouping secrets."
  default     = "Default"
}
