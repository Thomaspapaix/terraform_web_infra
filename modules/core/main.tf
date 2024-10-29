resource "azurerm_resource_group" "rgcore" {
  name     = var.resource_group
  location = var.location
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
  depends_on	= [azurerm_resource_group.rgcore]
}

resource "azurerm_postgresql_flexible_server" "my_postgresql_server" {
  name                = var.serversql_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rgcore.name

  sku_name = var.database_sku_name

  storage_mb = var.storage

  administrator_login          = var.administrator_login
  administrator_password = random_password.password.result
  version = 16
  tags = {}
  depends_on = [random_password.password]
}



resource "azurerm_service_plan" "sp" {
  name                = var.service_plan_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rgcore.name
  os_type             = "Linux"

  sku_name = var.service_plan_size
  depends_on = [azurerm_postgresql_flexible_server.my_postgresql_server]
}