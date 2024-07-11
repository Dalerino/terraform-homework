# terraform-homework

# Using tfvars Files with Terraform 
This document provides guidelines on how to use tfvars files with Terraform to manage configuration variables. 

## What is a tfvars File? 
A tfvars file in Terraform is used to set input variables to specific values when executing Terraform commands. This allows you to customize configurations without modifying the main Terraform configuration files. 

## Creating a tfvars File 

To create a tfvars file: 

1. **File Naming**: Name your tfvars file with a `.tfvars` extension. Example: `terraform.tfvars`. 

2. **File Content**: Open the tfvars file using a text editor and define variables using the following format: ```hcl variable_name = "value" another_variable = 123 ``` Replace `variable_name` with the actual variable name from your Terraform configuration. 

3. **Save the File**: Save the tfvars file in the same directory as your main Terraform configuration files. 


## Using tfvars Files To use a tfvars file when running Terraform commands: 

1. **Initialize Terraform**: Run `terraform init` in your terminal to initialize your Terraform environment. 

2. **Apply Configuration**: When applying or planning changes with Terraform, use the `-var-file` flag to specify the path to your tfvars file: ```sh terraform apply -var-file="terraform.tfvars" ``` Replace `"terraform.tfvars"` with the actual filename of your tfvars file. 

3. **Verify Changes**: Terraform will use the values from your tfvars file to apply or plan changes according to your configuration. 

**Version Control**: Include tfvars files in your version control system (e.g., Git) alongside your Terraform configuration files to maintain version history and track changes. 
## Example Here's an example of a tfvars file (`terraform.tfvars`): ```hcl region = "us-west-2" instance_type = "t2.micro"
