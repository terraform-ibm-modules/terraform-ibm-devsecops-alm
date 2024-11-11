locals {
  sm_instance_id  = try(data.ibm_resource_instance.sm_instance[0].guid, "")
  sm_instance_crn = try(data.ibm_resource_instance.sm_instance[0].id, "")

  # Look up the ID of a SM secret group based on secret group name
  # 1) get the list of secret groups where each element is an Object with secret group Details
  # example
  # {
  # created_at  = "2024-06-10T10:33:21.000Z"
  # id          = "b949ad5f-9f7d-e88c-6003-052804cba09c"
  # name        = "mygroup"
  # updated_at  = "2024-07-05T22:05:57.000Z"
  # }
  # 2) Use index to find the index of the object containing the correct name
  # 3) retrive that object from the list and get the ID from it
  secret_group_list = (var.sm_exists) ? data.ibm_sm_secret_groups.secret_groups[0].secret_groups : []
  secret_group_id   = try(local.secret_group_list[index(local.secret_group_list[*].name, var.sm_secret_group_name)].id, "")

  sm_secret_expiration_period_hours = ((var.sm_secret_expiration_period != "") && (var.sm_secret_expiration_period != "0")) ? var.sm_secret_expiration_period * 24 : null

  expiration_date = (local.sm_secret_expiration_period_hours != null) ? timeadd(time_static.timestamp[0].rfc3339, "${local.sm_secret_expiration_period_hours}h") : null

  create_pipeline_api_key = ((var.create_ibmcloud_api_key == true) && (var.sm_exists == true)) ? true : false
  create_cos_api_key      = ((var.create_cos_api_key == true) && (var.sm_exists == true)) ? true : false
}

resource "time_static" "timestamp" {
  count = (local.sm_secret_expiration_period_hours != null) ? 1 : 0
}

####### SECRET GROUP ########################

resource "ibm_iam_service_id" "pipeline_service_id" {
  count = (local.create_pipeline_api_key) ? 1 : 0
  name  = var.service_name_pipeline
}

resource "ibm_iam_service_id" "cos_service_id" {
  count = (local.create_cos_api_key) ? 1 : 0
  name  = var.service_name_cos
}

data "ibm_iam_service_id" "pipeline_service_id" {
  count      = (local.create_pipeline_api_key) ? 1 : 0
  depends_on = [ibm_iam_service_id.pipeline_service_id]
  name       = var.service_name_pipeline
}

data "ibm_iam_service_id" "cos_service_id" {
  count      = (local.create_cos_api_key) ? 1 : 0
  depends_on = [ibm_iam_service_id.cos_service_id]
  name       = var.service_name_cos
}

resource "ibm_iam_service_policy" "cos_policy" {
  count          = (local.create_cos_api_key) ? 1 : 0
  iam_service_id = ibm_iam_service_id.cos_service_id[0].id
  roles          = ["Reader", "Object Writer"]

  resources {
    service           = "cloud-object-storage"
    resource_group_id = data.ibm_resource_group.resource_group.id
  }
}

resource "ibm_iam_service_policy" "pipeline_policy" {
  count          = (local.create_pipeline_api_key) ? 1 : 0
  iam_service_id = ibm_iam_service_id.pipeline_service_id[0].id
  roles          = ["Editor"]

  resources {
    resource_type = "resource-group"
    resource      = data.ibm_resource_group.resource_group.id
  }
}

resource "ibm_iam_service_policy" "toolchain_policy" {
  count          = (local.create_pipeline_api_key) ? 1 : 0
  iam_service_id = ibm_iam_service_id.pipeline_service_id[0].id
  roles          = ["Viewer", "Operator"]
  resources {
    service           = "toolchain"
    resource_group_id = data.ibm_resource_group.resource_group.id
  }
}

resource "ibm_iam_service_policy" "cr_policy" {
  count          = (local.create_pipeline_api_key) ? 1 : 0
  iam_service_id = ibm_iam_service_id.pipeline_service_id[0].id
  roles          = ["Manager"]
  resources {
    service = "container-registry"
  }
}

resource "ibm_iam_service_policy" "cd_policy" {
  count          = (local.create_pipeline_api_key) ? 1 : 0
  iam_service_id = ibm_iam_service_id.pipeline_service_id[0].id
  roles          = ["Writer"]
  resources {
    service           = "continuous-delivery"
    resource_group_id = data.ibm_resource_group.resource_group.id
  }
}

resource "ibm_iam_service_policy" "kube_policy" {
  count          = ((var.create_kubernetes_access_policy == true) && (local.create_pipeline_api_key == true)) ? 1 : 0
  iam_service_id = ibm_iam_service_id.pipeline_service_id[0].id
  roles          = ["Editor"]
  resources {
    service           = "kubernetes"
    resource_group_id = data.ibm_resource_group.resource_group.id
  }
}

resource "ibm_iam_service_policy" "ce_policy" {
  count          = ((var.create_code_engine_access_policy) && (local.create_pipeline_api_key == true)) ? 1 : 0
  iam_service_id = ibm_iam_service_id.pipeline_service_id[0].id
  roles          = ["Editor"]
  resources {
    service           = "code-engine"
    resource_group_id = data.ibm_resource_group.resource_group.id
  }
}

####### SECRETS MANAGER #####################

data "ibm_resource_group" "resource_group" {
  name = var.sm_resource_group
}

data "ibm_resource_instance" "sm_instance" {
  count             = ((var.sm_name != "") && (var.sm_location != "") && (var.sm_exists == true)) ? 1 : 0
  name              = var.sm_name
  location          = var.sm_location
  resource_group_id = data.ibm_resource_group.resource_group.id
  service           = "secrets-manager"
}

data "ibm_sm_secret_groups" "secret_groups" {
  count         = (var.sm_exists) ? 1 : 0
  instance_id   = (local.sm_instance_id != "") ? local.sm_instance_id : var.sm_instance_id
  region        = var.sm_location
  endpoint_type = var.sm_endpoint_type
}

#################### SECRETS #######################
data "external" "signing_keys" {
  count   = (var.create_signing_key) ? 1 : 0
  program = ["bash", "${path.module}/scripts/gpg_keys.sh"]

  query = {
    name               = var.gpg_name
    email              = var.gpg_email
    apikey             = var.ibmcloud_api_key
    instance_id        = (local.sm_instance_id != "") ? local.sm_instance_id : var.sm_instance_id
    region             = var.sm_location
    secret_group_id    = (var.create_secret_group == false) ? data.ibm_sm_secret_group.existing_sm_secret_group[0].secret_group_id : ibm_sm_secret_group.sm_secret_group[0].secret_group_id
    signing_key_name   = var.signing_key_secret_name
    signing_cert_name  = var.signing_certifcate_secret_name
    rotate_signing_key = var.rotate_signing_key
  }
}

resource "ibm_sm_secret_group" "sm_secret_group" {
  count         = ((var.create_secret_group == true) && (var.sm_exists == true)) ? 1 : 0
  depends_on    = [data.ibm_resource_instance.sm_instance]
  instance_id   = (local.sm_instance_id != "") ? local.sm_instance_id : var.sm_instance_id
  region        = var.sm_location
  name          = var.sm_secret_group_name
  endpoint_type = var.sm_endpoint_type
}

data "ibm_sm_secret_group" "existing_sm_secret_group" {
  count           = ((var.create_secret_group == false) && (var.sm_exists == true) && (local.secret_group_id != "")) ? 1 : 0
  instance_id     = (local.sm_instance_id != "") ? local.sm_instance_id : var.sm_instance_id
  region          = var.sm_location
  secret_group_id = local.secret_group_id
  endpoint_type   = var.sm_endpoint_type
}

resource "ibm_sm_arbitrary_secret" "secret_signing_key" {
  count           = ((var.create_signing_key == true) && (var.sm_exists == true)) ? 1 : 0
  depends_on      = [ibm_sm_secret_group.sm_secret_group, data.external.signing_keys]
  region          = var.sm_location
  instance_id     = (local.sm_instance_id != "") ? local.sm_instance_id : var.sm_instance_id
  secret_group_id = (var.create_secret_group == false) ? data.ibm_sm_secret_group.existing_sm_secret_group[0].secret_group_id : ibm_sm_secret_group.sm_secret_group[0].secret_group_id
  name            = var.signing_key_secret_name
  description     = "The gpg signing key for signing images."
  labels          = []
  payload         = (var.signing_key_secret == "") ? data.external.signing_keys[0].result.signingkey : var.signing_key_secret
  expiration_date = local.expiration_date
  endpoint_type   = var.sm_endpoint_type
}

resource "ibm_sm_arbitrary_secret" "secret_signing_certifcate" {
  count           = ((var.create_signing_key == true) && (var.sm_exists == true)) ? 1 : 0
  depends_on      = [ibm_sm_secret_group.sm_secret_group, data.external.signing_keys]
  region          = var.sm_location
  instance_id     = (local.sm_instance_id != "") ? local.sm_instance_id : var.sm_instance_id
  secret_group_id = (var.create_secret_group == false) ? data.ibm_sm_secret_group.existing_sm_secret_group[0].secret_group_id : ibm_sm_secret_group.sm_secret_group[0].secret_group_id
  name            = var.signing_certifcate_secret_name
  description     = "The public component of the GPG signing key for validating image signatures."
  labels          = []
  payload         = (var.signing_certificate_secret == "") ? data.external.signing_keys[0].result.publickey : var.signing_certificate_secret
  expiration_date = local.expiration_date
  endpoint_type   = var.sm_endpoint_type
}

resource "ibm_sm_arbitrary_secret" "git_token" {
  count           = ((var.create_git_token == true) && (var.sm_exists == true)) ? 1 : 0
  depends_on      = [ibm_sm_secret_group.sm_secret_group]
  region          = var.sm_location
  instance_id     = (local.sm_instance_id != "") ? local.sm_instance_id : var.sm_instance_id
  secret_group_id = (var.create_secret_group == false) ? data.ibm_sm_secret_group.existing_sm_secret_group[0].secret_group_id : ibm_sm_secret_group.sm_secret_group[0].secret_group_id
  name            = var.repo_git_token_secret_name
  description     = "A personal access token for accessing your repositories."
  labels          = []
  payload         = var.repo_git_token_secret_value
  expiration_date = local.expiration_date
  endpoint_type   = var.sm_endpoint_type
}

################## IAM CREDENTIALS###############################

resource "ibm_sm_iam_credentials_configuration" "iam_credentials_configuration" {
  count       = ((local.create_pipeline_api_key) || (local.create_cos_api_key)) ? 1 : 0
  instance_id = (local.sm_instance_id != "") ? local.sm_instance_id : var.sm_instance_id
  region      = var.sm_location
  name        = "iam_credentials_config"
  api_key     = var.ibmcloud_api_key
}

resource "ibm_sm_iam_credentials_secret" "iam_pipeline_apikey_credentials_secret" {
  count       = (local.create_pipeline_api_key) ? 1 : 0
  depends_on  = [ibm_sm_secret_group.sm_secret_group, data.ibm_sm_secret_group.existing_sm_secret_group, ibm_sm_iam_credentials_configuration.iam_credentials_configuration]
  instance_id = data.ibm_resource_instance.sm_instance[0].guid
  region      = var.sm_location
  name        = var.iam_api_key_secret_name
  description = "Extended description for this secret."
  rotation {
    auto_rotate = true
    interval    = var.rotation_period
    unit        = "day"
  }
  secret_group_id = (var.create_secret_group) ? ibm_sm_secret_group.sm_secret_group[0].secret_group_id : data.ibm_sm_secret_group.existing_sm_secret_group[0].secret_group_id
  service_id      = data.ibm_iam_service_id.pipeline_service_id[0].service_ids[0].id
  ttl             = "7776000"
}

resource "ibm_sm_iam_credentials_secret" "iam_cos_apikey_credentials_secret" {
  count       = (local.create_cos_api_key) ? 1 : 0
  depends_on  = [ibm_sm_secret_group.sm_secret_group, data.ibm_sm_secret_group.existing_sm_secret_group, ibm_sm_iam_credentials_configuration.iam_credentials_configuration]
  instance_id = data.ibm_resource_instance.sm_instance[0].guid
  region      = var.sm_location
  name        = var.cos_api_key_secret_name
  description = "Extended description for this secret."
  rotation {
    auto_rotate = true
    interval    = var.rotation_period
    unit        = "day"
  }
  secret_group_id = (var.create_secret_group) ? ibm_sm_secret_group.sm_secret_group[0].secret_group_id : data.ibm_sm_secret_group.existing_sm_secret_group[0].secret_group_id
  service_id      = data.ibm_iam_service_id.cos_service_id[0].service_ids[0].id
  ttl             = "7776000"
}
