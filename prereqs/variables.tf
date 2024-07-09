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
  description = "The types of service endpoints to target for the secret group`."
  default     = "public"
}

variable "cos_api_key_secret" {
  type        = string
  description = "apikey"
  sensitive   = true
  default     = ""
}

variable "cos_api_key_secret_name" {
  type        = string
  description = "The name of the secret as it appears in Secret Manager."
  default     = "cos-api-key"
}

variable "iam_api_key_secret" {
  type        = string
  description = "apikey"
  sensitive   = true
  default     = ""
}

variable "iam_api_key_secret_name" {
  type        = string
  description = "The name of the secret as it appears in Secret Manager."
  default     = "ibmcloud-api-key"
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

##################### ICR ################
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

variable "registry_namespace" {
  type        = string
  description = "The name of the secret as it appears in Secret Manager."
  default     = ""
}

variable "resource_group_id" {
  type        = string
  description = "The ID of the resource group containing the ICR"
  default     = ""
}

variable "random_string_length" {
  type        = number
  description = "The length of the random suffix added to the resource name."
  default     = 4
}

#variable "ibmcloud_api_key" {
#  type        = string
#  description = "API key belonging to the account in which all the resources are created."
#  sensitive   = true
#}

variable "prefix" {
  type        = string
  description = "A prefix that will be added before the `cd_instance_name` and the `registry_namespace` name."
  default     = ""
}
