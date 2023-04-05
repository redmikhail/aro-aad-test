# aro-aad-test

There are a few directories with Terraform config in them. Here is some detail
on these directories:
* aro_kube_config
  * This directory contains config that can be used to generate kubeconfig
  
  To generate `kubeconfig`, execute following commands:
  ```
  cd aro_kube_config
  ./run.sh
  ```
  This script will allow you to initialize `terraform` or `plan` or `apply` the
  changes.
  
  When running in `plan` mode, it will prompt for the following variable values:
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
  
  terraform plan -out main.tfplan \
    -var resource_group_name=<RESOURCE_GROUP_NAME> \
    -var aro_cluster_name=<ARO_CLUSTER_NAME> \
    -var region=<RESOURCE_GROUP_LOCATION> \
    -var generate_kube_config=<TRUE_OR_FALSE> \
    -var aro_cluster_kube_config_path=<KUBE_CONFIG_PATH>
  ```
  * `generate_kube_config` variable:
    * _When `generate_kube_config` variable is given a value of `false` the kubeConfig
      file will NOT be generated and an output value of `aro_cluster_details-kube_config`
      is set to the contents of kubeConfig. In this case, the caller can generate kubeConfig
      using this output (you will need to use `base64decode` on the output)_
    * _When `generate_kube_config` variable is given a value of `true`, value of 
      `aro_cluster_kube_config_path` variable is used to generate the kubeConfig at
      that location_
  * `aro_cluster_kube_config_path` variable:
    * Value from this variable is used to generate the kubeConfig file. The value should
      include the directory + file name that should contain kubeconfig data. _Do NOT use
      `~` (tilde) to specify the path. Rather use the full path._ 


* with_details_and_modules
  * This directory contains modules that provide a lot of information regarding
    the ARO cluster and Azure account

  To generate `kubeconfig`, execute following commands:
  ```
  cd with_details_and_modules
  ./run.sh
  ```
  This script will allow you to initialize `terraform` or `plan` or `apply` the
  changes.

  When running in `plan` mode, it will prompt for the following variable values:
  * Resource prefix
  * ARO resource group
  * ARO cluster name
  * Location

  All of these fields have default values but can be overridden by providing
  new values. Once all the values are provided the script invokes `terraform`
  by passing in the input values to corresponding variables needed by the
  terraform scripts.