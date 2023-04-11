locals {
  resource_type = "Microsoft.RedHatOpenShift/openShiftClusters@2022-09-04"
}

#data "azurerm_subscription" "current" {}

data "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
#  location = var.region
}

# Use to get all the properties (since we're using response_export_values with "*" in it)
resource "azapi_resource" "aro_cluster" {
  type      = local.resource_type
  name      = var.cluster_name
  parent_id = data.azurerm_resource_group.resource_group.id

  lifecycle {
    ignore_changes = [
      body,
      tags
    ]
  }
}
