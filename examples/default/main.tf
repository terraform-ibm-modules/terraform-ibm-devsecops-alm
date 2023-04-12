module "terraform_devsecops_alm" {
  source                   = "git::https://github.com/terraform-ibm-modules/terraform-ibm-devsecops-alm?ref=v1.0.4-beta.2"
  ibmcloud_api_key         = var.ibmcloud_api_key
  toolchain_resource_group = var.toolchain_resource_group
  toolchain_region         = var.toolchain_region
  ci_registry_namespace    = var.ci_registry_namespace
  ci_registry_region       = var.ci_registry_region
  ci_cluster_name          = var.ci_cluster_name
  ci_cluster_namespace     = var.ci_cluster_namespace
  ci_dev_region            = var.ci_dev_region
  ci_dev_resource_group    = var.ci_dev_resource_group
  cd_cluster_name          = var.cd_cluster_name
  cd_cluster_namespace     = var.cd_cluster_namespace
  enable_key_protect       = var.enable_key_protect
  enable_secrets_manager   = var.enable_secrets_manager
  kp_resource_group        = var.kp_resource_group
  kp_name                  = var.kp_name
  kp_location              = var.kp_location
  sm_resource_group        = var.sm_resource_group
  sm_name                  = var.sm_name
  sm_location              = var.sm_location
  sm_secret_group          = var.sm_secret_group
}
