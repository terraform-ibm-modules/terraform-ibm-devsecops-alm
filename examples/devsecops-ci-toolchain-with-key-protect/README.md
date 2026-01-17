# Key Protect and CI only example

<!-- BEGIN SCHEMATICS DEPLOY HOOK -->
<a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=devsecops-alm-devsecops-ci-toolchain-with-key-protect-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-devsecops-alm/tree/main/examples/devsecops-ci-toolchain-with-key-protect"><img src="https://img.shields.io/badge/Deploy%20with IBM%20Cloud%20Schematics-0f62fe?logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics" style="height: 16px; vertical-align: text-bottom;"></a>
<!-- END SCHEMATICS DEPLOY HOOK -->


An end-to-end example that creates the DevSecOps CI toolchain only. It exposes the minimum amount of variables that should be configured to get a working custom CI toolchain using Key Protect as the secrets provider. See the [DevSecOps docs](https://cloud.ibm.com/docs/devsecops?topic=devsecops-cd-devsecops-tekton-ci-compliance) for the prerequisites for running the toolchains.

This example requires several additional variables to the ones exposed in the default example.
- `create_ci_toolchain = true`
- `create_cd_toolchain = false`
- `create_cc_toolchain = false`

The following variables control which secrets provider is used
- `enable_key_protect       = true`
- `enable_secrets_manager   = false`

The required variables for configuring Key Protect
- `kp_name                  = "key-protect-instance-name"`
- `kp_location              = "eu-gb"`
- `kp_resource_group        = "Default"`

See the example tfvars file for more details

<!-- BEGIN SCHEMATICS DEPLOY TIP HOOK -->
:information_source: Ctrl/Cmd+Click or right-click on the Schematics deploy button to open in a new tab
<!-- END SCHEMATICS DEPLOY TIP HOOK -->
