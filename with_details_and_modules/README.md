# Fetch KubeConfig and add oidc together as modules

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