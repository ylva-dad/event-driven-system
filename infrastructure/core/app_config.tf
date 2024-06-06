resource "azurerm_app_configuration" "this" {
  name                = local.app_config_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "free"
}

// this never completes
// add the connection information for the webpubsub
//resource "azurerm_app_configuration_key" "webpubsub_connection_string" {
//  key                    = "webpubsub:connection-string"
//  configuration_store_id = azurerm_app_configuration.this.id
//  value                  = azurerm_web_pubsub.this.primary_connection_string
//  label                  = "connectionString"
//}
