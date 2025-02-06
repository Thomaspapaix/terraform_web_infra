# Deploying Web App Environments on Azure with Terraform

This Terraform project enables the deployment of multiple front-end and back-end web app environments on Azure, utilizing a shared service plan for all applications and a PostgreSQL flexible database.

## Prerequisites

Before getting started, make sure you have:

- An Azure account with the necessary permissions to create resources.

- Install Azure CLI on your device. [Azure CLI Installation Guide](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

- Connect to your Azure subscription [(how to)](https://learn.microsoft.com/en-us/cli/azure/authenticate-azure-cli).

- Terraform installed locally. For more information on installation, refer to [Terraform docs](https://learn.hashicorp.com/tutorials/terraform/install-cli).

## Usage

First you need to create an Azure [Storage Account](https://learn.microsoft.com/en-us/azure/storage/common/storage-account-create?tabs=azure-portal) and get your storage accont name and your acces key in your variable enviromement like this. And in this storage account create a container `tfstate`.

For Windows (Command Prompt)
```cmd
set TF_VAR_storage_account_name=your_storage_account_name
set TF_VAR_access_key=your_access_key
```
For Windows (PowerShell)

```powershell
$env:TF_VAR_storage_account_name="your_storage_account_name"
$env:TF_VAR_access_key="your_access_key"
```

With this project, you will be able to create as many environments as you want and give them the name and configuration you want, like this:

```hcl
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
```
### How to use it :

This `variable.tf` file is an example configuration that allows you to define the parameters for different environments. Each environment can be customized by adjusting the values in the `environments` and `cores` lists.

#### Structure of the Variables

1. **Variable** `environments`: This variable defines the parameters for each environment (such as `dev` and `prod`).

- **Structure**: The variable is a list of objects, each representing an environment with several fields.
- **Fields**:

    - `environment`: name of the environment (e.g., `dev`, `prod`),
    - `core`: type of usage, such as `shared` or `produc` (adapt as needed), 
    - `create_storage_account`: boolean (`true` or `false`) indicating whether to create a storage account,

- **Example of Extension**: To add a new environment, you can copy a block and modify the values:

```hcl
{
  environment            = "test"
  core                   = "shared"
  create_storage_account  = false
  account_tier           = "Premium"
  account_replication_type = "GRS"
}
```

2. **Variable** `cores`: This variable contains the configuration parameters for databases and service plans for each environment.

- **Structure**: A list of objects where each object contains information for a database and service configuration for an environment.

- **Fields** :
    - `administrator_login`: administrator ID for the database (e.g., `adminDB`),
    - `storage`: storage in MB (for example, `32768` for 32 GB),
    - `database_sku_name`: SKU type for the database (e.g., `B_Standard_B1ms`),
    - `service_plan_size`: size of the service plan (e.g., `B1`),
    - `environment`: name of the environment to which the configurations apply.

- **Example of Extension**: For a new rapid development environment:
```hcl
{
  administrator_login = "adminTest"
  storage             = 10240
  database_sku_name   = "B_Standard_B1s"
  service_plan_size   = "A1"
  environment         = "test"
}
```

After you choose your configuration you can deploy the ifrastructure with this commande

For your first initialization, you need to run this command to initialize the environment variables in your backend.

```bash
terraform init `
    -backend-config="storage_account_name=$env:TF_VAR_storage_account_name" `
    -backend-config="access_key=$env:TF_VAR_access_key"
```

```bash
terraform init
terraform apply
```

To delete the resources, you just need to use the argument 'destroy', and it will initiate the deletion of all the resources that were created.

```bash
 terraform destroy
```