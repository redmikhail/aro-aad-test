#resource "azuread_application" "aro_cluster_app" {
#  display_name = var.aro_app_name
#  owners       = [data.azuread_client_config.current.object_id]
#
#  web {
#    redirect_uris = [local.aro_oauth_callback_url]
#  }
#
#  optional_claims {
#    id_token {
#      name                  = "upn"
#      source                = null
#      essential             = false
#      additional_properties = []
#    }
#
#    id_token {
#      name                  = "email"
#      source                = null
#      essential             = false
#      additional_properties = []
#    }
#  }
#
#  required_resource_access {
#    resource_app_id = "00000002-0000-0000-c000-000000000000"  # MS Graph app id.
#
#    resource_access {
#      id   = "311a71cc-e848-46a1-bdf8-97ff7156d8e6" # User.Read.All id.
#      type = "Scope"
#    }
#  }
#}
#
#resource "azuread_application_password" "aro_cluster_app_password" {
#  application_object_id = azuread_application.aro_cluster_app.object_id
#}
#
#resource "azuread_service_principal" "aro_cluster_sp" {
#  application_id = azuread_application.aro_cluster_app.application_id
#  owners         = [data.azuread_client_config.current.object_id]
#}
#
#resource "azurerm_role_assignment" "aro_cluster_role_assignment" {
#  for_each = var.role_assignments
#
#  role_definition_name = each.key
#  principal_id         = azuread_application.aro_cluster_app.object_id
#  scope                = data.azurerm_subscription.current.id
#}
#
##resource "azuread_application_password" "aro_cluster_sp_password" {
##  application_object_id = data.azuread_service_principal.aro_cluster_sp.application_id
##}