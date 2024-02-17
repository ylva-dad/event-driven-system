locals {
  sku      = var.environment == "prod" ? "Standard_S2" : "Free_F1"
  capacity = var.environment == "prod" ? 2 : var.pubsub_capacity
}

resource "azurerm_web_pubsub" "this" {
  name                = local.webpubsub_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  sku      = "Standard_S1"
  capacity = 1

  public_network_access_enabled = true

  live_trace {
    enabled                   = true
    messaging_logs_enabled    = true
    connectivity_logs_enabled = true
  }

  identity {
    type = "SystemAssigned"
  }
}