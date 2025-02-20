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

  #determine if an api key should be created
  #can either be a service api key, a standard api key or a provided api key
  create_api_key = ((var.create_ibmcloud_api_key == true) && (var.sm_exists == true)) ? true : false

  #can be a service api key or a provided api key
  create_cos_api_key = ((var.create_cos_api_key == true) && (var.sm_exists == true)) ? true : false

  #determine if the key should be a service api key or a regular api key
  # Is a service api key if the override is set to false

  create_pipeline_service_api_key = (local.create_api_key == true && var.force_create_standard_api_key == false && var.iam_api_key_secret_value == "") ? true : false
  #create_cos_service_api_key      = ((local.create_cos_api_key == true) && (var.force_create_standard_api_key == false)) ? true : false
  create_auto_rotatable_cos_service_api_key = (local.create_cos_api_key == true && var.force_create_standard_api_key == false && var.cos_api_key_secret_value == "") ? true : false

  # Is an api key if the override is set to true
  create_pipeline_api_key               = (local.create_api_key == true && var.force_create_standard_api_key == true && var.iam_api_key_secret_value == "") ? true : false
  create_non_auto_rotatable_cos_api_key = (local.create_cos_api_key == true && var.force_create_standard_api_key == true && var.cos_api_key_secret_value == "") ? true : false

  create_cos_service_api_key = (local.create_auto_rotatable_cos_service_api_key == true || local.create_non_auto_rotatable_cos_api_key == true) ? true : false

  create_provided_api_key     = (local.create_api_key == true && var.iam_api_key_secret_value != "") ? true : false
  create_provided_cos_api_key = (local.create_cos_api_key == true && var.cos_api_key_secret_value != "") ? true : false
}

resource "time_static" "timestamp" {
  count = (local.sm_secret_expiration_period_hours != null) ? 1 : 0
}

####### SECRET GROUP ########################

resource "ibm_iam_service_id" "pipeline_service_id" {
  count = (local.create_pipeline_service_api_key) ? 1 : 0
  name  = var.service_name_pipeline
}

resource "ibm_iam_service_id" "cos_service_id" {
  count = (local.create_cos_service_api_key) ? 1 : 0
  name  = var.service_name_cos
}

data "ibm_iam_service_id" "pipeline_service_id" {
  count      = (local.create_pipeline_service_api_key) ? 1 : 0
  depends_on = [ibm_iam_service_id.pipeline_service_id]
  name       = var.service_name_pipeline
}

data "ibm_iam_service_id" "cos_service_id" {
  count      = (local.create_cos_service_api_key) ? 1 : 0
  depends_on = [ibm_iam_service_id.cos_service_id]
  name       = var.service_name_cos
}

resource "ibm_iam_service_policy" "cos_policy" {
  count          = (local.create_cos_service_api_key) ? 1 : 0
  iam_service_id = ibm_iam_service_id.cos_service_id[0].id
  roles          = ["Reader", "Object Writer"]

  resources {
    service           = "cloud-object-storage"
    resource_group_id = data.ibm_resource_group.resource_group.id
  }
}

resource "ibm_iam_service_policy" "pipeline_policy" {
  count          = (local.create_pipeline_service_api_key) ? 1 : 0
  iam_service_id = ibm_iam_service_id.pipeline_service_id[0].id
  roles          = ["Editor"]

  resources {
    resource_type = "resource-group"
    resource      = data.ibm_resource_group.resource_group.id
  }
}

resource "ibm_iam_service_policy" "cr_policy" {
  count          = (local.create_pipeline_service_api_key) ? 1 : 0
  iam_service_id = ibm_iam_service_id.pipeline_service_id[0].id
  roles          = ["Manager"]
  resources {
    service = "container-registry"
  }
}

resource "ibm_iam_service_policy" "cd_policy" {
  count          = (local.create_pipeline_service_api_key) ? 1 : 0
  iam_service_id = ibm_iam_service_id.pipeline_service_id[0].id
  roles          = ["Writer"]
  resources {
    service           = "continuous-delivery"
    resource_group_id = data.ibm_resource_group.resource_group.id
  }
}

resource "ibm_iam_service_policy" "kube_policy" {
  count          = ((var.create_kubernetes_access_policy == true) && (local.create_pipeline_service_api_key == true)) ? 1 : 0
  iam_service_id = ibm_iam_service_id.pipeline_service_id[0].id
  roles          = ["Manager", "Editor"]
  resources {
    service = "containers-kubernetes"
  }
}

resource "ibm_iam_service_policy" "ce_policy" {
  count          = ((var.create_code_engine_access_policy == true) && (local.create_pipeline_service_api_key == true)) ? 1 : 0
  iam_service_id = ibm_iam_service_id.pipeline_service_id[0].id
  roles          = ["Manager", "Editor"]
  resources {
    service           = "codeengine"
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
  count           = ((var.create_git_token == true) && (var.sm_exists == true) && (var.repo_git_token_secret_name != "") && (var.repo_git_token_secret_value != "")) ? 1 : 0
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

resource "ibm_sm_arbitrary_secret" "private_worker_secret" {
  count           = ((var.create_privateworker_secret == true) && (var.sm_exists == true)) ? 1 : 0
  depends_on      = [ibm_sm_secret_group.sm_secret_group]
  region          = var.sm_location
  instance_id     = (local.sm_instance_id != "") ? local.sm_instance_id : var.sm_instance_id
  secret_group_id = (var.create_secret_group == false) ? data.ibm_sm_secret_group.existing_sm_secret_group[0].secret_group_id : ibm_sm_secret_group.sm_secret_group[0].secret_group_id
  name            = var.privateworker_secret_name
  description     = "A service api key for a private worker."
  labels          = []
  payload         = var.privateworker_secret_value
  expiration_date = local.expiration_date
  endpoint_type   = var.sm_endpoint_type
}

################## IAM CREDENTIALS SERVICE API KEYS ###############################

resource "ibm_sm_iam_credentials_configuration" "iam_credentials_configuration" {
  count         = (local.create_pipeline_service_api_key) ? 1 : 0
  instance_id   = (local.sm_instance_id != "") ? local.sm_instance_id : var.sm_instance_id
  region        = var.sm_location
  name          = "iam_credentials_config"
  api_key       = var.ibmcloud_api_key
  endpoint_type = var.sm_endpoint_type
}

resource "ibm_sm_iam_credentials_secret" "iam_pipeline_apikey_credentials_secret" {
  count       = (local.create_pipeline_service_api_key) ? 1 : 0
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
  endpoint_type   = var.sm_endpoint_type
}

resource "ibm_sm_iam_credentials_secret" "iam_cos_apikey_credentials_secret" {
  count       = (local.create_auto_rotatable_cos_service_api_key) ? 1 : 0
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
  endpoint_type   = var.sm_endpoint_type
}

####### IAM API KEY ####################################

resource "ibm_iam_api_key" "iam_api_key" {
  count = (local.create_pipeline_api_key) ? 1 : 0
  name  = "ibmcloud-api-key"
}

resource "ibm_iam_service_api_key" "cos_service_api_key" {
  count          = (local.create_non_auto_rotatable_cos_api_key) ? 1 : 0
  name           = "cos-service-api-key"
  iam_service_id = ibm_iam_service_id.cos_service_id[0].iam_id
}

resource "ibm_sm_arbitrary_secret" "secret_ibmcloud_api_key" {
  count           = (local.create_pipeline_api_key == true || local.create_provided_api_key == true) ? 1 : 0
  depends_on      = [ibm_sm_secret_group.sm_secret_group]
  region          = var.sm_location
  instance_id     = (local.sm_instance_id != "") ? local.sm_instance_id : var.sm_instance_id
  secret_group_id = (var.create_secret_group == false) ? data.ibm_sm_secret_group.existing_sm_secret_group[0].secret_group_id : ibm_sm_secret_group.sm_secret_group[0].secret_group_id
  name            = var.iam_api_key_secret_name
  description     = "The IBMCloud apikey for running the pipelines."
  labels          = []
  payload         = (local.create_provided_api_key) ? var.iam_api_key_secret_value : ibm_iam_api_key.iam_api_key[0].apikey
  expiration_date = local.expiration_date
  endpoint_type   = var.sm_endpoint_type
}

resource "ibm_sm_arbitrary_secret" "secret_cos_api_key" {
  count           = (local.create_non_auto_rotatable_cos_api_key == true || local.create_provided_cos_api_key == true) ? 1 : 0
  depends_on      = [ibm_sm_secret_group.sm_secret_group]
  region          = var.sm_location
  instance_id     = (local.sm_instance_id != "") ? local.sm_instance_id : var.sm_instance_id
  secret_group_id = (var.create_secret_group == false) ? data.ibm_sm_secret_group.existing_sm_secret_group[0].secret_group_id : ibm_sm_secret_group.sm_secret_group[0].secret_group_id
  name            = var.cos_api_key_secret_name
  description     = "The COS apikey for accessing the associated COS instance."
  labels          = []
  payload         = (local.create_provided_cos_api_key) ? var.cos_api_key_secret_value : ibm_iam_service_api_key.cos_service_api_key[0].apikey
  expiration_date = local.expiration_date
  endpoint_type   = var.sm_endpoint_type
}

######## ACCESS GROUP ####################

resource "ibm_iam_access_group" "toolchain_access_group" {
  count       = (var.create_access_group == true) ? 1 : 0
  name        = var.toolchain_access_group_name
  description = "Access group used for DevSecOps toolchain operations."
}


#resource "ibm_iam_access_group_members" "service_ids" {
#  count           = (var.create_access_group == true && local.create_pipeline_service_api_key) ? 1 : 0
#  access_group_id = ibm_iam_access_group.toolchain_access_group[0].id
#  iam_service_ids = local.service_id_list
#}


resource "ibm_iam_access_group_policy" "resource_group_policy" {
  count           = (var.create_access_group == true && local.create_api_key == true) ? 1 : 0
  access_group_id = ibm_iam_access_group.toolchain_access_group[0].id
  roles           = ["Editor"]
  resources {
    resource_type = "resource-group"
    resource      = data.ibm_resource_group.resource_group.id
  }
}

resource "ibm_iam_access_group_policy" "toolchain_group_policy" {
  count           = (var.create_access_group == true && local.create_api_key == true) ? 1 : 0
  access_group_id = ibm_iam_access_group.toolchain_access_group[0].id
  roles           = ["Editor"]
  resources {
    service           = "toolchain"
    resource_group_id = data.ibm_resource_group.resource_group.id
  }
}

resource "ibm_iam_access_group_policy" "sm_group_policy" {
  count           = (var.create_access_group == true && local.create_api_key == true) ? 1 : 0
  access_group_id = ibm_iam_access_group.toolchain_access_group[0].id
  roles           = ["Manager"]
  resources {
    service = "secrets-manager"
  }
}

### Access policies specific to restricting the use of a standard api keys to users added to the access group
resource "ibm_iam_access_group_policy" "cr_group_policy" {
  count           = (var.create_access_group == true && (local.create_pipeline_api_key == true || local.create_provided_api_key == true)) ? 1 : 0
  access_group_id = ibm_iam_access_group.toolchain_access_group[0].id
  roles           = ["Manager"]
  resources {
    service = "container-registry"
  }
}

resource "ibm_iam_access_group_policy" "continuous_delivery_group_policy" {
  count           = (var.create_access_group == true && (local.create_pipeline_api_key == true || local.create_provided_api_key == true)) ? 1 : 0
  access_group_id = ibm_iam_access_group.toolchain_access_group[0].id
  roles           = ["Writer"]
  resources {
    service           = "continuous-delivery"
    resource_group_id = data.ibm_resource_group.resource_group.id
  }
}

resource "ibm_iam_access_group_policy" "ce_group_policy" {
  count           = (var.create_access_group == true && var.create_code_engine_access_policy == true && (local.create_pipeline_api_key == true || local.create_provided_api_key == true)) ? 1 : 0
  access_group_id = ibm_iam_access_group.toolchain_access_group[0].id
  roles           = ["Manager", "Editor"]
  resources {
    service           = "codeengine"
    resource_group_id = data.ibm_resource_group.resource_group.id
  }
}

resource "ibm_iam_access_group_policy" "kube_group_policy" {
  count           = (var.create_access_group == true && var.create_kubernetes_access_policy == true && (local.create_pipeline_api_key == true || local.create_provided_api_key == true)) ? 1 : 0
  access_group_id = ibm_iam_access_group.toolchain_access_group[0].id
  roles           = ["Manager", "Editor"]
  resources {
    service           = "containers-kubernetes"
    resource_group_id = data.ibm_resource_group.resource_group.id
  }
}
