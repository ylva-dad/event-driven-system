resource "azurerm_app_configuration" "this" {
  name                = local.app_config_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "free"


  tags = local.tags
}
