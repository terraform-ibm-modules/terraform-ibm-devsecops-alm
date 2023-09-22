<!-- BEGIN MODULE HOOK -->

<!-- Update the title to match the module name and add a description -->
## DevSecOps Application Lifecycle Management
<!-- UPDATE BADGE: Update the link for the following badge-->
![Stable (With quality checks)](https://img.shields.io/badge/Status-Stable%20(With%20quality%20checks)-green)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![latest release](https://img.shields.io/github/v/release/terraform-ibm-modules/terraform-ibm-devsecops-alm?logo=GitHub&sort=semver)](https://github.com/terraform-ibm-modules/terraform-ibm-devsecops-alm/releases/latest)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

A Terraform module for provisioning the DevSecOps CI, CD, and CC toolchains.

<!-- Remove the content in this H2 heading after completing the steps -->
<!-- Remove the content in this previous H2 heading -->

## Reference architectures

![Architecture diagram for 'DevSecOps CI, CD, CC toolchains'.](/reference-architectures/diagram-deploy-arch-ibm-devsecops-alm-diagram.svg "Architecture diagram")

## Usage

```hcl
module "terraform_devsecops_alm" {
  source                   = "git::https://github.com/terraform-ibm-modules/terraform-ibm-devsecops-alm?ref=v1.0.4"
  toolchain_region         = var.toolchain_region
  toolchain_resource_group = var.toolchain_resource_group
  registry_namespace       = var.registry_namespace
  cluster_name             = var.cluster_name
  sm_resource_group        = var.sm_resource_group
  sm_name                  = var.sm_name
  sm_location              = var.sm_location
  sm_secret_group          = var.sm_secret_group
}

```

## Required IAM access policies

<!-- NO PERMISSIONS FOR MODULE
If no permissions are required for the module, uncomment the following
statement instead the previous block.
-->

<!-- No permissions are needed to run this module.-->
<!-- END MODULE HOOK -->
<!-- BEGIN EXAMPLES HOOK -->
## Examples

- [ Default example](examples/default)
- [ Bring your own app example](examples/devsecops-ci-toolchain-bring-your-own-app)
- [ Key Protect and CI only example](examples/devsecops-ci-toolchain-with-key-protect)
<!-- END EXAMPLES HOOK -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >=1.57.0 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_devsecops_cc_toolchain"></a> [devsecops\_cc\_toolchain](#module\_devsecops\_cc\_toolchain) | git::https://github.com/terraform-ibm-modules/terraform-ibm-devsecops-cc-toolchain | v1.0.8 |
| <a name="module_devsecops_cd_toolchain"></a> [devsecops\_cd\_toolchain](#module\_devsecops\_cd\_toolchain) | git::https://github.com/terraform-ibm-modules/terraform-ibm-devsecops-cd-toolchain | v1.0.9 |
| <a name="module_devsecops_ci_toolchain"></a> [devsecops\_ci\_toolchain](#module\_devsecops\_ci\_toolchain) | git::https://github.com/terraform-ibm-modules/terraform-ibm-devsecops-ci-toolchain | v1.0.8 |

### Resources

No resources.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_authorization_policy_creation"></a> [authorization\_policy\_creation](#input\_authorization\_policy\_creation) | Disable Toolchain Service to Secrets Manager Service authorization policy creation. To disable set the value to `disabled`. This applies to the CI, CD, and CC toolchains. To set separately, see `ci_authorization_policy_creation`, `cd_authorization_policy_creation`, and `cc_authorization_policy_creation`. | `string` | `""` | no |
| <a name="input_cc_app_group"></a> [cc\_app\_group](#input\_cc\_app\_group) | Specify user or group for app repo. | `string` | `""` | no |
| <a name="input_cc_app_repo_auth_type"></a> [cc\_app\_repo\_auth\_type](#input\_cc\_app\_repo\_auth\_type) | Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'. | `string` | `""` | no |
| <a name="input_cc_app_repo_branch"></a> [cc\_app\_repo\_branch](#input\_cc\_app\_repo\_branch) | The default branch of the app repo. | `string` | `"master"` | no |
| <a name="input_cc_app_repo_git_id"></a> [cc\_app\_repo\_git\_id](#input\_cc\_app\_repo\_git\_id) | The Git Id of the repository. | `string` | `""` | no |
| <a name="input_cc_app_repo_git_provider"></a> [cc\_app\_repo\_git\_provider](#input\_cc\_app\_repo\_git\_provider) | The type of the Git provider. | `string` | `"hostedgit"` | no |
| <a name="input_cc_app_repo_git_token_secret_name"></a> [cc\_app\_repo\_git\_token\_secret\_name](#input\_cc\_app\_repo\_git\_token\_secret\_name) | Name of the Git token secret in the secret provider. | `string` | `""` | no |
| <a name="input_cc_app_repo_secret_group"></a> [cc\_app\_repo\_secret\_group](#input\_cc\_app\_repo\_secret\_group) | Secret group prefix for the App repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_cc_app_repo_url"></a> [cc\_app\_repo\_url](#input\_cc\_app\_repo\_url) | This Git URL for the application repository. | `string` | `""` | no |
| <a name="input_cc_authorization_policy_creation"></a> [cc\_authorization\_policy\_creation](#input\_cc\_authorization\_policy\_creation) | Disable Toolchain service to Secrets Manager Service authorization policy creation. | `string` | `""` | no |
| <a name="input_cc_compliance_base_image"></a> [cc\_compliance\_base\_image](#input\_cc\_compliance\_base\_image) | Pipeline baseimage to run most of the built-in pipeline code. | `string` | `""` | no |
| <a name="input_cc_compliance_pipeline_branch"></a> [cc\_compliance\_pipeline\_branch](#input\_cc\_compliance\_pipeline\_branch) | The CC Pipeline Compliance Pipeline branch. | `string` | `""` | no |
| <a name="input_cc_compliance_pipeline_group"></a> [cc\_compliance\_pipeline\_group](#input\_cc\_compliance\_pipeline\_group) | Specify user or group for compliance pipline repo. | `string` | `""` | no |
| <a name="input_cc_compliance_pipeline_repo_auth_type"></a> [cc\_compliance\_pipeline\_repo\_auth\_type](#input\_cc\_compliance\_pipeline\_repo\_auth\_type) | Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'. | `string` | `""` | no |
| <a name="input_cc_compliance_pipeline_repo_git_token_secret_name"></a> [cc\_compliance\_pipeline\_repo\_git\_token\_secret\_name](#input\_cc\_compliance\_pipeline\_repo\_git\_token\_secret\_name) | Name of the Git token secret in the secret provider. | `string` | `""` | no |
| <a name="input_cc_compliance_pipeline_repo_secret_group"></a> [cc\_compliance\_pipeline\_repo\_secret\_group](#input\_cc\_compliance\_pipeline\_repo\_secret\_group) | Secret group prefix for the Compliance Pipeline repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_cc_cos_api_key_secret_group"></a> [cc\_cos\_api\_key\_secret\_group](#input\_cc\_cos\_api\_key\_secret\_group) | Secret group prefix for the COS API key secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_cc_cos_api_key_secret_name"></a> [cc\_cos\_api\_key\_secret\_name](#input\_cc\_cos\_api\_key\_secret\_name) | Name of the COS API key secret in the secret provider. | `string` | `""` | no |
| <a name="input_cc_cos_bucket_name"></a> [cc\_cos\_bucket\_name](#input\_cc\_cos\_bucket\_name) | COS bucket name. | `string` | `""` | no |
| <a name="input_cc_cos_endpoint"></a> [cc\_cos\_endpoint](#input\_cc\_cos\_endpoint) | COS endpoint name. | `string` | `""` | no |
| <a name="input_cc_doi_environment"></a> [cc\_doi\_environment](#input\_cc\_doi\_environment) | DevOps Insights environment for DevSecOps CD deployment. | `string` | `""` | no |
| <a name="input_cc_doi_toolchain_id"></a> [cc\_doi\_toolchain\_id](#input\_cc\_doi\_toolchain\_id) | DevOps Insights toolchain ID to link to. | `string` | `""` | no |
| <a name="input_cc_enable_key_protect"></a> [cc\_enable\_key\_protect](#input\_cc\_enable\_key\_protect) | Enable the Key Protect integration. | `bool` | `false` | no |
| <a name="input_cc_enable_pipeline_dockerconfigjson"></a> [cc\_enable\_pipeline\_dockerconfigjson](#input\_cc\_enable\_pipeline\_dockerconfigjson) | Enable to add the pipeline-dockerconfigjson property to the pipeline properties. | `bool` | `false` | no |
| <a name="input_cc_enable_secrets_manager"></a> [cc\_enable\_secrets\_manager](#input\_cc\_enable\_secrets\_manager) | Enable the Secrets Manager integration. | `bool` | `false` | no |
| <a name="input_cc_enable_slack"></a> [cc\_enable\_slack](#input\_cc\_enable\_slack) | Set to true to create the integration. | `bool` | `false` | no |
| <a name="input_cc_environment_tag"></a> [cc\_environment\_tag](#input\_cc\_environment\_tag) | Tag name that represents the target environment in the inventory. Example: prod\_latest. | `string` | `""` | no |
| <a name="input_cc_event_notifications_crn"></a> [cc\_event\_notifications\_crn](#input\_cc\_event\_notifications\_crn) | Set the Event Notifications CRN to create an Events Notification integration. | `string` | `""` | no |
| <a name="input_cc_evidence_group"></a> [cc\_evidence\_group](#input\_cc\_evidence\_group) | Specify Git user or group for evidence repository. | `string` | `""` | no |
| <a name="input_cc_evidence_repo_auth_type"></a> [cc\_evidence\_repo\_auth\_type](#input\_cc\_evidence\_repo\_auth\_type) | Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat' | `string` | `""` | no |
| <a name="input_cc_evidence_repo_git_token_secret_name"></a> [cc\_evidence\_repo\_git\_token\_secret\_name](#input\_cc\_evidence\_repo\_git\_token\_secret\_name) | Name of the Git token secret in the secret provider. | `string` | `""` | no |
| <a name="input_cc_evidence_repo_secret_group"></a> [cc\_evidence\_repo\_secret\_group](#input\_cc\_evidence\_repo\_secret\_group) | Secret group prefix for the Evidence repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_cc_inventory_group"></a> [cc\_inventory\_group](#input\_cc\_inventory\_group) | Specify Git user or group for inventory repository. | `string` | `""` | no |
| <a name="input_cc_inventory_repo_auth_type"></a> [cc\_inventory\_repo\_auth\_type](#input\_cc\_inventory\_repo\_auth\_type) | Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'. | `string` | `""` | no |
| <a name="input_cc_inventory_repo_git_token_secret_name"></a> [cc\_inventory\_repo\_git\_token\_secret\_name](#input\_cc\_inventory\_repo\_git\_token\_secret\_name) | Name of the Git token secret in the secret provider. | `string` | `""` | no |
| <a name="input_cc_inventory_repo_secret_group"></a> [cc\_inventory\_repo\_secret\_group](#input\_cc\_inventory\_repo\_secret\_group) | Secret group prefix for the Inventory repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_cc_issues_group"></a> [cc\_issues\_group](#input\_cc\_issues\_group) | Specify Git user or group for issues repository. | `string` | `""` | no |
| <a name="input_cc_issues_repo_auth_type"></a> [cc\_issues\_repo\_auth\_type](#input\_cc\_issues\_repo\_auth\_type) | Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'. | `string` | `""` | no |
| <a name="input_cc_issues_repo_git_token_secret_name"></a> [cc\_issues\_repo\_git\_token\_secret\_name](#input\_cc\_issues\_repo\_git\_token\_secret\_name) | Name of the Git token secret in the secret provider. | `string` | `""` | no |
| <a name="input_cc_issues_repo_secret_group"></a> [cc\_issues\_repo\_secret\_group](#input\_cc\_issues\_repo\_secret\_group) | Secret group prefix for the Issues repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_cc_kp_location"></a> [cc\_kp\_location](#input\_cc\_kp\_location) | IBM Cloud location/region containing the Key Protect instance. | `string` | `""` | no |
| <a name="input_cc_kp_name"></a> [cc\_kp\_name](#input\_cc\_kp\_name) | Name of the Key Protect instance where the secrets are stored. | `string` | `""` | no |
| <a name="input_cc_kp_resource_group"></a> [cc\_kp\_resource\_group](#input\_cc\_kp\_resource\_group) | The resource group containing the Key Protect instance for your secrets. | `string` | `""` | no |
| <a name="input_cc_link_to_doi_toolchain"></a> [cc\_link\_to\_doi\_toolchain](#input\_cc\_link\_to\_doi\_toolchain) | Enable a link to a DevOps Insights instance in another toolchain, true or false. | `bool` | `true` | no |
| <a name="input_cc_opt_in_auto_close"></a> [cc\_opt\_in\_auto\_close](#input\_cc\_opt\_in\_auto\_close) | Enables auto-closing of issues coming from vulnerabilities, once the vulnerability is no longer detected by the CC pipeline run. | `string` | `"1"` | no |
| <a name="input_cc_opt_in_dynamic_api_scan"></a> [cc\_opt\_in\_dynamic\_api\_scan](#input\_cc\_opt\_in\_dynamic\_api\_scan) | To enable the OWASP Zap API scan. '1' enable or '0' disable. | `string` | `""` | no |
| <a name="input_cc_opt_in_dynamic_scan"></a> [cc\_opt\_in\_dynamic\_scan](#input\_cc\_opt\_in\_dynamic\_scan) | To enable the OWASP Zap scan. '1' enable or '0' disable. | `string` | `""` | no |
| <a name="input_cc_opt_in_dynamic_ui_scan"></a> [cc\_opt\_in\_dynamic\_ui\_scan](#input\_cc\_opt\_in\_dynamic\_ui\_scan) | To enable the OWASP Zap UI scan. '1' enable or '0' disable. | `string` | `""` | no |
| <a name="input_cc_peer_review_compliance"></a> [cc\_peer\_review\_compliance](#input\_cc\_peer\_review\_compliance) | Set to `0` to disable. Set to `1` to enable peer review evidence collection. | `string` | `""` | no |
| <a name="input_cc_pipeline_config_group"></a> [cc\_pipeline\_config\_group](#input\_cc\_pipeline\_config\_group) | Specify user or group for pipeline config repo. | `string` | `""` | no |
| <a name="input_cc_pipeline_config_path"></a> [cc\_pipeline\_config\_path](#input\_cc\_pipeline\_config\_path) | The name and path of the pipeline-config.yaml file within the pipeline-config repo. | `string` | `".pipeline-config.yaml"` | no |
| <a name="input_cc_pipeline_config_repo_auth_type"></a> [cc\_pipeline\_config\_repo\_auth\_type](#input\_cc\_pipeline\_config\_repo\_auth\_type) | Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'. | `string` | `""` | no |
| <a name="input_cc_pipeline_config_repo_branch"></a> [cc\_pipeline\_config\_repo\_branch](#input\_cc\_pipeline\_config\_repo\_branch) | Specify the branch containing the custom pipeline-config.yaml file. | `string` | `""` | no |
| <a name="input_cc_pipeline_config_repo_clone_from_url"></a> [cc\_pipeline\_config\_repo\_clone\_from\_url](#input\_cc\_pipeline\_config\_repo\_clone\_from\_url) | Specify a repository containing a custom pipeline-config.yaml file. | `string` | `""` | no |
| <a name="input_cc_pipeline_config_repo_existing_url"></a> [cc\_pipeline\_config\_repo\_existing\_url](#input\_cc\_pipeline\_config\_repo\_existing\_url) | Specify a repository containing a custom pipeline-config.yaml file. | `string` | `""` | no |
| <a name="input_cc_pipeline_config_repo_git_token_secret_name"></a> [cc\_pipeline\_config\_repo\_git\_token\_secret\_name](#input\_cc\_pipeline\_config\_repo\_git\_token\_secret\_name) | Name of the Git token secret in the secret provider. | `string` | `""` | no |
| <a name="input_cc_pipeline_config_repo_secret_group"></a> [cc\_pipeline\_config\_repo\_secret\_group](#input\_cc\_pipeline\_config\_repo\_secret\_group) | Secret group prefix for the Pipeline Config repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_cc_pipeline_debug"></a> [cc\_pipeline\_debug](#input\_cc\_pipeline\_debug) | '0' by default. Set to '1' to enable debug logging. | `string` | `"0"` | no |
| <a name="input_cc_pipeline_dockerconfigjson_secret_group"></a> [cc\_pipeline\_dockerconfigjson\_secret\_group](#input\_cc\_pipeline\_dockerconfigjson\_secret\_group) | Secret group prefix for the pipeline DockerConfigJson secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_cc_pipeline_dockerconfigjson_secret_name"></a> [cc\_pipeline\_dockerconfigjson\_secret\_name](#input\_cc\_pipeline\_dockerconfigjson\_secret\_name) | Name of the pipeline docker config JSON secret in the secret provider. | `string` | `"pipeline_dockerconfigjson_secret_name"` | no |
| <a name="input_cc_pipeline_ibmcloud_api_key_secret_group"></a> [cc\_pipeline\_ibmcloud\_api\_key\_secret\_group](#input\_cc\_pipeline\_ibmcloud\_api\_key\_secret\_group) | Secret group prefix for the pipeline ibmcloud API key secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_cc_pipeline_ibmcloud_api_key_secret_name"></a> [cc\_pipeline\_ibmcloud\_api\_key\_secret\_name](#input\_cc\_pipeline\_ibmcloud\_api\_key\_secret\_name) | Name of the Cloud API key secret in the secret provider. | `string` | `"ibmcloud-api-key"` | no |
| <a name="input_cc_repositories_prefix"></a> [cc\_repositories\_prefix](#input\_cc\_repositories\_prefix) | The prefix for the compliance repositories. | `string` | `""` | no |
| <a name="input_cc_scc_enable_scc"></a> [cc\_scc\_enable\_scc](#input\_cc\_scc\_enable\_scc) | Adds the SCC tool integration to the toolchain. | `bool` | `true` | no |
| <a name="input_cc_scc_integration_name"></a> [cc\_scc\_integration\_name](#input\_cc\_scc\_integration\_name) | The name of the SCC integration. | `string` | `"Security and Compliance"` | no |
| <a name="input_cc_scc_use_profile_attachment"></a> [cc\_scc\_use\_profile\_attachment](#input\_cc\_scc\_use\_profile\_attachment) | Set to `enabled` to enable use profile with attachment, so that the scripts in the pipeline can interact with the Security and Compliance Center service. When enabled, other parameters become relevant; `scc_scc_scc_api_key_secret_name`, `scc_instance_crn`, `scc_profile_name`, `scc_profile_version`, `scc_attachment_id`. | `string` | `""` | no |
| <a name="input_cc_slack_channel_name"></a> [cc\_slack\_channel\_name](#input\_cc\_slack\_channel\_name) | The Slack channel that notifications are posted to. | `string` | `""` | no |
| <a name="input_cc_slack_notifications"></a> [cc\_slack\_notifications](#input\_cc\_slack\_notifications) | The switch that turns the Slack notification on (`1`) or off (`0`). | `string` | `""` | no |
| <a name="input_cc_slack_pipeline_fail"></a> [cc\_slack\_pipeline\_fail](#input\_cc\_slack\_pipeline\_fail) | Generate pipeline failed notifications. | `bool` | `true` | no |
| <a name="input_cc_slack_pipeline_start"></a> [cc\_slack\_pipeline\_start](#input\_cc\_slack\_pipeline\_start) | Generate pipeline start notifications. | `bool` | `true` | no |
| <a name="input_cc_slack_pipeline_success"></a> [cc\_slack\_pipeline\_success](#input\_cc\_slack\_pipeline\_success) | Generate pipeline succeeded notifications. | `bool` | `true` | no |
| <a name="input_cc_slack_team_name"></a> [cc\_slack\_team\_name](#input\_cc\_slack\_team\_name) | The Slack team name, which is the word or phrase before .slack.com in the team URL. | `string` | `""` | no |
| <a name="input_cc_slack_toolchain_bind"></a> [cc\_slack\_toolchain\_bind](#input\_cc\_slack\_toolchain\_bind) | Generate tool added to toolchain notifications. | `bool` | `true` | no |
| <a name="input_cc_slack_toolchain_unbind"></a> [cc\_slack\_toolchain\_unbind](#input\_cc\_slack\_toolchain\_unbind) | Generate tool removed from toolchain notifications. | `bool` | `true` | no |
| <a name="input_cc_slack_webhook_secret_group"></a> [cc\_slack\_webhook\_secret\_group](#input\_cc\_slack\_webhook\_secret\_group) | Secret group prefix for the Slack webhook secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_cc_slack_webhook_secret_name"></a> [cc\_slack\_webhook\_secret\_name](#input\_cc\_slack\_webhook\_secret\_name) | Name of the webhook secret in the secret provider. | `string` | `""` | no |
| <a name="input_cc_sm_location"></a> [cc\_sm\_location](#input\_cc\_sm\_location) | IBM Cloud location/region containing the Secrets Manager instance. | `string` | `""` | no |
| <a name="input_cc_sm_name"></a> [cc\_sm\_name](#input\_cc\_sm\_name) | Name of the Secrets Manager instance where the secrets are stored. | `string` | `""` | no |
| <a name="input_cc_sm_resource_group"></a> [cc\_sm\_resource\_group](#input\_cc\_sm\_resource\_group) | The resource group containing the Secrets Manager instance for your secrets. | `string` | `""` | no |
| <a name="input_cc_sm_secret_group"></a> [cc\_sm\_secret\_group](#input\_cc\_sm\_secret\_group) | Group in Secrets Manager for organizing/grouping secrets. | `string` | `""` | no |
| <a name="input_cc_sonarqube_config"></a> [cc\_sonarqube\_config](#input\_cc\_sonarqube\_config) | Runs a SonarQube scan in an isolated Docker-in-Docker container (default configuration) or in an existing Kubernetes cluster (custom configuration). Options: default or custom. Default is default. | `string` | `"default"` | no |
| <a name="input_cc_sonarqube_integration_name"></a> [cc\_sonarqube\_integration\_name](#input\_cc\_sonarqube\_integration\_name) | The name of the SonarQube integration. | `string` | `"SonarQube"` | no |
| <a name="input_cc_sonarqube_is_blind_connection"></a> [cc\_sonarqube\_is\_blind\_connection](#input\_cc\_sonarqube\_is\_blind\_connection) | When set to `true`, instructs IBM Cloud Continuous Delivery to not validate the configuration of this integration. Set this to true if the SonarQube server is not addressable on the public internet. | `string` | `true` | no |
| <a name="input_cc_sonarqube_secret_name"></a> [cc\_sonarqube\_secret\_name](#input\_cc\_sonarqube\_secret\_name) | The name of the SonarQube secret. | `string` | `"sonarqube-secret"` | no |
| <a name="input_cc_sonarqube_server_url"></a> [cc\_sonarqube\_server\_url](#input\_cc\_sonarqube\_server\_url) | The URL to the SonarQube server. | `string` | `""` | no |
| <a name="input_cc_sonarqube_user"></a> [cc\_sonarqube\_user](#input\_cc\_sonarqube\_user) | The name of the SonarQube user. | `string` | `""` | no |
| <a name="input_cc_toolchain_description"></a> [cc\_toolchain\_description](#input\_cc\_toolchain\_description) | Description for the CC Toolchain. | `string` | `"Toolchain created with terraform template for DevSecOps CC Best Practices."` | no |
| <a name="input_cc_toolchain_name"></a> [cc\_toolchain\_name](#input\_cc\_toolchain\_name) | The name of the CC Toolchain. | `string` | `""` | no |
| <a name="input_cc_toolchain_region"></a> [cc\_toolchain\_region](#input\_cc\_toolchain\_region) | The region containing the CI toolchain. Use the short form of the regions. For example `us-south`. | `string` | `""` | no |
| <a name="input_cc_toolchain_resource_group"></a> [cc\_toolchain\_resource\_group](#input\_cc\_toolchain\_resource\_group) | Resource group within which the toolchain is created. | `string` | `""` | no |
| <a name="input_cc_trigger_manual_enable"></a> [cc\_trigger\_manual\_enable](#input\_cc\_trigger\_manual\_enable) | Set to `true` to enable the CC pipeline Manual trigger. | `bool` | `true` | no |
| <a name="input_cc_trigger_manual_name"></a> [cc\_trigger\_manual\_name](#input\_cc\_trigger\_manual\_name) | The name of the CC pipeline Manual trigger. | `string` | `"CC Manual Trigger"` | no |
| <a name="input_cc_trigger_manual_pruner_enable"></a> [cc\_trigger\_manual\_pruner\_enable](#input\_cc\_trigger\_manual\_pruner\_enable) | Set to `true` to enable the manual Pruner trigger. | `bool` | `true` | no |
| <a name="input_cc_trigger_manual_pruner_name"></a> [cc\_trigger\_manual\_pruner\_name](#input\_cc\_trigger\_manual\_pruner\_name) | The name of the manual Pruner trigger. | `string` | `"Evidence Pruner Manual Trigger"` | no |
| <a name="input_cc_trigger_timed_cron_schedule"></a> [cc\_trigger\_timed\_cron\_schedule](#input\_cc\_trigger\_timed\_cron\_schedule) | Only needed for timer triggers. Cron expression that indicates when this trigger will activate. Maximum frequency is every 5 minutes. The string is based on UNIX crontab syntax: minute, hour, day of month, month, day of week. Example: 0 *\_/2 * * * - every 2 hours. | `string` | `"0 4 * * *"` | no |
| <a name="input_cc_trigger_timed_enable"></a> [cc\_trigger\_timed\_enable](#input\_cc\_trigger\_timed\_enable) | Set to `true` to enable the CI pipeline Timed trigger. | `bool` | `false` | no |
| <a name="input_cc_trigger_timed_name"></a> [cc\_trigger\_timed\_name](#input\_cc\_trigger\_timed\_name) | The name of the CC pipeline Timed trigger. | `string` | `"CC Timed Trigger"` | no |
| <a name="input_cc_trigger_timed_pruner_enable"></a> [cc\_trigger\_timed\_pruner\_enable](#input\_cc\_trigger\_timed\_pruner\_enable) | Set to `true` to enable the timed Pruner trigger. | `bool` | `false` | no |
| <a name="input_cc_trigger_timed_pruner_name"></a> [cc\_trigger\_timed\_pruner\_name](#input\_cc\_trigger\_timed\_pruner\_name) | The name of the timed Pruner trigger. | `string` | `"Evidence Pruner Timed Trigger"` | no |
| <a name="input_cd_app_version"></a> [cd\_app\_version](#input\_cd\_app\_version) | The version of the app to deploy. | `string` | `"v1"` | no |
| <a name="input_cd_authorization_policy_creation"></a> [cd\_authorization\_policy\_creation](#input\_cd\_authorization\_policy\_creation) | Disable Toolchain service to Secrets Manager Service authorization policy creation. | `string` | `""` | no |
| <a name="input_cd_change_management_group"></a> [cd\_change\_management\_group](#input\_cd\_change\_management\_group) | Specify group for change management repository | `string` | `""` | no |
| <a name="input_cd_change_management_repo_auth_type"></a> [cd\_change\_management\_repo\_auth\_type](#input\_cd\_change\_management\_repo\_auth\_type) | Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'. | `string` | `""` | no |
| <a name="input_cd_change_management_repo_git_token_secret_name"></a> [cd\_change\_management\_repo\_git\_token\_secret\_name](#input\_cd\_change\_management\_repo\_git\_token\_secret\_name) | Name of the Git token secret in the secret provider. | `string` | `""` | no |
| <a name="input_cd_change_management_repo_secret_group"></a> [cd\_change\_management\_repo\_secret\_group](#input\_cd\_change\_management\_repo\_secret\_group) | Secret group prefix for the Change Management repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_cd_change_repo_clone_from_url"></a> [cd\_change\_repo\_clone\_from\_url](#input\_cd\_change\_repo\_clone\_from\_url) | Override the default management repo, which is cloned into the app repo. Note, using clone\_if\_not\_exists mode, so if the app repo already exists the repo contents are unchanged. | `string` | `""` | no |
| <a name="input_cd_change_request_id"></a> [cd\_change\_request\_id](#input\_cd\_change\_request\_id) | The ID of an open change request. If this parameter is set to 'notAvailable' by default, a change request is automatically created by the continuous deployment pipeline. | `string` | `"notAvailable"` | no |
| <a name="input_cd_cluster_name"></a> [cd\_cluster\_name](#input\_cd\_cluster\_name) | Name of the Kubernetes cluster where the application is deployed. | `string` | `""` | no |
| <a name="input_cd_cluster_namespace"></a> [cd\_cluster\_namespace](#input\_cd\_cluster\_namespace) | Name of the Kubernetes cluster namespace where the application is deployed. | `string` | `"prod"` | no |
| <a name="input_cd_cluster_region"></a> [cd\_cluster\_region](#input\_cd\_cluster\_region) | Region of the Kubernetes cluster where the application is deployed. Use the short form of the regions. For example `us-south`. | `string` | `""` | no |
| <a name="input_cd_code_signing_cert"></a> [cd\_code\_signing\_cert](#input\_cd\_code\_signing\_cert) | The base64 encoded GPG public key. | `string` | `""` | no |
| <a name="input_cd_compliance_base_image"></a> [cd\_compliance\_base\_image](#input\_cd\_compliance\_base\_image) | Pipeline baseimage to run most of the built-in pipeline code. | `string` | `""` | no |
| <a name="input_cd_compliance_pipeline_branch"></a> [cd\_compliance\_pipeline\_branch](#input\_cd\_compliance\_pipeline\_branch) | The CD Pipeline Compliance Pipeline branch. | `string` | `""` | no |
| <a name="input_cd_compliance_pipeline_group"></a> [cd\_compliance\_pipeline\_group](#input\_cd\_compliance\_pipeline\_group) | Specify user or group for compliance pipline repo. | `string` | `""` | no |
| <a name="input_cd_compliance_pipeline_repo_auth_type"></a> [cd\_compliance\_pipeline\_repo\_auth\_type](#input\_cd\_compliance\_pipeline\_repo\_auth\_type) | Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'. | `string` | `""` | no |
| <a name="input_cd_compliance_pipeline_repo_git_token_secret_name"></a> [cd\_compliance\_pipeline\_repo\_git\_token\_secret\_name](#input\_cd\_compliance\_pipeline\_repo\_git\_token\_secret\_name) | Name of the Git token secret in the secret provider. | `string` | `""` | no |
| <a name="input_cd_compliance_pipeline_repo_secret_group"></a> [cd\_compliance\_pipeline\_repo\_secret\_group](#input\_cd\_compliance\_pipeline\_repo\_secret\_group) | Secret group prefix for the Compliance Pipeline repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_cd_cos_api_key_secret_group"></a> [cd\_cos\_api\_key\_secret\_group](#input\_cd\_cos\_api\_key\_secret\_group) | Secret group prefix for the COS API key secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_cd_cos_api_key_secret_name"></a> [cd\_cos\_api\_key\_secret\_name](#input\_cd\_cos\_api\_key\_secret\_name) | Name of the COS API key secret in the secret provider. | `string` | `""` | no |
| <a name="input_cd_cos_bucket_name"></a> [cd\_cos\_bucket\_name](#input\_cd\_cos\_bucket\_name) | COS bucket name. | `string` | `""` | no |
| <a name="input_cd_cos_endpoint"></a> [cd\_cos\_endpoint](#input\_cd\_cos\_endpoint) | COS endpoint name. | `string` | `""` | no |
| <a name="input_cd_customer_impact"></a> [cd\_customer\_impact](#input\_cd\_customer\_impact) | Custom impact of the change request. | `string` | `"no_impact"` | no |
| <a name="input_cd_deployment_group"></a> [cd\_deployment\_group](#input\_cd\_deployment\_group) | Specify group for deployment. | `string` | `""` | no |
| <a name="input_cd_deployment_repo_auth_type"></a> [cd\_deployment\_repo\_auth\_type](#input\_cd\_deployment\_repo\_auth\_type) | Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'. | `string` | `""` | no |
| <a name="input_cd_deployment_repo_clone_from_branch"></a> [cd\_deployment\_repo\_clone\_from\_branch](#input\_cd\_deployment\_repo\_clone\_from\_branch) | Used when deployment\_repo\_clone\_from\_url is provided, the default branch that is used by the CD build, usually either main or master. | `string` | `""` | no |
| <a name="input_cd_deployment_repo_clone_from_url"></a> [cd\_deployment\_repo\_clone\_from\_url](#input\_cd\_deployment\_repo\_clone\_from\_url) | Override the default sample app by providing your own sample deployment URL, which is cloned into the app repo. Note, using clone\_if\_not\_exists mode, so if the app repo already exists the repo contents are unchanged. | `string` | `""` | no |
| <a name="input_cd_deployment_repo_clone_to_git_id"></a> [cd\_deployment\_repo\_clone\_to\_git\_id](#input\_cd\_deployment\_repo\_clone\_to\_git\_id) | By default absent, else custom server GUID, or other options for 'git\_id' field in the browser UI. | `string` | `""` | no |
| <a name="input_cd_deployment_repo_clone_to_git_provider"></a> [cd\_deployment\_repo\_clone\_to\_git\_provider](#input\_cd\_deployment\_repo\_clone\_to\_git\_provider) | By default 'hostedgit', else use 'githubconsolidated' or 'gitlab'. | `string` | `""` | no |
| <a name="input_cd_deployment_repo_existing_branch"></a> [cd\_deployment\_repo\_existing\_branch](#input\_cd\_deployment\_repo\_existing\_branch) | Used when deployment\_repo\_existing\_url is provided, the default branch that is by the CD build, usually either main or master. | `string` | `""` | no |
| <a name="input_cd_deployment_repo_existing_git_id"></a> [cd\_deployment\_repo\_existing\_git\_id](#input\_cd\_deployment\_repo\_existing\_git\_id) | By default absent, else custom server GUID, or other options for 'git\_id' field in the browser UI. | `string` | `""` | no |
| <a name="input_cd_deployment_repo_existing_git_provider"></a> [cd\_deployment\_repo\_existing\_git\_provider](#input\_cd\_deployment\_repo\_existing\_git\_provider) | By default 'hostedgit', else use 'githubconsolidated' or 'gitlab'. | `string` | `"hostedgit"` | no |
| <a name="input_cd_deployment_repo_existing_url"></a> [cd\_deployment\_repo\_existing\_url](#input\_cd\_deployment\_repo\_existing\_url) | Override to bring your own existing deployment repository URL, which is used directly instead of cloning the default deployment sample. | `string` | `""` | no |
| <a name="input_cd_deployment_repo_git_token_secret_name"></a> [cd\_deployment\_repo\_git\_token\_secret\_name](#input\_cd\_deployment\_repo\_git\_token\_secret\_name) | Name of the Git token secret in the secret provider. | `string` | `""` | no |
| <a name="input_cd_deployment_repo_secret_group"></a> [cd\_deployment\_repo\_secret\_group](#input\_cd\_deployment\_repo\_secret\_group) | Secret group prefix for the Deployment repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_cd_doi_environment"></a> [cd\_doi\_environment](#input\_cd\_doi\_environment) | DevOps Insights environment for DevSecOps CD deployment. | `string` | `""` | no |
| <a name="input_cd_doi_toolchain_id"></a> [cd\_doi\_toolchain\_id](#input\_cd\_doi\_toolchain\_id) | DevOps Insights toolchain ID to link to. | `string` | `""` | no |
| <a name="input_cd_emergency_label"></a> [cd\_emergency\_label](#input\_cd\_emergency\_label) | Identifies the pull request as an emergency. | `string` | `"EMERGENCY"` | no |
| <a name="input_cd_enable_key_protect"></a> [cd\_enable\_key\_protect](#input\_cd\_enable\_key\_protect) | Use the Key Protect integration. | `bool` | `false` | no |
| <a name="input_cd_enable_secrets_manager"></a> [cd\_enable\_secrets\_manager](#input\_cd\_enable\_secrets\_manager) | Use the Secrets Manager integration. | `bool` | `false` | no |
| <a name="input_cd_enable_slack"></a> [cd\_enable\_slack](#input\_cd\_enable\_slack) | Default: false. Set to true to create the integration. | `bool` | `false` | no |
| <a name="input_cd_event_notifications_crn"></a> [cd\_event\_notifications\_crn](#input\_cd\_event\_notifications\_crn) | Set the Event Notifications CRN to create an Events Notification integration. | `string` | `""` | no |
| <a name="input_cd_evidence_group"></a> [cd\_evidence\_group](#input\_cd\_evidence\_group) | Specify Git user or group for evidence repository. | `string` | `""` | no |
| <a name="input_cd_evidence_repo_auth_type"></a> [cd\_evidence\_repo\_auth\_type](#input\_cd\_evidence\_repo\_auth\_type) | Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'. | `string` | `""` | no |
| <a name="input_cd_evidence_repo_git_token_secret_name"></a> [cd\_evidence\_repo\_git\_token\_secret\_name](#input\_cd\_evidence\_repo\_git\_token\_secret\_name) | Name of the Git token secret in the secret provider. | `string` | `""` | no |
| <a name="input_cd_evidence_repo_secret_group"></a> [cd\_evidence\_repo\_secret\_group](#input\_cd\_evidence\_repo\_secret\_group) | Secret group prefix for the Evidence repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_cd_inventory_group"></a> [cd\_inventory\_group](#input\_cd\_inventory\_group) | Specify Git user or group for inventory repository. | `string` | `""` | no |
| <a name="input_cd_inventory_repo_auth_type"></a> [cd\_inventory\_repo\_auth\_type](#input\_cd\_inventory\_repo\_auth\_type) | Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'. | `string` | `""` | no |
| <a name="input_cd_inventory_repo_git_token_secret_name"></a> [cd\_inventory\_repo\_git\_token\_secret\_name](#input\_cd\_inventory\_repo\_git\_token\_secret\_name) | Name of the Git token secret in the secret provider. | `string` | `""` | no |
| <a name="input_cd_inventory_repo_secret_group"></a> [cd\_inventory\_repo\_secret\_group](#input\_cd\_inventory\_repo\_secret\_group) | Secret group prefix for the Inventory repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_cd_issues_group"></a> [cd\_issues\_group](#input\_cd\_issues\_group) | Specify Git user or group for issues repository. | `string` | `""` | no |
| <a name="input_cd_issues_repo_auth_type"></a> [cd\_issues\_repo\_auth\_type](#input\_cd\_issues\_repo\_auth\_type) | Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'. | `string` | `""` | no |
| <a name="input_cd_issues_repo_git_token_secret_name"></a> [cd\_issues\_repo\_git\_token\_secret\_name](#input\_cd\_issues\_repo\_git\_token\_secret\_name) | Name of the Git token secret in the secret provider. | `string` | `""` | no |
| <a name="input_cd_issues_repo_secret_group"></a> [cd\_issues\_repo\_secret\_group](#input\_cd\_issues\_repo\_secret\_group) | Secret group prefix for the Issues repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_cd_kp_location"></a> [cd\_kp\_location](#input\_cd\_kp\_location) | IBM Cloud location/region containing the Key Protect instance. | `string` | `""` | no |
| <a name="input_cd_kp_name"></a> [cd\_kp\_name](#input\_cd\_kp\_name) | Name of the Key Protect instance where the secrets are stored. | `string` | `""` | no |
| <a name="input_cd_kp_resource_group"></a> [cd\_kp\_resource\_group](#input\_cd\_kp\_resource\_group) | The resource group containing the Key Protect instance for your secrets. | `string` | `""` | no |
| <a name="input_cd_link_to_doi_toolchain"></a> [cd\_link\_to\_doi\_toolchain](#input\_cd\_link\_to\_doi\_toolchain) | Enable a link to a DevOps Insights instance in another toolchain, true or false. | `bool` | `true` | no |
| <a name="input_cd_merge_cra_sbom"></a> [cd\_merge\_cra\_sbom](#input\_cd\_merge\_cra\_sbom) | Merge the SBOM | `string` | `"1"` | no |
| <a name="input_cd_peer_review_compliance"></a> [cd\_peer\_review\_compliance](#input\_cd\_peer\_review\_compliance) | Set to `0` to disable. Set to `1` to enable peer review evidence collection. | `string` | `""` | no |
| <a name="input_cd_pipeline_config_group"></a> [cd\_pipeline\_config\_group](#input\_cd\_pipeline\_config\_group) | Specify user or group for pipeline config repo. | `string` | `""` | no |
| <a name="input_cd_pipeline_config_path"></a> [cd\_pipeline\_config\_path](#input\_cd\_pipeline\_config\_path) | The name and path of the pipeline-config.yaml file within the pipeline-config repo. | `string` | `".pipeline-config.yaml"` | no |
| <a name="input_cd_pipeline_config_repo_auth_type"></a> [cd\_pipeline\_config\_repo\_auth\_type](#input\_cd\_pipeline\_config\_repo\_auth\_type) | Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'. | `string` | `""` | no |
| <a name="input_cd_pipeline_config_repo_branch"></a> [cd\_pipeline\_config\_repo\_branch](#input\_cd\_pipeline\_config\_repo\_branch) | Specify the branch containing the custom pipeline-config.yaml file. | `string` | `""` | no |
| <a name="input_cd_pipeline_config_repo_clone_from_url"></a> [cd\_pipeline\_config\_repo\_clone\_from\_url](#input\_cd\_pipeline\_config\_repo\_clone\_from\_url) | Specify a repository containing a custom pipeline-config.yaml file. | `string` | `""` | no |
| <a name="input_cd_pipeline_config_repo_existing_url"></a> [cd\_pipeline\_config\_repo\_existing\_url](#input\_cd\_pipeline\_config\_repo\_existing\_url) | Specify a repository containing a custom pipeline-config.yaml file. | `string` | `""` | no |
| <a name="input_cd_pipeline_config_repo_git_token_secret_name"></a> [cd\_pipeline\_config\_repo\_git\_token\_secret\_name](#input\_cd\_pipeline\_config\_repo\_git\_token\_secret\_name) | Name of the Git token secret in the secret provider. | `string` | `""` | no |
| <a name="input_cd_pipeline_config_repo_secret_group"></a> [cd\_pipeline\_config\_repo\_secret\_group](#input\_cd\_pipeline\_config\_repo\_secret\_group) | Secret group prefix for the Pipeline Config repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_cd_pipeline_debug"></a> [cd\_pipeline\_debug](#input\_cd\_pipeline\_debug) | '0' by default. Set to '1' to enable debug logging. | `string` | `"0"` | no |
| <a name="input_cd_pipeline_git_token_secret_group"></a> [cd\_pipeline\_git\_token\_secret\_group](#input\_cd\_pipeline\_git\_token\_secret\_group) | Secret group prefix for the pipeline Git token secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_cd_pipeline_git_token_secret_name"></a> [cd\_pipeline\_git\_token\_secret\_name](#input\_cd\_pipeline\_git\_token\_secret\_name) | Name of the pipeline Git token secret in the secret provider. | `string` | `"pipeline-git-token"` | no |
| <a name="input_cd_pipeline_ibmcloud_api_key_secret_group"></a> [cd\_pipeline\_ibmcloud\_api\_key\_secret\_group](#input\_cd\_pipeline\_ibmcloud\_api\_key\_secret\_group) | Secret group prefix for the pipeline ibmcloud API key secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_cd_pipeline_ibmcloud_api_key_secret_name"></a> [cd\_pipeline\_ibmcloud\_api\_key\_secret\_name](#input\_cd\_pipeline\_ibmcloud\_api\_key\_secret\_name) | Name of the Cloud API key secret in the secret provider. | `string` | `"ibmcloud-api-key"` | no |
| <a name="input_cd_region"></a> [cd\_region](#input\_cd\_region) | IBM Cloud region used to prefix the `prod_latest` inventory repo branch. | `string` | `""` | no |
| <a name="input_cd_repositories_prefix"></a> [cd\_repositories\_prefix](#input\_cd\_repositories\_prefix) | Prefix name for the cloned compliance repos. | `string` | `""` | no |
| <a name="input_cd_satellite_cluster_group"></a> [cd\_satellite\_cluster\_group](#input\_cd\_satellite\_cluster\_group) | The Satellite cluster group | `string` | `""` | no |
| <a name="input_cd_scc_enable_scc"></a> [cd\_scc\_enable\_scc](#input\_cd\_scc\_enable\_scc) | Adds the SCC tool integration to the toolchain. | `bool` | `true` | no |
| <a name="input_cd_scc_integration_name"></a> [cd\_scc\_integration\_name](#input\_cd\_scc\_integration\_name) | The name of the SCC integration. | `string` | `"Security and Compliance"` | no |
| <a name="input_cd_scc_use_profile_attachment"></a> [cd\_scc\_use\_profile\_attachment](#input\_cd\_scc\_use\_profile\_attachment) | Set to `enabled` to enable use profile with attachment, so that the scripts in the pipeline can interact with the Security and Compliance Center service. When enabled, other parameters become relevant; `scc_scc_api_key_secret_name`, `scc_instance_crn`, `scc_profile_name`, `scc_profile_version`, `scc_attachment_id`. | `string` | `""` | no |
| <a name="input_cd_slack_channel_name"></a> [cd\_slack\_channel\_name](#input\_cd\_slack\_channel\_name) | The Slack channel that notifications are posted to. | `string` | `""` | no |
| <a name="input_cd_slack_notifications"></a> [cd\_slack\_notifications](#input\_cd\_slack\_notifications) | The switch that turns the Slack notification on (`1`) or off (`0`). | `string` | `""` | no |
| <a name="input_cd_slack_pipeline_fail"></a> [cd\_slack\_pipeline\_fail](#input\_cd\_slack\_pipeline\_fail) | Generate pipeline failed notifications. | `bool` | `true` | no |
| <a name="input_cd_slack_pipeline_start"></a> [cd\_slack\_pipeline\_start](#input\_cd\_slack\_pipeline\_start) | Generate pipeline start notifications. | `bool` | `true` | no |
| <a name="input_cd_slack_pipeline_success"></a> [cd\_slack\_pipeline\_success](#input\_cd\_slack\_pipeline\_success) | Generate pipeline succeeded notifications. | `bool` | `true` | no |
| <a name="input_cd_slack_team_name"></a> [cd\_slack\_team\_name](#input\_cd\_slack\_team\_name) | The Slack team name, which is the word or phrase before .slack.com in the team URL. | `string` | `""` | no |
| <a name="input_cd_slack_toolchain_bind"></a> [cd\_slack\_toolchain\_bind](#input\_cd\_slack\_toolchain\_bind) | Generate tool added to toolchain notifications. | `bool` | `true` | no |
| <a name="input_cd_slack_toolchain_unbind"></a> [cd\_slack\_toolchain\_unbind](#input\_cd\_slack\_toolchain\_unbind) | Generate tool removed from toolchain notifications. | `bool` | `true` | no |
| <a name="input_cd_slack_webhook_secret_group"></a> [cd\_slack\_webhook\_secret\_group](#input\_cd\_slack\_webhook\_secret\_group) | Secret group prefix for the Slack webhook secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_cd_slack_webhook_secret_name"></a> [cd\_slack\_webhook\_secret\_name](#input\_cd\_slack\_webhook\_secret\_name) | Name of the webhook secret in the secret provider. | `string` | `""` | no |
| <a name="input_cd_sm_location"></a> [cd\_sm\_location](#input\_cd\_sm\_location) | IBM Cloud location/region containing the Secrets Manager instance. | `string` | `""` | no |
| <a name="input_cd_sm_name"></a> [cd\_sm\_name](#input\_cd\_sm\_name) | Name of the Secrets Manager instance where the secrets are stored. | `string` | `""` | no |
| <a name="input_cd_sm_resource_group"></a> [cd\_sm\_resource\_group](#input\_cd\_sm\_resource\_group) | The resource group containing the Secrets Manager instance for your secrets. | `string` | `""` | no |
| <a name="input_cd_sm_secret_group"></a> [cd\_sm\_secret\_group](#input\_cd\_sm\_secret\_group) | Group in Secrets Manager for organizing/grouping secrets. | `string` | `""` | no |
| <a name="input_cd_source_environment"></a> [cd\_source\_environment](#input\_cd\_source\_environment) | The source environment that the app is promoted from. | `string` | `"master"` | no |
| <a name="input_cd_target_environment"></a> [cd\_target\_environment](#input\_cd\_target\_environment) | The target environment that the app is deployed to. | `string` | `"prod"` | no |
| <a name="input_cd_target_environment_detail"></a> [cd\_target\_environment\_detail](#input\_cd\_target\_environment\_detail) | Details of the environment being updated. | `string` | `"Production target environment"` | no |
| <a name="input_cd_target_environment_purpose"></a> [cd\_target\_environment\_purpose](#input\_cd\_target\_environment\_purpose) | Purpose of the environment being updated. | `string` | `"production"` | no |
| <a name="input_cd_toolchain_description"></a> [cd\_toolchain\_description](#input\_cd\_toolchain\_description) | Description for the CD toolchain. | `string` | `"Toolchain created with terraform template for DevSecOps CD Best Practices."` | no |
| <a name="input_cd_toolchain_name"></a> [cd\_toolchain\_name](#input\_cd\_toolchain\_name) | The name of the CD Toolchain. | `string` | `""` | no |
| <a name="input_cd_toolchain_region"></a> [cd\_toolchain\_region](#input\_cd\_toolchain\_region) | The region containing the CI toolchain. Use the short form of the regions. For example `us-south`. | `string` | `""` | no |
| <a name="input_cd_toolchain_resource_group"></a> [cd\_toolchain\_resource\_group](#input\_cd\_toolchain\_resource\_group) | Resource group within which toolchain is created. | `string` | `""` | no |
| <a name="input_cd_trigger_git_enable"></a> [cd\_trigger\_git\_enable](#input\_cd\_trigger\_git\_enable) | Set to `true` to enable the CD pipeline Git trigger. | `bool` | `false` | no |
| <a name="input_cd_trigger_git_name"></a> [cd\_trigger\_git\_name](#input\_cd\_trigger\_git\_name) | The name of the CD pipeline GIT trigger. | `string` | `"Git CD Trigger"` | no |
| <a name="input_cd_trigger_manual_enable"></a> [cd\_trigger\_manual\_enable](#input\_cd\_trigger\_manual\_enable) | Set to `true` to enable the CD pipeline Manual trigger. | `bool` | `true` | no |
| <a name="input_cd_trigger_manual_name"></a> [cd\_trigger\_manual\_name](#input\_cd\_trigger\_manual\_name) | The name of the CI pipeline Manual trigger. | `string` | `"Manual CD Trigger"` | no |
| <a name="input_cd_trigger_manual_promotion_enable"></a> [cd\_trigger\_manual\_promotion\_enable](#input\_cd\_trigger\_manual\_promotion\_enable) | Set to `true` to enable the CD pipeline Manual Promotion trigger. | `bool` | `true` | no |
| <a name="input_cd_trigger_manual_promotion_name"></a> [cd\_trigger\_manual\_promotion\_name](#input\_cd\_trigger\_manual\_promotion\_name) | The name of the CD pipeline Manual Promotion trigger. | `string` | `"Manual Promotion Trigger"` | no |
| <a name="input_cd_trigger_manual_pruner_enable"></a> [cd\_trigger\_manual\_pruner\_enable](#input\_cd\_trigger\_manual\_pruner\_enable) | Set to `true` to enable the manual Pruner trigger. | `bool` | `true` | no |
| <a name="input_cd_trigger_manual_pruner_name"></a> [cd\_trigger\_manual\_pruner\_name](#input\_cd\_trigger\_manual\_pruner\_name) | The name of the manual Pruner trigger. | `string` | `"Evidence Pruner Manual Trigger"` | no |
| <a name="input_cd_trigger_timed_cron_schedule"></a> [cd\_trigger\_timed\_cron\_schedule](#input\_cd\_trigger\_timed\_cron\_schedule) | Only needed for timer triggers. Cron expression that indicates when this trigger will activate. Maximum frequency is every 5 minutes. The string is based on UNIX crontab syntax: minute, hour, day of month, month, day of week. Example: 0 *\_/2 * * * - every 2 hours. | `string` | `"0 4 * * *"` | no |
| <a name="input_cd_trigger_timed_enable"></a> [cd\_trigger\_timed\_enable](#input\_cd\_trigger\_timed\_enable) | Set to `true` to enable the CD pipeline Timed trigger. | `bool` | `false` | no |
| <a name="input_cd_trigger_timed_name"></a> [cd\_trigger\_timed\_name](#input\_cd\_trigger\_timed\_name) | The name of the CD pipeline Timed trigger. | `string` | `"Git CD Timed Trigger"` | no |
| <a name="input_cd_trigger_timed_pruner_enable"></a> [cd\_trigger\_timed\_pruner\_enable](#input\_cd\_trigger\_timed\_pruner\_enable) | Set to `true` to enable the timed Pruner trigger. | `bool` | `false` | no |
| <a name="input_cd_trigger_timed_pruner_name"></a> [cd\_trigger\_timed\_pruner\_name](#input\_cd\_trigger\_timed\_pruner\_name) | The name of the timed Pruner trigger. | `string` | `"Evidence Pruner Timed Trigger"` | no |
| <a name="input_ci_app_group"></a> [ci\_app\_group](#input\_ci\_app\_group) | Specify Git user or group for your application. | `string` | `""` | no |
| <a name="input_ci_app_name"></a> [ci\_app\_name](#input\_ci\_app\_name) | Name of the application image and inventory entry. | `string` | `"hello-compliance-app"` | no |
| <a name="input_ci_app_repo_auth_type"></a> [ci\_app\_repo\_auth\_type](#input\_ci\_app\_repo\_auth\_type) | Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'. | `string` | `""` | no |
| <a name="input_ci_app_repo_clone_from_branch"></a> [ci\_app\_repo\_clone\_from\_branch](#input\_ci\_app\_repo\_clone\_from\_branch) | Used when app\_repo\_clone\_from\_url is provided, the default branch that is used by the CI build, usually either main or master. | `string` | `""` | no |
| <a name="input_ci_app_repo_clone_from_url"></a> [ci\_app\_repo\_clone\_from\_url](#input\_ci\_app\_repo\_clone\_from\_url) | Override the default sample app by providing your own sample app URL, which is cloned into the app repo. Note, using clone\_if\_not\_exists mode, so if the app repo already exists the repo contents are unchanged. | `string` | `""` | no |
| <a name="input_ci_app_repo_clone_to_git_id"></a> [ci\_app\_repo\_clone\_to\_git\_id](#input\_ci\_app\_repo\_clone\_to\_git\_id) | By default absent, otherwise use custom server GUID, or other options for `git_id` field in the browser UI. | `string` | `""` | no |
| <a name="input_ci_app_repo_clone_to_git_provider"></a> [ci\_app\_repo\_clone\_to\_git\_provider](#input\_ci\_app\_repo\_clone\_to\_git\_provider) | By default 'hostedgit', else use 'githubconsolidated' or 'gitlab'. | `string` | `""` | no |
| <a name="input_ci_app_repo_existing_branch"></a> [ci\_app\_repo\_existing\_branch](#input\_ci\_app\_repo\_existing\_branch) | Used when app\_repo\_existing\_url is provided, the default branch that is used by the CI build, usually either main or master. | `string` | `""` | no |
| <a name="input_ci_app_repo_existing_git_id"></a> [ci\_app\_repo\_existing\_git\_id](#input\_ci\_app\_repo\_existing\_git\_id) | By default absent, otherwise use custom server GUID, or other options for `git_id` field in the browser UI. | `string` | `""` | no |
| <a name="input_ci_app_repo_existing_git_provider"></a> [ci\_app\_repo\_existing\_git\_provider](#input\_ci\_app\_repo\_existing\_git\_provider) | By default 'hostedgit', else use 'githubconsolidated' or 'gitlab'. | `string` | `""` | no |
| <a name="input_ci_app_repo_existing_url"></a> [ci\_app\_repo\_existing\_url](#input\_ci\_app\_repo\_existing\_url) | Override to bring your own existing application repository URL, which is used directly instead of cloning the default sample. | `string` | `""` | no |
| <a name="input_ci_app_repo_git_token_secret_name"></a> [ci\_app\_repo\_git\_token\_secret\_name](#input\_ci\_app\_repo\_git\_token\_secret\_name) | Name of the Git token secret in the secret provider. | `string` | `""` | no |
| <a name="input_ci_app_repo_secret_group"></a> [ci\_app\_repo\_secret\_group](#input\_ci\_app\_repo\_secret\_group) | Secret group prefix for the App repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_ci_app_version"></a> [ci\_app\_version](#input\_ci\_app\_version) | The version of the app to deploy. | `string` | `"v1"` | no |
| <a name="input_ci_authorization_policy_creation"></a> [ci\_authorization\_policy\_creation](#input\_ci\_authorization\_policy\_creation) | Disable Toolchain Service to Secrets Manager Service authorization policy creation. | `string` | `""` | no |
| <a name="input_ci_cluster_name"></a> [ci\_cluster\_name](#input\_ci\_cluster\_name) | Name of the Kubernetes cluster where the application is deployed. (can be the same cluster used for prod) | `string` | `""` | no |
| <a name="input_ci_cluster_namespace"></a> [ci\_cluster\_namespace](#input\_ci\_cluster\_namespace) | Name of the Kubernetes cluster namespace where the application is deployed. | `string` | `"dev"` | no |
| <a name="input_ci_cluster_region"></a> [ci\_cluster\_region](#input\_ci\_cluster\_region) | Region of the Kubernetes cluster where the application is deployed. Use the short form of the regions. For example `us-south`. | `string` | `""` | no |
| <a name="input_ci_cluster_resource_group"></a> [ci\_cluster\_resource\_group](#input\_ci\_cluster\_resource\_group) | The cluster resource group. | `string` | `""` | no |
| <a name="input_ci_code_engine_build_strategy"></a> [ci\_code\_engine\_build\_strategy](#input\_ci\_code\_engine\_build\_strategy) | The build strategy for the Code Engine entity. Default strategy is 'dockerfile'. Set as 'buildpacks' for 'buildpacks' build. | `string` | `""` | no |
| <a name="input_ci_code_engine_entity_type"></a> [ci\_code\_engine\_entity\_type](#input\_ci\_code\_engine\_entity\_type) | Type of Code Engine entity to create/update as part of deployment. Default type is 'application'. Set as 'job' for 'job' type. | `string` | `""` | no |
| <a name="input_ci_code_engine_project"></a> [ci\_code\_engine\_project](#input\_ci\_code\_engine\_project) | The name of the Code Engine project to use (or create). | `string` | `"DevSecOps_CE"` | no |
| <a name="input_ci_code_engine_region"></a> [ci\_code\_engine\_region](#input\_ci\_code\_engine\_region) | The region to create/lookup for the Code Engine project. | `string` | `"ibm:yp:us-south"` | no |
| <a name="input_ci_code_engine_resource_group"></a> [ci\_code\_engine\_resource\_group](#input\_ci\_code\_engine\_resource\_group) | The resource group of the Code Engine project. | `string` | `"Default"` | no |
| <a name="input_ci_code_engine_source"></a> [ci\_code\_engine\_source](#input\_ci\_code\_engine\_source) | The path to the location of code to build in the repository. | `string` | `""` | no |
| <a name="input_ci_compliance_base_image"></a> [ci\_compliance\_base\_image](#input\_ci\_compliance\_base\_image) | Pipeline baseimage to run most of the built-in pipeline code. | `string` | `""` | no |
| <a name="input_ci_compliance_pipeline_branch"></a> [ci\_compliance\_pipeline\_branch](#input\_ci\_compliance\_pipeline\_branch) | The CI Pipeline Compliance Pipeline branch. | `string` | `""` | no |
| <a name="input_ci_compliance_pipeline_group"></a> [ci\_compliance\_pipeline\_group](#input\_ci\_compliance\_pipeline\_group) | Specify user or group for compliance pipline repo. | `string` | `""` | no |
| <a name="input_ci_compliance_pipeline_pr_branch"></a> [ci\_compliance\_pipeline\_pr\_branch](#input\_ci\_compliance\_pipeline\_pr\_branch) | The PR Pipeline Compliance Pipeline branch. | `string` | `""` | no |
| <a name="input_ci_compliance_pipeline_repo_auth_type"></a> [ci\_compliance\_pipeline\_repo\_auth\_type](#input\_ci\_compliance\_pipeline\_repo\_auth\_type) | Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'. | `string` | `""` | no |
| <a name="input_ci_compliance_pipeline_repo_git_token_secret_name"></a> [ci\_compliance\_pipeline\_repo\_git\_token\_secret\_name](#input\_ci\_compliance\_pipeline\_repo\_git\_token\_secret\_name) | Name of the Git token secret in the secret provider. | `string` | `""` | no |
| <a name="input_ci_compliance_pipeline_repo_secret_group"></a> [ci\_compliance\_pipeline\_repo\_secret\_group](#input\_ci\_compliance\_pipeline\_repo\_secret\_group) | Secret group prefix for the Compliance Pipeline repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_ci_cos_api_key_secret_group"></a> [ci\_cos\_api\_key\_secret\_group](#input\_ci\_cos\_api\_key\_secret\_group) | Secret group prefix for the COS API key secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_ci_cos_api_key_secret_name"></a> [ci\_cos\_api\_key\_secret\_name](#input\_ci\_cos\_api\_key\_secret\_name) | Name of the COS API key secret in the secret provider. | `string` | `""` | no |
| <a name="input_ci_cos_bucket_name"></a> [ci\_cos\_bucket\_name](#input\_ci\_cos\_bucket\_name) | COS bucket name. | `string` | `""` | no |
| <a name="input_ci_cos_endpoint"></a> [ci\_cos\_endpoint](#input\_ci\_cos\_endpoint) | COS endpoint name. | `string` | `""` | no |
| <a name="input_ci_cra_generate_cyclonedx_format"></a> [ci\_cra\_generate\_cyclonedx\_format](#input\_ci\_cra\_generate\_cyclonedx\_format) | If set to 1, CRA also generates the BOM in cyclonedx format (defaults to 1). | `string` | `"1"` | no |
| <a name="input_ci_custom_image_tag"></a> [ci\_custom\_image\_tag](#input\_ci\_custom\_image\_tag) | The custom tag for the image in a comma-separated list. | `string` | `""` | no |
| <a name="input_ci_deployment_target"></a> [ci\_deployment\_target](#input\_ci\_deployment\_target) | The deployment target, cluster or code-engine. | `string` | `"cluster"` | no |
| <a name="input_ci_dev_region"></a> [ci\_dev\_region](#input\_ci\_dev\_region) | (Deprecated. Use `ci_cluster_region`) Region of the Kubernetes cluster where the application is deployed. Use the short form of the regions. For example `us-south` | `string` | `""` | no |
| <a name="input_ci_dev_resource_group"></a> [ci\_dev\_resource\_group](#input\_ci\_dev\_resource\_group) | (Deprecated. Use `ci_cluster_resource_group`) The cluster resource group. | `string` | `""` | no |
| <a name="input_ci_doi_environment"></a> [ci\_doi\_environment](#input\_ci\_doi\_environment) | The DevOps Insights target environment. | `string` | `""` | no |
| <a name="input_ci_doi_toolchain_id"></a> [ci\_doi\_toolchain\_id](#input\_ci\_doi\_toolchain\_id) | DevOps Insights toolchain ID to link to. | `string` | `""` | no |
| <a name="input_ci_doi_toolchain_id_pipeline_property"></a> [ci\_doi\_toolchain\_id\_pipeline\_property](#input\_ci\_doi\_toolchain\_id\_pipeline\_property) | The DevOps Insights instance toolchain ID. | `string` | `""` | no |
| <a name="input_ci_enable_key_protect"></a> [ci\_enable\_key\_protect](#input\_ci\_enable\_key\_protect) | Set to enable Key Protect Integration. | `bool` | `false` | no |
| <a name="input_ci_enable_pipeline_dockerconfigjson"></a> [ci\_enable\_pipeline\_dockerconfigjson](#input\_ci\_enable\_pipeline\_dockerconfigjson) | Enable to add the pipeline-dockerconfigjson property to the pipeline properties. | `bool` | `false` | no |
| <a name="input_ci_enable_secrets_manager"></a> [ci\_enable\_secrets\_manager](#input\_ci\_enable\_secrets\_manager) | Set to enable Secrets Manager Integration. | `bool` | `false` | no |
| <a name="input_ci_enable_slack"></a> [ci\_enable\_slack](#input\_ci\_enable\_slack) | Default: false. Set to true to create the integration. | `bool` | `false` | no |
| <a name="input_ci_event_notifications_crn"></a> [ci\_event\_notifications\_crn](#input\_ci\_event\_notifications\_crn) | Set the Event Notifications CRN to create an Events Notification integration. | `string` | `""` | no |
| <a name="input_ci_evidence_group"></a> [ci\_evidence\_group](#input\_ci\_evidence\_group) | Specify Git user or group for evidence repository. | `string` | `""` | no |
| <a name="input_ci_evidence_repo_auth_type"></a> [ci\_evidence\_repo\_auth\_type](#input\_ci\_evidence\_repo\_auth\_type) | Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'. | `string` | `""` | no |
| <a name="input_ci_evidence_repo_git_token_secret_name"></a> [ci\_evidence\_repo\_git\_token\_secret\_name](#input\_ci\_evidence\_repo\_git\_token\_secret\_name) | Name of the Git token secret in the secret provider. | `string` | `""` | no |
| <a name="input_ci_evidence_repo_secret_group"></a> [ci\_evidence\_repo\_secret\_group](#input\_ci\_evidence\_repo\_secret\_group) | Secret group prefix for the Evidence repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_ci_inventory_group"></a> [ci\_inventory\_group](#input\_ci\_inventory\_group) | Specify Git user or group for inventory repository. | `string` | `""` | no |
| <a name="input_ci_inventory_repo_auth_type"></a> [ci\_inventory\_repo\_auth\_type](#input\_ci\_inventory\_repo\_auth\_type) | Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'. | `string` | `""` | no |
| <a name="input_ci_inventory_repo_git_token_secret_name"></a> [ci\_inventory\_repo\_git\_token\_secret\_name](#input\_ci\_inventory\_repo\_git\_token\_secret\_name) | Name of the Git token secret in the secret provider. | `string` | `""` | no |
| <a name="input_ci_inventory_repo_secret_group"></a> [ci\_inventory\_repo\_secret\_group](#input\_ci\_inventory\_repo\_secret\_group) | Secret group prefix for the Inventory repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_ci_issues_group"></a> [ci\_issues\_group](#input\_ci\_issues\_group) | Specify Git user or group for issues repository. | `string` | `""` | no |
| <a name="input_ci_issues_repo_auth_type"></a> [ci\_issues\_repo\_auth\_type](#input\_ci\_issues\_repo\_auth\_type) | Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'. | `string` | `""` | no |
| <a name="input_ci_issues_repo_git_token_secret_name"></a> [ci\_issues\_repo\_git\_token\_secret\_name](#input\_ci\_issues\_repo\_git\_token\_secret\_name) | Name of the Git token secret in the secret provider. | `string` | `""` | no |
| <a name="input_ci_issues_repo_secret_group"></a> [ci\_issues\_repo\_secret\_group](#input\_ci\_issues\_repo\_secret\_group) | Secret group prefix for the Issues repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_ci_kp_location"></a> [ci\_kp\_location](#input\_ci\_kp\_location) | IBM Cloud location/region containing the Key Protect instance. | `string` | `""` | no |
| <a name="input_ci_kp_name"></a> [ci\_kp\_name](#input\_ci\_kp\_name) | Name of the Key Protect instance where the secrets are stored. | `string` | `""` | no |
| <a name="input_ci_kp_resource_group"></a> [ci\_kp\_resource\_group](#input\_ci\_kp\_resource\_group) | The resource group containing the Key Protect instance. | `string` | `""` | no |
| <a name="input_ci_link_to_doi_toolchain"></a> [ci\_link\_to\_doi\_toolchain](#input\_ci\_link\_to\_doi\_toolchain) | Enable a link to a DevOps Insights instance in another toolchain. | `bool` | `false` | no |
| <a name="input_ci_opt_in_dynamic_api_scan"></a> [ci\_opt\_in\_dynamic\_api\_scan](#input\_ci\_opt\_in\_dynamic\_api\_scan) | To enable the OWASP Zap API scan. '1' enable or '0' disable. | `string` | `"1"` | no |
| <a name="input_ci_opt_in_dynamic_scan"></a> [ci\_opt\_in\_dynamic\_scan](#input\_ci\_opt\_in\_dynamic\_scan) | To enable the OWASP Zap scan. '1' enable or '0' disable. | `string` | `"1"` | no |
| <a name="input_ci_opt_in_dynamic_ui_scan"></a> [ci\_opt\_in\_dynamic\_ui\_scan](#input\_ci\_opt\_in\_dynamic\_ui\_scan) | To enable the OWASP Zap UI scan. '1' enable or '0' disable. | `string` | `"1"` | no |
| <a name="input_ci_opt_in_sonar"></a> [ci\_opt\_in\_sonar](#input\_ci\_opt\_in\_sonar) | Opt in for Sonarqube | `string` | `"1"` | no |
| <a name="input_ci_peer_review_compliance"></a> [ci\_peer\_review\_compliance](#input\_ci\_peer\_review\_compliance) | Set to `0` to disable. Set to `1` to enable peer review evidence collection. | `string` | `""` | no |
| <a name="input_ci_pipeline_config_group"></a> [ci\_pipeline\_config\_group](#input\_ci\_pipeline\_config\_group) | Specify user or group for pipeline config repo. | `string` | `""` | no |
| <a name="input_ci_pipeline_config_path"></a> [ci\_pipeline\_config\_path](#input\_ci\_pipeline\_config\_path) | The name and path of the pipeline-config.yaml file within the pipeline-config repo. | `string` | `".pipeline-config.yaml"` | no |
| <a name="input_ci_pipeline_config_repo_auth_type"></a> [ci\_pipeline\_config\_repo\_auth\_type](#input\_ci\_pipeline\_config\_repo\_auth\_type) | Select the method of authentication that is used to access the Git provider. 'oauth' or 'pat'. | `string` | `""` | no |
| <a name="input_ci_pipeline_config_repo_branch"></a> [ci\_pipeline\_config\_repo\_branch](#input\_ci\_pipeline\_config\_repo\_branch) | Specify the branch containing the custom pipeline-config.yaml file. | `string` | `""` | no |
| <a name="input_ci_pipeline_config_repo_clone_from_url"></a> [ci\_pipeline\_config\_repo\_clone\_from\_url](#input\_ci\_pipeline\_config\_repo\_clone\_from\_url) | Specify a repository containing a custom pipeline-config.yaml file. | `string` | `""` | no |
| <a name="input_ci_pipeline_config_repo_existing_url"></a> [ci\_pipeline\_config\_repo\_existing\_url](#input\_ci\_pipeline\_config\_repo\_existing\_url) | Specify a repository containing a custom pipeline-config.yaml file. | `string` | `""` | no |
| <a name="input_ci_pipeline_config_repo_git_token_secret_name"></a> [ci\_pipeline\_config\_repo\_git\_token\_secret\_name](#input\_ci\_pipeline\_config\_repo\_git\_token\_secret\_name) | Name of the Git token secret in the secret provider. | `string` | `""` | no |
| <a name="input_ci_pipeline_config_repo_secret_group"></a> [ci\_pipeline\_config\_repo\_secret\_group](#input\_ci\_pipeline\_config\_repo\_secret\_group) | Secret group prefix for the Pipeline Config repo secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_ci_pipeline_debug"></a> [ci\_pipeline\_debug](#input\_ci\_pipeline\_debug) | '0' by default. Set to '1' to enable debug logging. | `string` | `"0"` | no |
| <a name="input_ci_pipeline_dockerconfigjson_secret_group"></a> [ci\_pipeline\_dockerconfigjson\_secret\_group](#input\_ci\_pipeline\_dockerconfigjson\_secret\_group) | Secret group prefix for the pipeline DockerConfigJson secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_ci_pipeline_dockerconfigjson_secret_name"></a> [ci\_pipeline\_dockerconfigjson\_secret\_name](#input\_ci\_pipeline\_dockerconfigjson\_secret\_name) | Name of the pipeline docker config JSON secret in the secret provider. | `string` | `"pipeline_dockerconfigjson_secret_name"` | no |
| <a name="input_ci_pipeline_git_token_secret_group"></a> [ci\_pipeline\_git\_token\_secret\_group](#input\_ci\_pipeline\_git\_token\_secret\_group) | Secret group prefix for the pipeline Git token secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_ci_pipeline_git_token_secret_name"></a> [ci\_pipeline\_git\_token\_secret\_name](#input\_ci\_pipeline\_git\_token\_secret\_name) | Name of the pipeline Git token secret in the secret provider. | `string` | `"pipeline-git-token"` | no |
| <a name="input_ci_pipeline_ibmcloud_api_key_secret_group"></a> [ci\_pipeline\_ibmcloud\_api\_key\_secret\_group](#input\_ci\_pipeline\_ibmcloud\_api\_key\_secret\_group) | Secret group prefix for the pipeline ibmcloud API key secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_ci_pipeline_ibmcloud_api_key_secret_name"></a> [ci\_pipeline\_ibmcloud\_api\_key\_secret\_name](#input\_ci\_pipeline\_ibmcloud\_api\_key\_secret\_name) | Name of the Cloud API key secret in the secret provider. | `string` | `"ibmcloud-api-key"` | no |
| <a name="input_ci_registry_namespace"></a> [ci\_registry\_namespace](#input\_ci\_registry\_namespace) | A unique namespace within the IBM Cloud Container Registry region where the application image is stored. (deprecated. Use `registry_namespace`) | `string` | `""` | no |
| <a name="input_ci_registry_region"></a> [ci\_registry\_region](#input\_ci\_registry\_region) | The IBM Cloud Region where the IBM Cloud Container Registry namespace is to be created. Use the short form of the regions. For example `us-south`. | `string` | `""` | no |
| <a name="input_ci_repositories_prefix"></a> [ci\_repositories\_prefix](#input\_ci\_repositories\_prefix) | Prefix name for the cloned compliance repos. | `string` | `""` | no |
| <a name="input_ci_signing_key_secret_group"></a> [ci\_signing\_key\_secret\_group](#input\_ci\_signing\_key\_secret\_group) | Secret group prefix for the signing key secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_ci_signing_key_secret_name"></a> [ci\_signing\_key\_secret\_name](#input\_ci\_signing\_key\_secret\_name) | Name of the signing key secret in the secret provider. | `string` | `"signing_key"` | no |
| <a name="input_ci_slack_channel_name"></a> [ci\_slack\_channel\_name](#input\_ci\_slack\_channel\_name) | The Slack channel that notifications are posted to. | `string` | `""` | no |
| <a name="input_ci_slack_notifications"></a> [ci\_slack\_notifications](#input\_ci\_slack\_notifications) | The switch that turns the Slack notification on (`1`) or off (`0`). | `string` | `""` | no |
| <a name="input_ci_slack_pipeline_fail"></a> [ci\_slack\_pipeline\_fail](#input\_ci\_slack\_pipeline\_fail) | Generate pipeline failed notifications. | `bool` | `true` | no |
| <a name="input_ci_slack_pipeline_start"></a> [ci\_slack\_pipeline\_start](#input\_ci\_slack\_pipeline\_start) | Generate pipeline start notifications. | `bool` | `true` | no |
| <a name="input_ci_slack_pipeline_success"></a> [ci\_slack\_pipeline\_success](#input\_ci\_slack\_pipeline\_success) | Generate pipeline succeeded notifications. | `bool` | `true` | no |
| <a name="input_ci_slack_team_name"></a> [ci\_slack\_team\_name](#input\_ci\_slack\_team\_name) | The Slack team name, which is the word or phrase before `.slack.com` in the team URL. | `string` | `""` | no |
| <a name="input_ci_slack_toolchain_bind"></a> [ci\_slack\_toolchain\_bind](#input\_ci\_slack\_toolchain\_bind) | Generate tool added to toolchain notifications. | `bool` | `true` | no |
| <a name="input_ci_slack_toolchain_unbind"></a> [ci\_slack\_toolchain\_unbind](#input\_ci\_slack\_toolchain\_unbind) | Generate tool removed from toolchain notifications. | `bool` | `true` | no |
| <a name="input_ci_slack_webhook_secret_group"></a> [ci\_slack\_webhook\_secret\_group](#input\_ci\_slack\_webhook\_secret\_group) | Secret group prefix for the Slack webhook secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_ci_slack_webhook_secret_name"></a> [ci\_slack\_webhook\_secret\_name](#input\_ci\_slack\_webhook\_secret\_name) | Name of the webhook secret in the secret provider. | `string` | `""` | no |
| <a name="input_ci_sm_location"></a> [ci\_sm\_location](#input\_ci\_sm\_location) | IBM Cloud location/region containing the Secrets Manager instance. | `string` | `""` | no |
| <a name="input_ci_sm_name"></a> [ci\_sm\_name](#input\_ci\_sm\_name) | Name of the Secrets Manager instance where the secrets are stored. | `string` | `""` | no |
| <a name="input_ci_sm_resource_group"></a> [ci\_sm\_resource\_group](#input\_ci\_sm\_resource\_group) | The resource group containing the Secrets Manager instance. | `string` | `""` | no |
| <a name="input_ci_sm_secret_group"></a> [ci\_sm\_secret\_group](#input\_ci\_sm\_secret\_group) | Group in Secrets Manager for organizing/grouping secrets. | `string` | `""` | no |
| <a name="input_ci_sonarqube_config"></a> [ci\_sonarqube\_config](#input\_ci\_sonarqube\_config) | Runs a SonarQube scan in an isolated Docker-in-Docker container (default configuration) or in an existing Kubernetes cluster (custom configuration). Options: default or custom. Default is default. | `string` | `"default"` | no |
| <a name="input_ci_sonarqube_integration_name"></a> [ci\_sonarqube\_integration\_name](#input\_ci\_sonarqube\_integration\_name) | The name of the SonarQube integration. | `string` | `"SonarQube"` | no |
| <a name="input_ci_sonarqube_is_blind_connection"></a> [ci\_sonarqube\_is\_blind\_connection](#input\_ci\_sonarqube\_is\_blind\_connection) | When set to `true`, instructs IBM Cloud Continuous Delivery to not validate the configuration of this integration. Set this to true if the SonarQube server is not addressable on the public internet. | `string` | `true` | no |
| <a name="input_ci_sonarqube_secret_name"></a> [ci\_sonarqube\_secret\_name](#input\_ci\_sonarqube\_secret\_name) | The name of the SonarQube secret. | `string` | `"sonarqube-secret"` | no |
| <a name="input_ci_sonarqube_server_url"></a> [ci\_sonarqube\_server\_url](#input\_ci\_sonarqube\_server\_url) | The URL to the SonarQube server. | `string` | `""` | no |
| <a name="input_ci_sonarqube_user"></a> [ci\_sonarqube\_user](#input\_ci\_sonarqube\_user) | The name of the SonarQube user. | `string` | `""` | no |
| <a name="input_ci_toolchain_description"></a> [ci\_toolchain\_description](#input\_ci\_toolchain\_description) | Description for the CI Toolchain. | `string` | `"Toolchain created with terraform template for DevSecOps CI Best Practices."` | no |
| <a name="input_ci_toolchain_name"></a> [ci\_toolchain\_name](#input\_ci\_toolchain\_name) | The name of the CI Toolchain. | `string` | `""` | no |
| <a name="input_ci_toolchain_region"></a> [ci\_toolchain\_region](#input\_ci\_toolchain\_region) | The region containing the CI toolchain. Use the short form of the regions. For example `us-south`. | `string` | `""` | no |
| <a name="input_ci_toolchain_resource_group"></a> [ci\_toolchain\_resource\_group](#input\_ci\_toolchain\_resource\_group) | The resource group within which the toolchain is created. | `string` | `""` | no |
| <a name="input_ci_trigger_git_enable"></a> [ci\_trigger\_git\_enable](#input\_ci\_trigger\_git\_enable) | Set to `true` to enable the CI pipeline Git trigger. | `bool` | `true` | no |
| <a name="input_ci_trigger_git_name"></a> [ci\_trigger\_git\_name](#input\_ci\_trigger\_git\_name) | The name of the CI pipeline GIT trigger. | `string` | `"Git CI Trigger"` | no |
| <a name="input_ci_trigger_manual_enable"></a> [ci\_trigger\_manual\_enable](#input\_ci\_trigger\_manual\_enable) | Set to `true` to enable the CI pipeline Manual trigger. | `bool` | `true` | no |
| <a name="input_ci_trigger_manual_name"></a> [ci\_trigger\_manual\_name](#input\_ci\_trigger\_manual\_name) | The name of the CI pipeline Manual trigger. | `string` | `"Manual Trigger"` | no |
| <a name="input_ci_trigger_manual_pruner_enable"></a> [ci\_trigger\_manual\_pruner\_enable](#input\_ci\_trigger\_manual\_pruner\_enable) | Set to `true` to enable the manual Pruner trigger. | `bool` | `true` | no |
| <a name="input_ci_trigger_manual_pruner_name"></a> [ci\_trigger\_manual\_pruner\_name](#input\_ci\_trigger\_manual\_pruner\_name) | The name of the manual Pruner trigger. | `string` | `"Evidence Pruner Manual Trigger"` | no |
| <a name="input_ci_trigger_pr_git_enable"></a> [ci\_trigger\_pr\_git\_enable](#input\_ci\_trigger\_pr\_git\_enable) | Set to `true` to enable the PR pipeline Git trigger. | `bool` | `true` | no |
| <a name="input_ci_trigger_pr_git_name"></a> [ci\_trigger\_pr\_git\_name](#input\_ci\_trigger\_pr\_git\_name) | The name of the PR pipeline GIT trigger. | `string` | `"Git PR Trigger"` | no |
| <a name="input_ci_trigger_timed_cron_schedule"></a> [ci\_trigger\_timed\_cron\_schedule](#input\_ci\_trigger\_timed\_cron\_schedule) | Only needed for timer triggers. Cron expression that indicates when this trigger will activate. Maximum frequency is every 5 minutes. The string is based on UNIX crontab syntax: minute, hour, day of month, month, day of week. Example: 0 *\_/2 * * * - every 2 hours. | `string` | `"0 4 * * *"` | no |
| <a name="input_ci_trigger_timed_enable"></a> [ci\_trigger\_timed\_enable](#input\_ci\_trigger\_timed\_enable) | Set to `true` to enable the CI pipeline Timed trigger. | `bool` | `false` | no |
| <a name="input_ci_trigger_timed_name"></a> [ci\_trigger\_timed\_name](#input\_ci\_trigger\_timed\_name) | The name of the CI pipeline Timed trigger. | `string` | `"Git CI Timed Trigger"` | no |
| <a name="input_ci_trigger_timed_pruner_enable"></a> [ci\_trigger\_timed\_pruner\_enable](#input\_ci\_trigger\_timed\_pruner\_enable) | Set to `true` to enable the timed Pruner trigger. | `bool` | `false` | no |
| <a name="input_ci_trigger_timed_pruner_name"></a> [ci\_trigger\_timed\_pruner\_name](#input\_ci\_trigger\_timed\_pruner\_name) | The name of the timed Pruner trigger. | `string` | `"Evidence Pruner Timed Trigger"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the Kubernetes cluster where the application is deployed. This sets the same cluster for both CI and CD toolchains. See `ci_cluster_name` and `cd_cluster_name` to set different clusters. By default , the cluster namespace for CI will be set to `dev` and CD to `prod`. These can be changed using `ci_cluster_namespace` and `cd_cluster_namespace`. | `string` | `"mycluster-free"` | no |
| <a name="input_compliance_base_image"></a> [compliance\_base\_image](#input\_compliance\_base\_image) | Pipeline baseimage to run most of the built-in pipeline code. | `string` | `""` | no |
| <a name="input_compliance_pipeline_branch"></a> [compliance\_pipeline\_branch](#input\_compliance\_pipeline\_branch) | The Compliance Pipeline branch. | `string` | `"open-v9"` | no |
| <a name="input_cos_api_key_secret_name"></a> [cos\_api\_key\_secret\_name](#input\_cos\_api\_key\_secret\_name) | To enable the use of COS, a secret name to a COS API key secret in the secret provider is required. In addition `cos_endpoint` and `cos_bucket_name` must be set. This setting sets the same API key for the COS settings in the CI, CD, and CC toolchains. See `ci_cos_api_key_secret_name`, `cd_cos_api_key_secret_name`, and `cc_cos_api_key_secret_name` to set separately. | `string` | `"cos-api-key"` | no |
| <a name="input_cos_bucket_name"></a> [cos\_bucket\_name](#input\_cos\_bucket\_name) | Set the name of your COS bucket. This applies the same COS bucket name for the CI, CD, and CC toolchains. See `ci_cos_bucket_name`, `cd_cos_bucket_name`, and `cc_cos_bucket_name` to set separately. | `string` | `""` | no |
| <a name="input_cos_endpoint"></a> [cos\_endpoint](#input\_cos\_endpoint) | Set the Cloud Object Storage endpoint for accessing your COS bucket. This setting sets the same endpoint for COS in the CI, CD, and CC toolchains. See `ci_cos_endpoint`, `cd_cos_endpoint`, and `cc_cos_endpoint` to set the endpoints separately. | `string` | `""` | no |
| <a name="input_create_cc_toolchain"></a> [create\_cc\_toolchain](#input\_create\_cc\_toolchain) | Boolean flag which determines if the DevSecOps CC toolchain is created. | `bool` | `true` | no |
| <a name="input_create_cd_toolchain"></a> [create\_cd\_toolchain](#input\_create\_cd\_toolchain) | Boolean flag which determines if the DevSecOps CD toolchain is created. | `bool` | `true` | no |
| <a name="input_create_ci_toolchain"></a> [create\_ci\_toolchain](#input\_create\_ci\_toolchain) | Flag which determines if the DevSecOps CI toolchain is created. If this toolchain is not created then values must be set for the following variables, evidence\_repo\_url, issues\_repo\_url and inventory\_repo\_url. | `bool` | `true` | no |
| <a name="input_deployment_repo_url"></a> [deployment\_repo\_url](#input\_deployment\_repo\_url) | This is the repository to clone deployment for DevSecOps toolchain template. | `string` | `""` | no |
| <a name="input_enable_key_protect"></a> [enable\_key\_protect](#input\_enable\_key\_protect) | Set to enable Key Protect Integrations. | `bool` | `false` | no |
| <a name="input_enable_secrets_manager"></a> [enable\_secrets\_manager](#input\_enable\_secrets\_manager) | Enable the Secrets Manager integrations. | `bool` | `true` | no |
| <a name="input_enable_slack"></a> [enable\_slack](#input\_enable\_slack) | Set to `true` to create the integration. This requires a valid `slack_channel_name`, `slack_team_name`, and a valid `webhook` (see `slack_webhook_secret_name`). This setting applies for CI, CD, and CC toolchains. To enable Slack separately, see `ci_enable_slack`, `cd_enable_slack`, and `cc_enable_slack`. | `bool` | `false` | no |
| <a name="input_environment_prefix"></a> [environment\_prefix](#input\_environment\_prefix) | By default `ibm:yp:`. This will be set as the prefix to regions automatically where required. For example `ibm:yp:us-south`. | `string` | `"ibm:yp:"` | no |
| <a name="input_event_notifications_crn"></a> [event\_notifications\_crn](#input\_event\_notifications\_crn) | Set the Event Notifications CRN to create an Events Notification integration. This paramater will apply to the CI, CD and CC toolchains. Can be set individually with `ci_event_notifications_crn`, `cd_event_notifications_crn`, `cc_event_notifications_crn`. | `string` | `""` | no |
| <a name="input_event_notifications_tool_name"></a> [event\_notifications\_tool\_name](#input\_event\_notifications\_tool\_name) | The name of the Event Notifications integration. | `string` | `"Event Notifications"` | no |
| <a name="input_evidence_repo_existing_git_id"></a> [evidence\_repo\_existing\_git\_id](#input\_evidence\_repo\_existing\_git\_id) | Set this value to `github` for github.com, or to the GUID of a custom GitHub Enterprise server. | `string` | `""` | no |
| <a name="input_evidence_repo_existing_git_provider"></a> [evidence\_repo\_existing\_git\_provider](#input\_evidence\_repo\_existing\_git\_provider) | Git provider for evidence repo | `string` | `"hostedgit"` | no |
| <a name="input_evidence_repo_existing_url"></a> [evidence\_repo\_existing\_url](#input\_evidence\_repo\_existing\_url) | This is a template repository to clone compliance-evidence-locker for reference DevSecOps toolchain templates. | `string` | `""` | no |
| <a name="input_evidence_repo_integration_owner"></a> [evidence\_repo\_integration\_owner](#input\_evidence\_repo\_integration\_owner) | The name of the integration owner. | `string` | `""` | no |
| <a name="input_evidence_repo_name"></a> [evidence\_repo\_name](#input\_evidence\_repo\_name) | The repository name. | `string` | `""` | no |
| <a name="input_evidence_repo_url"></a> [evidence\_repo\_url](#input\_evidence\_repo\_url) | Deprecated: Use `evidence_repo_existing_url`. This is a template repository to link compliance-evidence-locker for reference DevSecOps toolchain templates. | `string` | `""` | no |
| <a name="input_ibmcloud_api"></a> [ibmcloud\_api](#input\_ibmcloud\_api) | IBM Cloud API Endpoint. | `string` | `"https://cloud.ibm.com"` | no |
| <a name="input_ibmcloud_api_key"></a> [ibmcloud\_api\_key](#input\_ibmcloud\_api\_key) | API key used to create the toolchains. (See deployment guide.) | `string` | n/a | yes |
| <a name="input_inventory_repo_existing_git_id"></a> [inventory\_repo\_existing\_git\_id](#input\_inventory\_repo\_existing\_git\_id) | Set this value to `github` for github.com, or to the GUID of a custom GitHub Enterprise server. | `string` | `""` | no |
| <a name="input_inventory_repo_existing_git_provider"></a> [inventory\_repo\_existing\_git\_provider](#input\_inventory\_repo\_existing\_git\_provider) | Git provider for inventory repo | `string` | `"hostedgit"` | no |
| <a name="input_inventory_repo_existing_url"></a> [inventory\_repo\_existing\_url](#input\_inventory\_repo\_existing\_url) | This is a template repository to clone compliance-inventory for reference DevSecOps toolchain templates. | `string` | `""` | no |
| <a name="input_inventory_repo_integration_owner"></a> [inventory\_repo\_integration\_owner](#input\_inventory\_repo\_integration\_owner) | The name of the integration owner. | `string` | `""` | no |
| <a name="input_inventory_repo_name"></a> [inventory\_repo\_name](#input\_inventory\_repo\_name) | The repository name. | `string` | `""` | no |
| <a name="input_inventory_repo_url"></a> [inventory\_repo\_url](#input\_inventory\_repo\_url) | Deprecated: Use `inventory_repo_existing_url`. This is a template repository to link compliance-inventory for reference DevSecOps toolchain templates. | `string` | `""` | no |
| <a name="input_issues_repo_existing_git_id"></a> [issues\_repo\_existing\_git\_id](#input\_issues\_repo\_existing\_git\_id) | Set this value to `github` for github.com, or to the GUID of a custom GitHub Enterprise server. | `string` | `""` | no |
| <a name="input_issues_repo_existing_git_provider"></a> [issues\_repo\_existing\_git\_provider](#input\_issues\_repo\_existing\_git\_provider) | Git provider for issue repo | `string` | `"hostedgit"` | no |
| <a name="input_issues_repo_existing_url"></a> [issues\_repo\_existing\_url](#input\_issues\_repo\_existing\_url) | This is a template repository to clone compliance-issues for reference DevSecOps toolchain templates. | `string` | `""` | no |
| <a name="input_issues_repo_integration_owner"></a> [issues\_repo\_integration\_owner](#input\_issues\_repo\_integration\_owner) | The name of the integration owner. | `string` | `""` | no |
| <a name="input_issues_repo_name"></a> [issues\_repo\_name](#input\_issues\_repo\_name) | The repository name. | `string` | `""` | no |
| <a name="input_issues_repo_url"></a> [issues\_repo\_url](#input\_issues\_repo\_url) | Deprecated: Use `issues_repo_existing_url`. This is a template repository to link compliance-issues for reference DevSecOps toolchain templates. | `string` | `""` | no |
| <a name="input_kp_integration_name"></a> [kp\_integration\_name](#input\_kp\_integration\_name) | The name of the Key Protect integration. | `string` | `"kp-compliance-secrets"` | no |
| <a name="input_kp_location"></a> [kp\_location](#input\_kp\_location) | The region location of the Key Protect instance. This applies to the CI, CD and CC Key Protect integrations. See `ci_kp_location`, `cd_kp_location`, and `cc_kp_location` to set separately. | `string` | `"us-south"` | no |
| <a name="input_kp_name"></a> [kp\_name](#input\_kp\_name) | Name of the Key Protect instance where the secrets are stored. This applies to the CI, CD and CC Key Protect integrations. See `ci_kp_name`, `cd_kp_name`, and `cc_kp_name` to set separately. | `string` | `"kp-compliance-secrets"` | no |
| <a name="input_kp_resource_group"></a> [kp\_resource\_group](#input\_kp\_resource\_group) | The resource group containing the Key Protect instance. This applies to the CI, CD and CC Key Protect integrations. See `ci_kp_resource_group`, `cd_kp_resource_group`, and `cc_kp_resource_group` to set separately. | `string` | `"Default"` | no |
| <a name="input_peer_review_compliance"></a> [peer\_review\_compliance](#input\_peer\_review\_compliance) | Set to `0` to disable. Set to `1` to enable peer review evidence collection. This parameter will apply to the CI, CD and CC pipelines. Can be set individually with `ci_peer_review_compliance`, `cd_peer_review_compliance`, `cc_peer_review_compliance`. | `string` | `""` | no |
| <a name="input_registry_namespace"></a> [registry\_namespace](#input\_registry\_namespace) | A unique namespace within the IBM Cloud Container Registry region where the application image is stored. | `string` | `""` | no |
| <a name="input_repo_git_token_secret_name"></a> [repo\_git\_token\_secret\_name](#input\_repo\_git\_token\_secret\_name) | Name of the Git token secret in the secret provider. Specifying a secret name for the Git Token automatically sets the authentication type to `pat`. | `string` | `""` | no |
| <a name="input_repo_group"></a> [repo\_group](#input\_repo\_group) | Specify Git user or group for your application. This must be set if the repository authentication type is `pat` (personal access token). | `string` | `""` | no |
| <a name="input_repo_secret_group"></a> [repo\_secret\_group](#input\_repo\_secret\_group) | Secret group in Secrets Manager that contains the secret for the repo. This variable will set the same secret group for all the repositories. Can be overriden on a per secret group basis. Only applies when using Secrets Manager. | `string` | `""` | no |
| <a name="input_repositories_prefix"></a> [repositories\_prefix](#input\_repositories\_prefix) | Prefix name for the cloned compliance repos. | `string` | `"compliance"` | no |
| <a name="input_scc_attachment_id"></a> [scc\_attachment\_id](#input\_scc\_attachment\_id) | An attachment ID. An attachment is configured under a profile to define how a scan will be run. To find the attachment ID, in the browser, in the attachments list, click on the attachment link, and a panel appears with a button to copy the attachment ID. This parameter is only relevant when the `scc_use_profile_attachment` parameter is enabled. | `string` | `""` | no |
| <a name="input_scc_instance_crn"></a> [scc\_instance\_crn](#input\_scc\_instance\_crn) | The Security and Compliance Center service instance CRN (Cloud Resource Name). This parameter is only relevant when the `scc_use_profile_attachment` parameter is enabled. The value must match the regular expression. | `string` | `""` | no |
| <a name="input_scc_profile_name"></a> [scc\_profile\_name](#input\_scc\_profile\_name) | The name of a Security and Compliance Center profile. Use the `IBM Cloud for Financial Services` profile, which contains the DevSecOps Toolchain rules. Or use a user-authored customized profile that has been configured to contain those rules. This parameter is only relevant when the `scc_use_profile_attachment` parameter is enabled. | `string` | `""` | no |
| <a name="input_scc_profile_version"></a> [scc\_profile\_version](#input\_scc\_profile\_version) | The version of a Security and Compliance Center profile, in SemVer format, like `0.0.0`. This parameter is only relevant when the `scc_use_profile_attachment` parameter is enabled. | `string` | `""` | no |
| <a name="input_scc_scc_api_key_secret_group"></a> [scc\_scc\_api\_key\_secret\_group](#input\_scc\_scc\_api\_key\_secret\_group) | Secret group prefix for the Security and Compliance tool secret. Defaults to `sm_secret_group` if not set. Only used with `Secrets Manager`. | `string` | `""` | no |
| <a name="input_scc_scc_api_key_secret_name"></a> [scc\_scc\_api\_key\_secret\_name](#input\_scc\_scc\_api\_key\_secret\_name) | The Security and Compliance Center api-key secret in the secret provider. | `string` | `"scc-api-key"` | no |
| <a name="input_scc_use_profile_attachment"></a> [scc\_use\_profile\_attachment](#input\_scc\_use\_profile\_attachment) | Set to `enabled` to enable use profile with attachment, so that the scripts in the pipeline can interact with the Security and Compliance Center service. When enabled, other parameters become relevant; `scc_scc_scc_api_key_secret_name`, `scc_instance_crn`, `scc_profile_name`, `scc_profile_version`, `scc_attachment_id`. Can individually be `enabled` and `disabled` in the CD and CC toolchains using `cd_scc_use_profile_attachment` and `cc_scc_use_profile_attachment`. | `string` | `"disabled"` | no |
| <a name="input_slack_channel_name"></a> [slack\_channel\_name](#input\_slack\_channel\_name) | The Slack channel that notifications are posted to. This applies to the CI, CD, and CC toolchains. To set separately see `ci_slack_channel_name`, `cd_slack_channel_name`, and `cc_slack_channel_name` | `string` | `""` | no |
| <a name="input_slack_integration_name"></a> [slack\_integration\_name](#input\_slack\_integration\_name) | The name of the Slack integration. | `string` | `"slack-compliance"` | no |
| <a name="input_slack_notifications"></a> [slack\_notifications](#input\_slack\_notifications) | This is enabled automatically when a Slack integration is created. The switch overrides the Slack notifications. Set `1` for on and `0` for off. This applies to the CI, CD, and CC toolchains. To set separately, see `ci_slack_notifications`, `cd_slack_notifications`, and `cc_slack_notifications`. | `string` | `""` | no |
| <a name="input_slack_team_name"></a> [slack\_team\_name](#input\_slack\_team\_name) | The Slack team name, which is the word or phrase before `.slack.com` in the team URL. This applies to the CI, CD, and CC toolchains. To set separately, see `ci_slack_team_name`, `cd_slack_team_name`, and `cc_slack_team_name`. | `string` | `""` | no |
| <a name="input_slack_webhook_secret_name"></a> [slack\_webhook\_secret\_name](#input\_slack\_webhook\_secret\_name) | Name of the webhook secret for Slack in the secret provider. This applies to the CI, CD, and CC toolchains. To set separately, see `ci_slack_webhook_secret_name`, `cd_slack_webhook_secret_name`, and `cc_slack_webhook_secret_name` | `string` | `"slack-webhook"` | no |
| <a name="input_sm_integration_name"></a> [sm\_integration\_name](#input\_sm\_integration\_name) | The name of the Secrets Manager integration. | `string` | `"sm-compliance-secrets"` | no |
| <a name="input_sm_location"></a> [sm\_location](#input\_sm\_location) | The region location of the Secrets Manager instance. This applies to the CI, CD and CC Secret Manager integrations. See `ci_sm_location`, `cd_sm_location`, and `cc_sm_location` to set separately. | `string` | `"us-south"` | no |
| <a name="input_sm_name"></a> [sm\_name](#input\_sm\_name) | The name of the Secret Managers instance. This applies to the CI, CD and CC Secret Manager integrations. See `ci_sm_name`, `cd_sm_name`, and `cc_sm_name` to set separately. | `string` | `"sm-instance"` | no |
| <a name="input_sm_resource_group"></a> [sm\_resource\_group](#input\_sm\_resource\_group) | The resource group containing the Secrets Manager instance. This applies to the CI, CD and CC Secret Manager integrations. See `ci_sm_resource_group`, `cd_sm_resource_group`, and `cc_sm_resource_group` to set separately. | `string` | `"Default"` | no |
| <a name="input_sm_secret_group"></a> [sm\_secret\_group](#input\_sm\_secret\_group) | Group in Secrets Manager for organizing/grouping secrets. This applies to the CI, CD and CC Secret Manager integrations. See `ci_sm_secret_group`, `cd_sm_secret_group`, and `cc_sm_secret_group` to set separately. | `string` | `"Default"` | no |
| <a name="input_toolchain_name"></a> [toolchain\_name](#input\_toolchain\_name) | Common element of the toolchain name. The toolchain names will be appended with `CI Toolchain` or `CD Toolchain` or `CC Toolchain` followed by a timestamp. Can explicitly be set using `ci_toolchain_name`, `cd_toolchain_name`, and `cc_toolchain_name`. | `string` | `"DevSecOps"` | no |
| <a name="input_toolchain_region"></a> [toolchain\_region](#input\_toolchain\_region) | The region identifier that will be used, by default, for all resource creation and service instance lookup. This can be overridden on a per resource/service basis. See `ci_toolchain_region`,`cd_toolchain_region`,`cc_toolchain_region`, `ci_cluster_region`, `cd_cluster_region`, `ci_registry_region`. | `string` | `"us-south"` | no |
| <a name="input_toolchain_resource_group"></a> [toolchain\_resource\_group](#input\_toolchain\_resource\_group) | The resource group that will be used, by default, for all resource creation and service instance lookups. This can be overridden on a per resource/service basis. See `ci_toolchain_resource_group`,`cd_toolchain_resource_group`,`cc_toolchain_resource_group`, `ci_cluster_resource_group`. | `string` | `"Default"` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_repo_url"></a> [app\_repo\_url](#output\_app\_repo\_url) | The App Repo URL |
| <a name="output_cc_pipeline_id"></a> [cc\_pipeline\_id](#output\_cc\_pipeline\_id) | The CC pipeline Id |
| <a name="output_cd_pipeline_id"></a> [cd\_pipeline\_id](#output\_cd\_pipeline\_id) | The CD pipeline Id |
| <a name="output_ci_pipeline_id"></a> [ci\_pipeline\_id](#output\_ci\_pipeline\_id) | The CI pipeline Id |
| <a name="output_compliance_cc_toolchain_id"></a> [compliance\_cc\_toolchain\_id](#output\_compliance\_cc\_toolchain\_id) | The ID of the Compliance CC Toolchain |
| <a name="output_compliance_cc_toolchain_url"></a> [compliance\_cc\_toolchain\_url](#output\_compliance\_cc\_toolchain\_url) | The Compliance CC Toolchain URL |
| <a name="output_compliance_cd_toolchain_id"></a> [compliance\_cd\_toolchain\_id](#output\_compliance\_cd\_toolchain\_id) | The ID of the Compliance CD Toolchain |
| <a name="output_compliance_cd_toolchain_url"></a> [compliance\_cd\_toolchain\_url](#output\_compliance\_cd\_toolchain\_url) | The Compliance CD Toolchain URL |
| <a name="output_compliance_ci_toolchain_id"></a> [compliance\_ci\_toolchain\_id](#output\_compliance\_ci\_toolchain\_id) | The ID of the Compliance CI Toolchain |
| <a name="output_compliance_ci_toolchain_url"></a> [compliance\_ci\_toolchain\_url](#output\_compliance\_ci\_toolchain\_url) | The Compliance CI Toolchain URL |
| <a name="output_evidence_repo_url"></a> [evidence\_repo\_url](#output\_evidence\_repo\_url) | The Evidence Repo URL |
| <a name="output_inventory_repo_url"></a> [inventory\_repo\_url](#output\_inventory\_repo\_url) | The Inventory Repo URL |
| <a name="output_issues_repo_url"></a> [issues\_repo\_url](#output\_issues\_repo\_url) | The Issues Repo URL |
| <a name="output_key_protect_instance_id"></a> [key\_protect\_instance\_id](#output\_key\_protect\_instance\_id) | The Key Protect Instance ID |
| <a name="output_pr_pipeline_id"></a> [pr\_pipeline\_id](#output\_pr\_pipeline\_id) | The PR pipeline Id |
| <a name="output_secrets_manager_instance_id"></a> [secrets\_manager\_instance\_id](#output\_secrets\_manager\_instance\_id) | The Secrets Manage Instance ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- BEGIN CONTRIBUTING HOOK -->

<!-- Leave this section as is so that your module has a link to local development environment set up steps for contributors to follow -->
## Contributing

You can report issues and request features for this module in GitHub issues in the module repo. See [Report an issue or request a feature](https://github.com/terraform-ibm-modules/.github/blob/main/.github/SUPPORT.md).

To set up your local development environment, see [Local development setup](https://terraform-ibm-modules.github.io/documentation/#/local-dev-setup) in the project documentation.
<!-- Source for this readme file: https://github.com/terraform-ibm-modules/common-dev-assets/tree/main/module-assets/ci/module-template-automation -->
<!-- END CONTRIBUTING HOOK -->
