// Tests in this file are run in the PR pipeline
package test

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testhelper"
)

// Use existing resource group from "2626712 - IDS AuthService's Account"
const resourceGroup = "product-management"
const defaultExampleTerraformDir = "examples/default"
const appExampleDir = "examples/devsecops-ci-toolchain-bring-your-own-app"
const kpExampleDir = "examples/devsecops-ci-toolchain-with-key-protect"

func TestRunDefaultExample(t *testing.T) {
	t.Parallel()

	options := testhelper.TestOptionsDefault(&testhelper.TestOptions{
		Testing:      t,
		TerraformDir: defaultExampleTerraformDir,
		TerraformVars: map[string]interface{}{
			"enable_secrets_manager":   false,
			"enable_key_protect":       false,
			"toolchain_resource_group": resourceGroup,
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
		TerraformVars: map[string]interface{}{
			"toolchain_resource_group": resourceGroup,
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
		TerraformVars: map[string]interface{}{
			"toolchain_resource_group": resourceGroup,
		},
	})

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}

func TestRunUpgradeExample(t *testing.T) {
	t.Parallel()

	// TODO: Remove this line after the first merge to primary branch is complete to enable upgrade test
	//t.Skip("Skipping upgrade test until initial code is in primary branch")

	options := testhelper.TestOptionsDefault(&testhelper.TestOptions{
		Testing:      t,
		TerraformDir: defaultExampleTerraformDir,
		TerraformVars: map[string]interface{}{
			"toolchain_resource_group": resourceGroup,
		},
	})

	output, err := options.RunTestUpgrade()
	if !options.UpgradeTestSkipped {
		assert.Nil(t, err, "This should not have errored")
		assert.NotNil(t, output, "Expected some output")
	}
}
