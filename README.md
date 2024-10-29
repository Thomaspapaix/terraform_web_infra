# Deploying Web App Environments on Azure with Terraform

This Terraform project enables the deployment of multiple front-end and back-end web app environments on Azure, utilizing a shared service plan for all applications and a PostgreSQL flexible database.

## Prerequisites

Before getting started, make sure you have:

- An Azure account with the necessary permissions to create resources.

- Install Azure CLI on your device. [Azure CLI Installation Guide](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

- Connect to your Azure subscription.

- Terraform installed locally. For more information on installation, refer to [Terraform docs](https://learn.hashicorp.com/tutorials/terraform/install-cli).

## Usage

With this project, you will be able to create as many environments as you want and give them the name you want, like this:

```bash
./deploy dev prod test
```

The arguments will be the environments that will be created (dev, prod, test are examples).

To delete the resources, you just need to use the argument 'destroy', and it will initiate the deletion of all the resources that were created.

```bash
./deploy destroy
```

## Configuration

Of course, you should choose your resource names and sizes based on your needs. For this, you will need to

### Resources name
Go to the file `./terraform.tfvars`.

```HCL
location = "northeurope"
global_name ="default"
//core
    //db
        administrator_login_core    = "defaul"
        storage_core                = 32768
        database_sku_name_core      = "B_Standard_B1ms"
    //service plan
        service_plan_size_core      = "B1"
```

change with your value
- `global_name` is the pricipale name of your resourses
- `administrator_login_core` is the login of your database postgresSQL
- `storage_core` is the size of your database
- `database_sku_name_core` is the pricing plan of your database postgresSQL
- `service_plan_size_core` is the pricing plan of your web apps

### Backend Terraform

To store the Terraform backend on Azure, you should create a separate `resource group` that contains a `storage account`. Within this storage account, create a `container`.
[Storage account](https://learn.microsoft.com/fr-fr/azure/storage/common/storage-account-create?tabs=azure-portal) / [Container in storage account](https://learn.microsoft.com/en-us/azure/storage/blobs/blob-containers-portal)

Then, get the access key and update the data in the `main.tf`.[Get access key](https://learn.microsoft.com/en-us/azure/storage/common/storage-account-keys-manage?tabs=azure-portal)

```HCL
backend "azurerm" {
    storage_account_name = "Your value"
    container_name       = "Your value"
    key                  = "terraform.tfstate"
    access_key           = "Your value"
  }
