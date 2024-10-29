variable "location" {
  description = "Azure region for resource deployment"
  type        = string
}
variable "resource_group" {
  description = "Name of the resource group"
  type        = string
}


//db
variable "serversql_name" {
  description = "Name of the sql server"
  type        = string
}
variable "administrator_login" {
  description = "The administrator username of the SQL server"
  type        = string
}
variable "storage" {
  description = "Name of the storage account"
  type        = number
}
variable "database_sku_name" {
  description = "Name of the database"
  type        = string
}
//service plan
variable "service_plan_name" {
  description = "Name of the service plan"
  type        = string
}
variable "service_plan_size" {
  description = "The SKU of the service plan"
  type        = string
}