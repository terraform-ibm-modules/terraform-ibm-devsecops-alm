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

variable "create_privateworker_secret" {
  type        = bool
  description = "Set to `true` to add a specified private worker service api key to the Secrets Provider. This also enables a private worker tool integration in the toolchains."
  default     = false
}

variable "create_signing_key" {
  type        = bool
  description = "Experimental. Set to `true` to create and add a `signing_key`to the Secrets Provider."
  default     = false
}

variable "create_git_token" {
  type        = bool
  description = "Set to `true` to add the specified personal access token secret to the Secrets Provider. Use `repo_git_token_secret_value` for setting the value."
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

variable "cos_api_key_secret_value" {
  type        = string
  description = "A user provided api key with COS access permissions that can be pushed to Secrets Manager. See `cos_api_key_secret_name`."
  sensitive   = true
  default     = ""
}

variable "cos_bucket_name" {
  type        = string
  description = "Set the name of your COS bucket. This applies the same COS bucket name for the CI, CD, and CC toolchains."
  default     = ""
}

variable "cos_instance_crn" {
  type        = string
  description = "The CRN of the Cloud Object Storage instance containing the required bucket. This value is required to generate the correct access policies if creating IAM service credentials."
  default     = ""
}

variable "iam_api_key_secret_name" {
  type        = string
  description = "The name of the secret as it appears in Secret Manager."
  default     = "ibmcloud-api-key"
}

variable "iam_api_key_secret_value" {
  type        = string
  description = "A user provided api key for running the toolchain pipelines that can be pushed to Secrets Manager. See `iam_api_key_secret_name`."
  sensitive   = true
  default     = ""
}

variable "privateworker_secret_name" {
  type        = string
  description = "The name of the secret as it appears in Secret Manager."
  default     = "private-worker-key"
}

variable "privateworker_secret_value" {
  type        = string
  sensitive   = true
  description = "The private worker service api key that will be added to the `privateworker_secret_name` secret in the secrets provider."
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

variable "force_create_standard_api_key" {
  type        = bool
  description = "Set to `true` to force create a standard api key. By default the generated apikey will be a service api key. It is recommended to use a Git Token when using the service api key. In the case where the user has been invited to an account and that user not the account owner, during toolchain creation the default compliance repositories will be created in that user's account and the service api will not have access to those repositories. In this case a Git Token for the repositories is required. See `repo_git_token_secret_name` for more details. The alternative is to set `force_create_standard_api_key` to `true` to create a standard api key."
  default     = false
}

##################### ICR ################
variable "sm_resource_group" {
  type        = string
  description = "The name of the resource group containing the Secrets Manager instance."
  default     = ""
}

############### SERVICE IDS  ################

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


############### ACCESS GROUPS  ################

variable "toolchain_access_group_name" {
  type        = string
  description = "The name of the DevSecOps access group. See `create_access_group`."
  default     = "devsecops-toolchain"
}

variable "create_access_group" {
  type        = bool
  description = "Set to `true` to create an access group for the operations of the DevSecOps toolchains."
  default     = false
}
