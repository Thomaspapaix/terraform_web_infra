variable "global_name" {
  type = string
  default = "testnameterratalan"
}

variable "location" {
  type = string
  default = "northeurope"
}

variable "environnements" {
  type = list(object({
    environnement            = string
    core                     = string
    account_tier             = string
    account_replication_type = string
    create_storage_account   = bool
  }))
  default = [
    {
      environnement            = "dev"
      core                     = "shared"
      create_storage_account   = true
      account_tier             = "Standard"
      account_replication_type = "LRS"

    },
    {
      environnement            = "prod"
      core                     = "produc"
      create_storage_account   = true
      account_tier             = "Standard"
      account_replication_type = "LRS"
    },
        {
      environnement            = "inte"
      core                     = "shared"
      account_tier             = "Standard"
      account_replication_type = "LRS"
      create_storage_account   = true
    },
  ]
}

variable "cores" {
  type = list(object({
    administrator_login = string
    storage             = number
    database_sku_name   = string
    service_plan_size   = string
    environnement       = string
  }))
  default = [
    {
      //database 
      administrator_login = "Talandb"
      storage             = 32768
      database_sku_name   = "B_Standard_B1ms"
      //service plan
      service_plan_size   = "B1"
      environnement       = "shared"
    },
    {
      //database 
      administrator_login = "Talandbprod"
      storage             = 32768
      database_sku_name   = "B_Standard_B1ms"
      //service plan
      service_plan_size   = "B1"
      environnement       = "produc"
    },
  ]
}