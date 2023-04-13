# Setup AzureAD OIDC on ARO

This directory contains Terraform config that is used to add `OpenID Azure AD` oAuth Identity Provider as well
as add AzureAD secret to an existing ARO cluster.
  
Execute following commands and substitute all the properties values with correct values in `custom.tfvars` file:
```
cp custom.tfvars.template custom.tfvars
```
Using the `custom.tfvars` file will allow to use this file for variables instead of being prompted for each variable.
  
To generate `kubeconfig`, execute following commands:
```
./run.sh
```
  
This script will allow you to initialize `terraform` or `import` or `plan` or `apply` the
changes.
  
  When running in `plan` mode, it will prompt to ask for whether to use file or prompt for variables:
  * File/prompt - give `file` as the value
  
    If `prompt` value is provided for previous input, it will prompt for the following variable values:
    * Resource prefix
    * ARO resource group
    * ARO cluster name
    * Location
    * Tenant ID
    * Client ID
    * Client Secret
  
  Some of these fields have default values but can be overridden by providing
  new values. Once all the values are provided the script invokes `terraform`
  by passing in the input values to corresponding variables needed by the
  Terraform scripts.
  
  To run Terraform without using the script, please use the following command
  (substitute values with correct ones)
  ```
  terraform plan -out main.tfplan -var-file=custom.tfvars
  ```
  
**To add the `oidc`, follow these steps by inputting `file` when prompted for file/prompt:**
* Select `import`
* Once the import completes successfully, execute `./run.sh` again and select
  `plan`, and then select `apply` when prompted to choose between apply and destroy
* Once the plan completes successfully, execute `./run.sh` again and select
  `apply`
* Once `apply` runs
  
## Variables used in this module:
  * `resource_group_name`: Represents the name of the Resource Group
  * `cluster_name`: Name of the ARO cluster
  * `region`: Region/Location of the resource group
  * `tenant_id`: Tenant ID
  * `client_id`: Client ID
  * `client_secret`: Client Secret (password)
