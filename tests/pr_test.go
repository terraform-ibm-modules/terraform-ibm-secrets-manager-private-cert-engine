// Tests in this file are run in the PR pipeline
package test

import (
	"log"
	"os"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/common"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testschematic"
)

const resourceGroup = "geretain-test-sm-prv-cert-eng"
const defaultExampleTerraformDir = "examples/default"
const bestRegionYAMLPath = "../common-dev-assets/common-go-assets/cloudinfo-region-secmgr-prefs.yaml"

// Define a struct with fields that match the structure of the YAML data
const yamlLocation = "../common-dev-assets/common-go-assets/common-permanent-resources.yaml"

var permanentResources map[string]interface{}

// TestMain will be run before any parallel tests, used to read data from yaml for use with tests
func TestMain(m *testing.M) {

	var err error
	permanentResources, err = common.LoadMapFromYaml(yamlLocation)
	if err != nil {
		log.Fatal(err)
	}

	os.Exit(m.Run())
}

func TestRunSolutionsFullyConfigurableSchematics(t *testing.T) {
	t.Parallel()

	const testLocation = "solutions/fully-configurable"

	options := testschematic.TestSchematicOptionsDefault(&testschematic.TestSchematicOptions{
		Testing: t,
		Prefix:  "sm-pce",
		TarIncludePatterns: []string{
			"*.tf",
			testLocation + "/*.tf",
		},
		ResourceGroup:          resourceGroup,
		TemplateFolder:         testLocation,
		Tags:                   []string{"test-schematic"},
		DeleteWorkspaceOnFail:  false,
		WaitJobCompleteMinutes: 80,
	})

	options.TerraformVars = []testschematic.TestSchematicTerraformVar{
		{Name: "ibmcloud_api_key", Value: options.RequiredEnvironmentVars["TF_VAR_ibmcloud_api_key"], DataType: "string", Secure: true},
		{Name: "existing_secrets_manager_crn", Value: permanentResources["secretsManagerCRN"], DataType: "string"},
		{Name: "prefix", Value: options.Prefix, DataType: "string"},
	}

	err := options.RunSchematicTest()
	assert.Nil(t, err, "This should not have errored")
}

func TestRunSolutionsFullyConfigurableUpgradeSchematics(t *testing.T) {
	t.Parallel()

	const testLocation = "solutions/fully-configurable"

	options := testschematic.TestSchematicOptionsDefault(&testschematic.TestSchematicOptions{
		Testing: t,
		Prefix:  "sm-pce-up",
		TarIncludePatterns: []string{
			"*.tf",
			testLocation + "/*.tf",
		},
		ResourceGroup:          resourceGroup,
		TemplateFolder:         testLocation,
		Tags:                   []string{"test-schematic"},
		DeleteWorkspaceOnFail:  false,
		WaitJobCompleteMinutes: 80,
	})

	options.TerraformVars = []testschematic.TestSchematicTerraformVar{
		{Name: "ibmcloud_api_key", Value: options.RequiredEnvironmentVars["TF_VAR_ibmcloud_api_key"], DataType: "string", Secure: true},
		{Name: "existing_secrets_manager_crn", Value: permanentResources["secretsManagerCRN"], DataType: "string"},
		{Name: "prefix", Value: options.Prefix, DataType: "string"},
	}

	err := options.RunSchematicUpgradeTest()
	assert.Nil(t, err, "This should not have errored")
}
