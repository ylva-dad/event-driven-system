resource "azurerm_cognitive_account" "this" {
  name                = local.cognitive_account_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  kind                = "ComputerVision"
  sku_name            = "S0"

  tags = {
    Acceptance = "Test"
  }
}