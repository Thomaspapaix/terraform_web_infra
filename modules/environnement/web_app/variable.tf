variable "name" {
    description = "Name of the application"
    type        = string
}
variable "location" {
  description = "Azure region for resource deployment"
  type        = string
}
variable "resource_group" {
  description = "Name of the resource group"
  type        = string
}

variable "service_plan_id" {
  description = "Name of the service plan"
  type        = string
}
variable "postgres_connection_string" {
  description = "Connection string for the database"
  type        = string
}

//storage account
variable "storage_connection_string" {
  description = "Connection string for the storage account"
  type        = string
}