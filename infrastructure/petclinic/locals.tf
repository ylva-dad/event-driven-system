locals {
  location             = var.location
  environment          = var.environment
  resource_group_name  = "rg-${local.petclinic_appname}-${local.location}-${local.environment}"
  app_config_name      = "appconfig-${local.petclinic_appname}-${local.location}-${local.environment}"
  storage_account_name = "sa${local.petclinic_appname}${local.location}${local.environment}"
  key_vault_name       = "kv-${local.petclinic_appname}-${local.location}-${local.environment}"

  petclinic_appname = "petclinic"

  petclinic_app_service_plan_name      = "plan-${local.petclinic_appname}-java-${local.location}-${local.environment}"
  petclinic_app_service_name           = "appsvc-${local.petclinic_appname}-java-${local.location}-${local.environment}"
  petclinic_app_service_autoscale_name = "autoscale-${local.petclinic_appname}-java-${local.location}-${local.environment}"

  petclinic_postgres_server_name = "psql-${local.petclinic_appname}-${local.location}-${local.environment}"
  petclinic_postgres_db_name     = "psqldb-${local.petclinic_appname}-${local.location}-${local.environment}"
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
