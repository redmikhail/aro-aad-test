
variable "aro_resource_group_name" {
  default     = "test001RG"
  description = "Name of the resource group name that contains ARO"
}

variable "aro_cluster_name" {
  default     = "test001Aro"
  description = "Name of the ARO cluster"
}

variable "resource_group_location" {
  default     = "canadacentral"
  description = "Location of the resource group."
}

variable "aro_client_secret" {
  description = "Client secret for the App or SP"
}
