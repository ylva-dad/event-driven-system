resource "azurerm_container_app_environment" "dmz" {
  name                       = local.dmz_container_environment_name
  resource_group_name        = azurerm_resource_group.this.name
  location                   = azurerm_resource_group.this.location
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  infrastructure_subnet_id   = azurerm_subnet.dmz_subnet.id
}

resource "azurerm_container_app_environment" "compute" {
  name                       = local.compute_container_environment_name
  resource_group_name        = azurerm_resource_group.this.name
  location                   = azurerm_resource_group.this.location
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  infrastructure_subnet_id   = azurerm_subnet.compute_subnet.id
}
