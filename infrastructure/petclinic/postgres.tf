resource "azurerm_postgresql_server" "petclinic" {
  name                = local.petclinic_postgres_server_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  sku_name = "B_Gen5_2"

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  administrator_login          = "psqladmin"
  administrator_login_password = "petclinic1234!"
  version                      = "9.5"
  ssl_enforcement_enabled      = true
}

resource "azurerm_postgresql_database" "petclinic" {
  name                = local.petclinic_postgres_db_name
  resource_group_name = azurerm_resource_group.this.name
  server_name         = azurerm_postgresql_server.petclinic.name
  charset             = "UTF8"
  collation           = "English_United States.1252"

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}
