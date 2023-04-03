
#variable "aro_resource_prefix" {
#  default = "test001"
#  description = "Prefix for any ARO resource that is not provided through the variables"
#}
#
#variable "aro_app_name" {
#  description = "Name of the app for ARO"
#}

variable "aro_resource_group_name" {
  description = "Name of the resource group name that contains ARO"
}

variable "aro_cluster_name" {
  description = "Name of the ARO cluster"
}

variable "resource_group_location" {
  description = "Location of the resource group."
}

variable "role_assignments" {
  type = set(string)
  default = [ "User Access Administrator", "Contributor" ]
  description = "Contains roles that should be assigned to the service principal"
}