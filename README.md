# aro-aad-test

There are a few directories with Terraform config in them. Here is some detail
on these directories:
* [aro_kube_config](aro_kube_config/README.md)
  * This directory contains Terraform config that can be used to generate kubeconfig

* [k8s_oidc](k8s_oidc/README.md)
  * This directory contains Terraform config that can be used to import existing `oidc` resource
    and add `oidc AAD` identity provider as well as create a `Secret` for AzureAD.

* [with_details_and_modules](with_details_and_modules/README.md)
  * This directory contains modules that provide a lot of information regarding
    the ARO cluster and Azure account
