output "resource_group_name" {
  value = azurerm_resource_group.this.name
}

output "app_service_name" {
  value = azurerm_linux_web_app.petclinic.name
}