// Tests in this file are run in the PR pipeline
package test

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testhelper"
)

// Use existing resource group
const resourceGroup = "geretain-test-resources"
const defaultExampleTerraformDir = "examples/default"
const appExampleDir = "examples/devsecops-ci-toolchain-bring-your-own-app"
const kpExampleDir = "examples/devsecops-ci-toolchain-with-key-protect"

func TestRunDefaultExample(t *testing.T) {
	t.Parallel()

	options := testhelper.TestOptionsDefault(&testhelper.TestOptions{
		Testing:      t,
		TerraformDir: defaultExampleTerraformDir,
		IgnoreUpdates: testhelper.Exemptions{ // Ignore for consistency check
			List: []string{
				"module.terraform_devsecops_alm.module.devsecops_cc_toolchain[0].module.pipeline_cc.ibm_cd_tekton_pipeline_trigger.cc_pipeline_timed_trigger",
			},
		},
		TerraformVars: map[string]interface{}{
			"enable_secrets_manager": false,
			"enable_key_protect":     false,
		},
	})

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}

func TestRunAppExample(t *testing.T) {
	t.Parallel()

	options := testhelper.TestOptionsDefault(&testhelper.TestOptions{
		Testing:      t,
		TerraformDir: appExampleDir,
		IgnoreUpdates: testhelper.Exemptions{ // Ignore for consistency check
			List: []string{
				"module.terraform_devsecops_alm.module.devsecops_ci_toolchain[0].ibm_cd_toolchain.toolchain_instance",
			},
		},
	})

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}

func TestRunKPExample(t *testing.T) {
	t.Parallel()

	options := testhelper.TestOptionsDefault(&testhelper.TestOptions{
		Testing:      t,
		TerraformDir: kpExampleDir,
		IgnoreUpdates: testhelper.Exemptions{ // Ignore for consistency check
			List: []string{
				"module.terraform_devsecops_alm.module.devsecops_ci_toolchain[0].ibm_cd_toolchain.toolchain_instance",
			},
		},
	})

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}

func TestRunUpgradeExample(t *testing.T) {
	t.Parallel()

	// TODO: Remove this line after the first merge to primary branch is complete to enable upgrade test
	t.Skip("Skipping upgrade test until initial code is in primary branch")

	options := testhelper.TestOptionsDefault(&testhelper.TestOptions{
		Testing:      t,
		TerraformDir: defaultExampleTerraformDir,
		IgnoreUpdates: testhelper.Exemptions{ // Ignore for consistency check
			List: []string{
				"module.terraform_devsecops_alm.module.devsecops_cc_toolchain[0].module.pipeline_cc.ibm_cd_tekton_pipeline_trigger.cc_pipeline_timed_trigger",
				"module.terraform_devsecops_alm.module.devsecops_cd_toolchain[0].module.repositories.ibm_cd_toolchain_tool_hostedgit.deployment_repo_clone_from_hostedgit[0]",
				"module.terraform_devsecops_alm.module.devsecops_ci_toolchain[0].ibm_cd_toolchain.toolchain_instance",
				"module.terraform_devsecops_alm.module.devsecops_cd_toolchain[0].ibm_cd_toolchain.toolchain_instance",
				"module.terraform_devsecops_alm.module.devsecops_cc_toolchain[0].ibm_cd_toolchain.toolchain_instance",
			},
		},
	})

	output, err := options.RunTestUpgrade()
	if !options.UpgradeTestSkipped {
		assert.Nil(t, err, "This should not have errored")
		assert.NotNil(t, output, "Expected some output")
	}
}
