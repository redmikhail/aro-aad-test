# Get KubeConfig

This directory contains Terraform config that can be used to generate kubeconfig
  
Execute following commands and substitute all the properties values with correct values in `custom.tfvars` file:
```
cp custom.tfvars.template custom.tfvars
```
Using the `custom.tfvars` file will allow to use this file for variables instead of being prompted for each variable.
  
To generate `kubeconfig`, execute following commands:
```
cd aro_kube_config
./run.sh
```
  
This script will allow you to initialize `terraform` or `plan` or `apply` the
changes.
  
  When running in `plan` mode, it will prompt to ask for whether to use file or prompt for variables:
  * File/prompt - give `file` as the value
  
    If `prompt` value is provided for previous input, it will prompt for the following variable values:
    * Resource prefix
    * ARO resource group
    * ARO cluster name
    * Location
    * Generate kubeConfig (true/false)
      * KubeConfig path (if previous value is true)
  
  All of these fields have default values but can be overridden by providing
  new values. Once all the values are provided the script invokes `terraform`
  by passing in the input values to corresponding variables needed by the
  Terraform scripts.
  
  To run Terraform without using the script, please use the following command
  (substitute values with correct ones)
  ```
  cd aro_kube_config
  
  terraform plan -out main.tfplan -var-file=custom.tfvars
  ```
  
## Variables used in this module:
  * `resource_group_name`: Represents the name of the Resource Group
  * `cluster_name`: Name of the ARO cluster
  * `region`: Region/Location of the resource group
  * `generate_kube_config`:
    * _When `generate_kube_config` variable is given a value of `false` the kubeConfig
      file will NOT be generated and an output value of `aro_cluster_details-kube_config`
      is set to the contents of kubeConfig. In this case, the caller can generate kubeConfig
      using this output (you will need to use `base64decode` on the output)_
    * _When `generate_kube_config` variable is given a value of `true`, value of 
      `kube_config_path` variable is used to generate the kubeConfig at that location_
  * `kube_config_path`:
    * Value from this variable is used to generate the kubeConfig file. The value should
      include the directory + file name that should contain kubeconfig data. _Do NOT use
      `~` (tilde) to specify the path. Rather use the full path._ 
