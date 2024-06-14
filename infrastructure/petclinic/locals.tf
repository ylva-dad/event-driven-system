locals {
  location              = var.location
  location_abbreviation = lookup(local.location_abbreviations, local.location, "usc")
  environment           = var.environment
  resource_group_name   = "rg-${local.petclinic_appname}-${local.location_abbreviation}-${local.environment}"
  app_config_name       = "appconfig-${local.petclinic_appname}-${local.location_abbreviation}-${local.environment}"
  storage_account_name  = "sa${local.petclinic_appname}${local.location_abbreviation}${local.environment}"
  key_vault_name        = "kv-${local.petclinic_appname}-${local.location_abbreviation}-${local.environment}"

  petclinic_appname = "petclinic"

  petclinic_app_service_plan_name      = "plan-${local.petclinic_appname}-${local.location_abbreviation}-${local.environment}"
  petclinic_app_service_name           = "appsvc-${local.petclinic_appname}-java-${local.location_abbreviation}-${local.environment}"
  petclinic_app_service_autoscale_name = "autoscale-${local.petclinic_appname}-java-${local.location_abbreviation}-${local.environment}"

  petclinic_postgres_server_name = "psql-${local.petclinic_appname}-${local.location_abbreviation}-${local.environment}"
  petclinic_postgres_db_name     = "psqldb-${local.petclinic_appname}-${local.location_abbreviation}-${local.environment}"

  container_registry_name = "acr${local.petclinic_appname}${local.location_abbreviation}${local.environment}"

  // Map the location to the location three letter abbreviation
  location_abbreviations = {
    "eastus"    = "use"
    "westus"    = "wus"
    "centralus" = "usc"
    "eastus2"   = "use2"
    "westus2"   = "usw2"
  }

  application_insights_name = "ai-${local.petclinic_appname}-${local.location_abbreviation}-${local.environment}"

  tags = merge(var.tags, {
    environment = local.environment
    appname     = local.petclinic_appname
  })
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
