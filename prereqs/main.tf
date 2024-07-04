locals {
  sm_instance_id     = try(data.ibm_resource_instance.sm_instance[0].guid, "")
  sm_instance_crn    = try(data.ibm_resource_instance.sm_instance[0].id, "")
  registry_namespace = (var.add_container_name_suffix) ? format("%s-%s", var.registry_namespace, random_string.resource_suffix[0].result) : var.registry_namespace
}

################### CD SERICE #######################

resource "ibm_resource_instance" "cd_instance" {
  count             = (var.create_cd_instance) ? 1 : 0
  name              = (var.prefix == "") ? var.cd_instance_name : format("%s-%s", var.prefix, var.cd_instance_name)
  service           = "continuous-delivery"
  plan              = var.cd_service_plan
  location          = var.region
  resource_group_id = data.ibm_resource_group.resource_group.id
}

#################### ICR ###########################

resource "random_string" "resource_suffix" {
  count   = (var.add_container_name_suffix) ? 1 : 0
  length  = var.random_string_length
  special = false
  upper   = false
}

resource "ibm_cr_namespace" "cr_namespace" {
  count             = ((var.registry_namespace != "") && (var.create_icr_namespace == true)) ? 1 : 0
  name              = (var.prefix == "") ? local.registry_namespace : format("%s-%s", var.prefix, local.registry_namespace)
  resource_group_id = var.resource_group_id
}

#################### SECRETS #######################
resource "ibm_iam_api_key" "iam_api_key" {
  count = (var.create_ibmcloud_api_key) ? 1 : 0
  name  = "ibmcloud-api-key"
}

resource "ibm_iam_api_key" "cos_iam_api_key" {
  count = (var.create_cos_api_key) ? 1 : 0
  name  = "cos-api-key"
}

data "external" "signing_keys" {
  count   = ((var.create_signing_key == true) || (var.create_signing_certificate == true)) ? 1 : 0
  program = ["bash", "${path.module}/scripts/gpg_keys.sh"]

  query = {
    name  = var.gpg_name
    email = var.gpg_email
  }
}

####### SECRETS MANAGER #####################

data "ibm_resource_instance" "sm_instance" {
  count             = ((var.sm_name != "") && (var.sm_location != "") && (var.sm_exists == true)) ? 1 : 0
  name              = var.sm_name
  location          = var.sm_location
  resource_group_id = var.resource_group_id
  service           = "secrets-manager"
}

resource "ibm_sm_secret_group" "sm_secret_group" {
  count         = ((var.create_sm_secret_group == true) && (var.sm_exists == true)) ? 1 : 0
  depends_on    = [data.ibm_resource_instance.sm_instance]
  instance_id   = (local.sm_instance_id != "") ? local.sm_instance_id : var.sm_instance_id
  region        = var.sm_location
  name          = var.sm_secret_group_name
  endpoint_type = var.sm_endpoint_type
}

resource "ibm_sm_arbitrary_secret" "secret_ibmcloud_api_key" {
  count           = ((var.create_ibmcloud_api_key == true) && (var.sm_exists == true)) ? 1 : 0
  depends_on      = [ibm_sm_secret_group.sm_secret_group]
  region          = var.sm_location
  instance_id     = (local.sm_instance_id != "") ? local.sm_instance_id : var.sm_instance_id
  secret_group_id = (var.sm_existing_secret_group_id == "") ? ibm_sm_secret_group.sm_secret_group[0].secret_group_id : var.sm_existing_secret_group_id
  name            = var.iam_api_key_secret_name
  description     = "The IBMCloud apikey for running the pipelines."
  labels          = []
  payload         = (var.iam_api_key_secret == "") ? ibm_iam_api_key.iam_api_key[0].apikey : var.iam_api_key_secret
  expiration_date = null
  endpoint_type   = var.sm_endpoint_type
}

resource "ibm_sm_arbitrary_secret" "secret_cos_api_key" {
  count           = ((var.create_cos_api_key == true) && (var.sm_exists == true)) ? 1 : 0
  depends_on      = [ibm_sm_secret_group.sm_secret_group]
  region          = var.sm_location
  instance_id     = (local.sm_instance_id != "") ? local.sm_instance_id : var.sm_instance_id
  secret_group_id = (var.sm_existing_secret_group_id == "") ? ibm_sm_secret_group.sm_secret_group[0].secret_group_id : var.sm_existing_secret_group_id
  name            = var.cos_api_key_secret_name
  description     = "The COS apikey for accessing the associated COS instance."
  labels          = []
  payload         = (var.cos_api_key_secret == "") ? ibm_iam_api_key.cos_iam_api_key[0].apikey : var.cos_api_key_secret
  expiration_date = null
  endpoint_type   = var.sm_endpoint_type
}

resource "ibm_sm_arbitrary_secret" "secret_signing_key" {
  count           = ((var.create_signing_key == true) && (var.sm_exists == true)) ? 1 : 0
  depends_on      = [ibm_sm_secret_group.sm_secret_group, data.external.signing_keys]
  region          = var.sm_location
  instance_id     = (local.sm_instance_id != "") ? local.sm_instance_id : var.sm_instance_id
  secret_group_id = (var.sm_existing_secret_group_id == "") ? ibm_sm_secret_group.sm_secret_group[0].secret_group_id : var.sm_existing_secret_group_id
  name            = var.signing_key_secret_name
  description     = "The gpg signing key for signing images."
  labels          = []
  payload         = (var.signing_key_secret == "") ? data.external.signing_keys[0].result.signingkey : var.signing_key_secret
  expiration_date = null
  endpoint_type   = var.sm_endpoint_type
}

resource "ibm_sm_arbitrary_secret" "secret_signing_certifcate" {
  count           = ((var.create_signing_certificate == true) && (var.sm_exists == true)) ? 1 : 0
  depends_on      = [ibm_sm_secret_group.sm_secret_group, data.external.signing_keys]
  region          = var.sm_location
  instance_id     = (local.sm_instance_id != "") ? local.sm_instance_id : var.sm_instance_id
  secret_group_id = (var.sm_existing_secret_group_id == "") ? ibm_sm_secret_group.sm_secret_group[0].secret_group_id : var.sm_existing_secret_group_id
  name            = var.signing_certifcate_secret_name
  description     = "The public component of the GPG signing key for validating image signatures."
  labels          = []
  payload         = (var.signing_certificate_secret == "") ? data.external.signing_keys[0].result.publickey : var.signing_certificate_secret
  expiration_date = null
  endpoint_type   = var.sm_endpoint_type
}
