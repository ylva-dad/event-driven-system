resource "azurerm_application_insights" "petclinic" {
  name                = local.application_insights_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  application_type    = "web"

  tags = local.tags
}
