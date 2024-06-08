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

  // Map the location to the location three letter abbreviation
  location_abbreviations = {
    "East US" = "eus"
    "West US" = "wus"
    "Central US" = "cus"
    "East US 2" = "eus2"
    "West US 2" = "wus2"
    "North Central US" = "ncus"
    "South Central US" = "scus"
    "Central US" = "cus"
    "West Central US" = "wcus"
    "East Asia" = "eas"
    "Southeast Asia" = "seas"
    "East China" = "ec"
    "North China" = "nc"
    "South China" = "sc"
    "Central India" = "cin"
    "South India" = "sin"
    "West India" = "win"
    "UK South" = "uks"
    "UK West" = "ukw"
    "North Europe" = "ne"
    "West Europe" = "we"
    "Germany Central" = "dec"
    "Germany Northeast" = "den"
    "Switzerland North" = "chn"
    "Switzerland West" = "chw"
    "Norway East" = "noe"
    "Norway West" = "now"
    "France Central" = "frc"
    "France South" = "frs"
    "UAE North" = "uaen"
    "UAE Central" = "uaec"
    "South Africa North" = "safn"
    "South Africa West" = "safw"
    "Brazil South" = "brs"
    "Australia East" = "aue"
    "Australia Southeast" = "aus"
    "Japan East" = "jpe"
    "Japan West" = "jpw"
    "Korea Central" = "krc"
    "Korea South" = "krs"
  }
  
  
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
