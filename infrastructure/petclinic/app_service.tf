resource "azurerm_service_plan" "petclinic" {
  name                = local.petclinic_app_service_plan_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  os_type             = "Linux"
  sku_name            = "P1v3"
}

resource "azurerm_linux_web_app" "petclinic" {
  name                = local.petclinic_app_service_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  service_plan_id     = azurerm_service_plan.petclinic.id

  site_config {
    application_stack {
      java_server         = "JAVA"
      java_server_version = "JAVA21"
      java_version = "17"
    }
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}
