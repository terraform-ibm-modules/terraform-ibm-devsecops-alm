# Key Protect and CI only example

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
