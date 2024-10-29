terraform {
    required_version = ">= 0.13"
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "3.93.0"
        }
    }
    backend "azurerm" {
        storage_account_name = ""
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
        access_key           = ""
    }
}
provider "azurerm" {
    features {}
}

module "core" {
    for_each = { for core in var.cores : core.environnement => core}

    source = "./modules/core"
    location = var.location
    //database
    resource_group = "rg-${var.global_name}-${each.value.environnement}"
    serversql_name = "sqldb-${var.global_name}-${each.value.environnement}"
    administrator_login = each.value.administrator_login
    storage = each.value.storage
    database_sku_name = each.value.database_sku_name
    //sevice plan
    service_plan_name = "sp-${var.global_name}-${each.value.environnement}-${var.location}"
    service_plan_size = each.value.service_plan_size
}

// dev
module "environnement" {
    for_each = { for env in var.environnements : env.environnement => env}

    source      = "./modules/environnement"
    location    = var.location
    resource_group = "rg-${var.global_name}-${each.value.environnement}"
    //webapp
    webapp_front_name = "app-${var.global_name}-front-${each.value.environnement}"
    webapp_back_name = "app-${var.global_name}-back-${each.value.environnement}"
    service_plan_id = module.core[each.value.core].service_plan_id
    postgres_connection_string = module.core[each.value.core].postgres_connection_string
    //storage account
    create_storage_account = each.value.create_storage_account
    storage_account_name = "st${var.global_name}${each.value.environnement}"
    account_tier = each.value.account_tier
    account_replication_type = each.value.account_replication_type
    container_name = "cr-${var.global_name}${each.value.environnement}"

}