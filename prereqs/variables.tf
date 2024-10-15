variable "ibmcloud_api_key" {
  type        = string
  description = "The API key used to create the toolchains. (See deployment guide.)"
  sensitive   = true
}

variable "gpg_name" {
  type        = string
  description = "The name to be associated with the GPG key."
  default     = "IBMer"
}

variable "gpg_email" {
  type        = string
  description = "The email address associated with the GPG key."
  default     = "ibmer@ibm.com"
}

variable "create_secret_group" {
  type        = bool
  description = "Set to `true` to create the specified Secrets Manager secret group."
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
  description = "Experimental. Set to `true` to create and add a `signing_key`to the Secrets Provider."
  default     = false
}

variable "create_signing_certificate" {
  type        = bool
  description = "Experimental. Set to `true` to create and add the `signing-certificate` to the Secrets Provider."
  default     = false
}

variable "create_git_token" {
  type        = bool
  description = "Set to `true` to create and add the specified personal access token secret to the Secrets Provider."
  default     = false
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

variable "sm_exists" {
  description = "Only connect to the Secrets Manager instance if it has been enabled for the toolchain."
  type        = bool
  default     = false
}

variable "sm_location" {
  type        = string
  description = "The region location of the Secrets Manager instance."
  default     = "us-south"
}

variable "sm_name" {
  type        = string
  description = "The name of the Secret Managers instance."
  default     = "Secrets Manager"
}

variable "sm_instance_id" {
  type        = string
  description = "The instance ID of the targeted Secrets Manager."
  default     = ""
}

variable "sm_secret_group_name" {
  type        = string
  description = "Group in Secrets Manager for organizing/grouping secrets."
  default     = "devsecops"
}

variable "sm_endpoint_type" {
  type        = string
  description = "The types of service endpoints to target for Secrets Manager."
  default     = "public"
}

variable "sm_secret_expiration_period" {
  type        = string
  description = "The number of days until the secret expires. Leave empty to not set an expiration."
  default     = ""
}

variable "cos_api_key_secret_name" {
  type        = string
  description = "The name of the secret as it appears in Secret Manager."
  default     = "cos-api-key"
}

variable "iam_api_key_secret_name" {
  type        = string
  description = "The name of the secret as it appears in Secret Manager."
  default     = "ibmcloud-api-key"
}

variable "rotation_period" {
  type        = number
  description = "The number of days until the `ibmcloud-api-key` and the `cos-api-key` are auto rotated."
  default     = 90
}

variable "signing_certificate_secret" {
  type        = string
  description = "pgp key"
  sensitive   = true
  default     = ""
}

variable "signing_certifcate_secret_name" {
  type        = string
  description = "The name of the secret as it appears in Secret Manager."
  default     = "signing-certificate"
}

variable "signing_key_secret" {
  type        = string
  description = "apikey"
  sensitive   = true
  default     = ""
}

variable "signing_key_secret_name" {
  type        = string
  description = "The name of the secret as it appears in Secret Manager."
  default     = "signing_key"
}

variable "create_kubernetes_access_policy" {
  type        = bool
  description = "Add a Kubernetes access policy to the generated IAM access key."
  default     = false
}

variable "create_code_engine_access_policy" {
  type        = bool
  description = "Add a Code Engine access policy to the generated IAM access key."
  default     = false
}

##################### ICR ################
variable "sm_resource_group" {
  type        = string
  description = "The name of the resource group containing the Secrets Manager instance."
  default     = ""
}

############### ACCESS GROUPS  ################

variable "service_name_pipeline" {
  type        = string
  description = "The name of the Service ID for pipeline and toolchain access."
  default     = "toolchain-pipeline-service-id"
}

variable "service_name_cos" {
  type        = string
  description = "The name of the Service ID for COS access."
  default     = "cos-service-id"
}
