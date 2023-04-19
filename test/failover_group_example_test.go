package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestFailoverGroupExample(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/failover-group",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}
