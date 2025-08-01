module "terraform_devsecops_alm" {
  source                   = "git::https://github.com/terraform-ibm-modules/terraform-ibm-devsecops-alm?ref=v2.8.1"
  ibmcloud_api_key         = var.ibmcloud_api_key
  toolchain_resource_group = var.toolchain_resource_group
  toolchain_region         = var.toolchain_region
  registry_namespace       = var.registry_namespace
  cluster_name             = var.cluster_name
  enable_key_protect       = var.enable_key_protect
  enable_secrets_manager   = var.enable_secrets_manager
  kp_resource_group        = var.kp_resource_group
  kp_name                  = var.kp_name
  kp_location              = var.kp_location
  create_ci_toolchain      = var.create_ci_toolchain
  create_cd_toolchain      = var.create_cd_toolchain
  create_cc_toolchain      = var.create_cc_toolchain
  #disabling authorization_policy_creation as it seems to be unstable for the unit tests
  authorization_policy_creation = "disabled"
}
