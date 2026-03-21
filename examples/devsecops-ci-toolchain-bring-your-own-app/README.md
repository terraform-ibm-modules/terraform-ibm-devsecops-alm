# Bring your own app example

<!-- BEGIN SCHEMATICS DEPLOY HOOK -->
<p>
  <a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=devsecops-alm-devsecops-ci-toolchain-bring-your-own-app-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-devsecops-alm/tree/main/examples/devsecops-ci-toolchain-bring-your-own-app">
    <img src="https://img.shields.io/badge/Deploy%20with%20IBM%20Cloud%20Schematics-0f62fe?style=flat&logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics">
  </a><br>
  ℹ️ Ctrl/Cmd+Click or right-click on the Schematics deploy button to open in a new tab.
</p>
<!-- END SCHEMATICS DEPLOY HOOK -->

An end-to-end example that creates the DevSecOps CI toolchain only. It exposes the minimum amount of variables that should be configured to get a working custom CI toolchain. See the [DevSecOps docs](https://cloud.ibm.com/docs/devsecops?topic=devsecops-cd-devsecops-tekton-ci-compliance) for the prerequisites for running the toolchains.

This example requires several additional variables to the ones exposed in the default example. See the example tfvars file for more details
