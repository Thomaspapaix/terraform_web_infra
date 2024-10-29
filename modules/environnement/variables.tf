variable "location" {
  description = "Azure region for resource deployment"
  type        = string
}
variable "resource_group" {
  description = "Name of the resource group"
  type        = string
}

//webapp
variable "webapp_front_name" {
  description = "Name of the webapp"
  type        = string
}
variable "webapp_back_name" {
  description = "Name of the webapp"
  type        = string
}
variable "service_plan_id" {
  description = "ID of the service plan"
  type        = string
}
variable "postgres_connection_string" {
  description = "Connection string for the database"
  type        = string
}

//Storage account
variable "create_storage_account" {
  description = "Flag to determine if storage account is used"
  type        = bool
}
variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}
variable "account_tier" {
  description = "Tier of the storage account"
  type        = string
}
variable "account_replication_type" {
  description = "Replication type of the storage account"
  type        = string
}
variable "container_name" {
  description = "Name of the container"
  type        = string
}