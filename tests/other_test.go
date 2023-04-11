// Tests in this file are NOT run in the PR pipeline. They are run in the continuous testing pipeline along with the ones in pr_test.go
package test

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testhelper"
)

const nonDefaultExampleTerraformDir = "examples/devsecops-ci-toolchain-bring-your-own-app"

func TestRunNonDefaultExample(t *testing.T) {
	t.Parallel()

	options := testhelper.TestOptionsDefault(&testhelper.TestOptions{
		Testing:      t,
		TerraformDir: defaultExampleTerraformDir,
		IgnoreUpdates: testhelper.Exemptions{ // Ignore for consistency check
			List: []string{
				"module.devsecops_cc_toolchain[0].module.pipeline-cc.ibm_cd_tekton_pipeline_trigger.cc_pipeline_timed_trigger",
				"module.devsecops_cd_toolchain[0].module.repositories.ibm_cd_toolchain_tool_hostedgit.deployment_repo_clone_from_hostedgit[0]",
			},
		},
	})

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}
