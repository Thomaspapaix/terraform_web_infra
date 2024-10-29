resource "azurerm_resource_group" "rgenv" {
  name     = var.resource_group
  location = var.location
}

resource "azurerm_storage_account" "asa" {
  count                    = var.create_storage_account ? 1 : 0
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rgenv.name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_storage_container" "asc" {
  count                 = var.create_storage_account ? 1 : 0
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.asa[count.index].name
  container_access_type = "private"
}


module "web_app_frontend" {
  source                     = "./web_app"
  name                       = var.webapp_front_name
  location                   = var.location
  resource_group             = azurerm_resource_group.rgenv.name
  service_plan_id            = var.service_plan_id
  postgres_connection_string = ""
  //storage account
  storage_connection_string  = azurerm_storage_account.asa[0].primary_blob_connection_string
}

module "web_app_backend" {
  source                     = "./web_app"
  name                       = var.webapp_back_name
  location                   = var.location
  resource_group             = azurerm_resource_group.rgenv.name
  service_plan_id            = var.service_plan_id
  postgres_connection_string = var.postgres_connection_string
  //storage account
  storage_connection_string  = azurerm_storage_account.asa[0].primary_blob_connection_string

  depends_on                 = [module.web_app_frontend]
}