output "service_plan_id" {
  value = azurerm_service_plan.sp.id
}

output "postgres_connection_string" {
  value = "host=${azurerm_postgresql_flexible_server.my_postgresql_server.fqdn} dbname=postgres user=${var.administrator_login} password=${azurerm_postgresql_flexible_server.my_postgresql_server.administrator_password} sslmode=require"
}
