# NT548.P11_Lab1

## Terraform AWS Infrastructure with Terratest

This project contains Terraform configurations to deploy infrastructure on AWS, including VPC, EC2 instances, NAT Gateway, and other networking components. It also includes Terratest code to automatically validate and test the infrastructure.

### Prerequisites

Before you can run the source code and tests, ensure the following prerequisites are installed and configured:

1. **Terraform**: Install Terraform by following the instructions from [Terraform's official website](https://www.terraform.io/downloads).
2. **Go (Golang)**: Install Go from [Go's official website](https://golang.org/dl/) to run the Terratest code.
3. **AWS CLI**: Install and configure the AWS CLI. Follow the instructions [here](https://aws.amazon.com/cli/).
4. **AWS Account**: Ensure you have AWS credentials set up (`~/.aws/credentials`).
5. **Go Modules**: This project uses Go modules. Ensure `go mod` is enabled by running `go mod init <module-name>` in the Terratest directory.
### Project Structure
```
.
├── Cloud Formation
│   ├── main.yaml
│   └── modules
│       ├── ec2
│       │   └── ec2.yaml
│       ├── nat_gateway
│       │   └── nat_gateway.yaml
│       ├── route_table
│       │   └── route_table.yaml
│       ├── security_groups
│       │   └── security_groups.yaml
│       └── vpc
│           └── vpc.yaml
├── README.md
├── Terraform
│   ├── main.tf
│   ├── modules
│   │   ├── ec2
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   ├── terraform.tfvars
│   │   │   └── variables.tf
│   │   ├── nat_gateway
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── route_table
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   ├── security_groups
│   │   │   ├── main.tf
│   │   │   ├── outputs.tf
│   │   │   └── variables.tf
│   │   └── vpc
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       └── variables.tf
│   ├── output.tf
│   └── variables.tf
└── Test
    └── terraform
        ├── extracted_log.txt
        ├── go.mod
        ├── go.sum
        ├── key-15.pem
        ├── terraform.tfstate
        ├── test.sh
        └── test_terraform_infrastructure_test.go
```
### Setting Up the Environment
#### Clone the Repository:
```bash
git clone https://github.com/roro1230/NT548.P11_Lab1.git
cd NT548.P11_Lab1
```
#### Install Go Dependencies: Navigate to the test directory and install the dependencies using `go mod tidy`:
```bash
cd Test/terraform
go mod tidy
```
#### Set Up AWS Credentials: Ensure that you have set up AWS credentials using the AWS CLI
```bash
aws configure
```
This will prompt you to enter your AWS Access Key, Secret Key, region, and output format.
#### Adjust variables
Modify `allowed_ssh_ip` and other variables in the `test_terraform_infrastructure_test.go` file or `/Terraform/main.tf` configuration if needed.\
Create ssh key
```bash
aws ec2 create-key-pair --key-name <your-key-name> --query 'KeyMaterial' --output text > <your-key-name>.pem
```
Replace `<your-key-name>` with the name you want for your key pair.\
After creating the key pair, you need to set appropriate permissions for the .pem file to ensure secure SSH connections:
```bash
chmod 400 my-key-pair.pem
```
Replace `key-name` in `Terraform/main.tf`, `Test/terraform/test_terraform_infrastructure_test.go`, and `key-15.pem` in `/Test/terraform` by your key.
### Running Terraform
#### Initialize Terraform
Before applying the infrastructure, navigate to the Terraform directory and initialize Terraform:
```bash
cd Terraform
terraform init
```
#### Apply the Infrastructure
To deploy the infrastructure, use the following command:
```bash
terraform apply -auto-approve
```
This will prompt for confirmation to create the resources.
#### Destroy the Infrastructure
Once testing is complete, you can destroy the infrastructure to avoid incurring charges:
```bash
terraform destroy -auto-approve
```
### Running Terratest
#### Run the Terratest
To run the automated Terratest that validates the deployed infrastructure, navigate to the `/Test/terraform` directory and execute the Go test:
```bash
cd Test/terraform
bash test.sh
```
This will run the Terratest suite, applying the Terraform configuration, validating it, and finally tearing down the resources.
#### Test Output
You should see logs showing the output of resource creation, validations (such as SSH connection), and the destruction of the resources. The test output will indicate whether the test passed or failed.\
Example of the output:
```results.txt
TestTerraformInfrastructure 2024-10-19T14:54:56+07:00 retry.go:91: Trying to connect to public instance
TestTerraformInfrastructure 2024-10-19T14:54:56+07:00 ssh.go:471: Running command 'exit' on ec2-user@18.234.107.215
    test_terraform_infrastructure_test.go:80: SUCCESS - SSH Connection Successful
--- PASS: TestTerraformInfrastructure (232.17s)
PASS
```