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

    always_on = true

    application_stack {
      docker_image_name        = "spring-petclinic:latest"
      docker_registry_url      = "https://${azurerm_container_registry.this.login_server}"
      docker_registry_username = azurerm_container_registry.this.admin_username
      docker_registry_password = azurerm_container_registry.this.admin_password
    }
  }

  https_only = true

  app_settings = {
    WEBSITE_RUN_FROM_PACKAGE                   = "1"
    ApplicationInsightsAgent_EXTENSION_VERSION = "~3"
    APPINSIGHTS_INSTRUMENTATIONKEY             = azurerm_application_insights.petclinic.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING      = azurerm_application_insights.petclinic.connection_string
    WEBSITE_WEBDEPLOY_USE_SCM                  = true
  }

  tags = local.tags
}
