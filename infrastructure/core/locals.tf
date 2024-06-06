locals {
  location                           = var.location
  environment                        = var.environment
  resource_group_name                = "rg-${local.app_code}-${local.location}-${local.environment}"
  storage_account_name               = "sa${local.app_code}${local.location}${local.environment}"
  cognitive_account_name             = "cog${local.app_code}${local.location}${local.environment}"
  cosmosdb_account_name              = "cosmos${local.app_code}${local.location}${local.environment}"
  dmz_container_environment_name     = "ace-dmz-${local.app_code}-${local.location}-${local.environment}"
  compute_container_environment_name = "ace-compute-${local.app_code}-${local.location}-${local.environment}"
  container_registry_name            = "acr${local.app_code}${local.location}${local.environment}"
  virtual_network_name               = "vnet-${local.app_code}-${local.location}-${local.environment}"
  log_analytics_name                 = "la${local.app_code}${local.location}${local.environment}"
  app_config_name                    = "appconfig-${local.app_code}-${local.location}-${local.environment}"
  key_vault_name                     = "kv-${local.app_code}-${local.location}-${local.environment}"
  app_insights_name                  = "ai${local.app_code}${local.location}${local.environment}"
  app_code                           = "${random_string.this.result}${random_integer.this.result}"
  webpubsub_name                     = "wps-${local.app_code}-${local.location}-${local.environment}"

}

resource "random_integer" "this" {
  min = 1000
  max = 9999
}
resource "random_string" "this" {
  length  = 3
  special = false
  upper   = false
  number  = false
}
