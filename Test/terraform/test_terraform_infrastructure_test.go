package test

import (
	"testing"
	"time"
	"os"

	"github.com/gruntwork-io/terratest/modules/ssh"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/gruntwork-io/terratest/modules/retry"
	"github.com/stretchr/testify/assert"
)

func TestTerraformInfrastructure(t *testing.T) {
	t.Parallel()

	// Define Terraform options
	terraformOptions := &terraform.Options{
		// The path to the directory where your Terraform code is located
		TerraformDir: "../../Terraform", // Adjust this path as necessary

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"allowed_ssh_ip": "42.118.228.109/32", // Replace with your public IP
		},
	}

	// Ensure Terraform destroy is run at the end of the test
	defer terraform.Destroy(t, terraformOptions)

	// Run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Fetch outputs from the Terraform configuration
	vpcID := terraform.Output(t, terraformOptions, "vpc_id")
	publicInstanceID := terraform.Output(t, terraformOptions, "public_instance_id")
	privateInstanceID := terraform.Output(t, terraformOptions, "private_instance_id")
	publicInstanceIP := terraform.Output(t, terraformOptions, "public_instance_public_ip")


	// Log Module ID with instance and VPC information
	t.Logf("SUCCESS - VPC ID: %s", vpcID)
	t.Logf("SUCCESS - Public Instance ID: %s", publicInstanceID)
	t.Logf("SUCCESS - Private Instance ID: %s", privateInstanceID)
	t.Logf("SUCCESS - Public Instance IP: %s", publicInstanceIP)

	// Test that EC2 instances were created successfully
	assert.NotEmpty(t, publicInstanceID, "Public EC2 instance ID should not be empty")
	assert.NotEmpty(t, privateInstanceID, "Private EC2 instance ID should not be empty")

	// Test that the public instance has a public IP
	assert.NotEmpty(t, publicInstanceIP, "Public EC2 instance should have a public IP")

	// Load the private key
	privateKeyPath := "key-15.pem" // Replace this with the actual path to your .pem file
	privateKey, err := os.ReadFile(privateKeyPath)
	if err != nil {
        t.Fatalf("ERROR - Failed to load private key: %v", err)
    }
	t.Logf("SUCCESS - Load private key successful")

	// Create SSH KeyPair struct
    keyPair := &ssh.KeyPair{
        PrivateKey: string(privateKey),
    }

	// Create an SSH host
	sshHost := ssh.Host{
		Hostname:    publicInstanceIP,
		SshUserName: "ec2-user", // Replace with the correct username for your AMI (e.g., "ubuntu" for Ubuntu)
		SshKeyPair:  keyPair,
	}

	// Check if port 22 is open (SSH) for the public EC2 instance using Terratest SSH module
	retry.DoWithRetry(t, "Trying to connect to public instance", 5, 10*time.Second, func() (string, error) {
		err := ssh.CheckSshConnectionE(t, sshHost)
		if err != nil {
			return "", err
		}
		t.Logf("SUCCESS - SSH Connection Successful")
		return "SSH Connection Successful", nil
	})
}
