resource "azurerm_service_plan" "petclinic" {
  name                = local.petclinic_app_service_plan_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  os_type             = "Linux"
  sku_name            = "P1v3"


  tags = local.tags
}

resource "azurerm_linux_web_app" "petclinic" {
  name                = local.petclinic_app_service_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  service_plan_id     = azurerm_service_plan.petclinic.id

  site_config {

    always_on        = true
    app_command_line = "java -jar /home/site/wwwroot/petclinic.jar --server.port=80"

    application_stack {
      java_version = "17"
    }
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE"            = "1"
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.petclinic.instrumentation_key
  }


  tags = local.tags
}

resource "azapi_update_resource" "backend-webapp-java-21" {
  type        = "Microsoft.Web/sites@2023-01-01"
  resource_id = azurerm_linux_web_app.petclinic.id
  body        = jsonencode({
    properties = {
      siteConfig = {
        linuxFxVersion = "JAVA|21-java21"
      }
    }
  })
  lifecycle {
    replace_triggered_by = [
      azurerm_linux_web_app.petclinic
    ]
  }
}