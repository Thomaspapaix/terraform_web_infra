resource "azurerm_linux_web_app" "my_web_app" {
  name                = var.name
  resource_group_name = var.resource_group
  location            = var.location
  service_plan_id     = var.service_plan_id

  site_config {
    always_on = true
  }

  app_settings = {
    "DATABASE_CONNECTION_STRING" = var.postgres_connection_string
    "STORAGE_CONNECTION_STRING" = var.storage_connection_string
  }
}