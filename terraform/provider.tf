terraform {
  required_providers {
    snowflake = {
      source  = "chanzuckerberg/snowflake"
      version = "0.25.19"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.80.0"
    }
  }

  # See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret
  # This framework uses an Azure Active Directory Service Principal to connect to Azure for backend storage
  # Service Principal details are supplied via the following environment variables:
  # ARM_TENANT_ID
  # ARM_SUBSCRIPTION_ID
  # ARM_CLIENT_ID
  # ARM_CLIENT_SECRET

  # See https://www.terraform.io/docs/language/settings/backends/azurerm.html
  # See https://www.terraform.io/docs/language/settings/backends/configuration.html#partial-configuration
  # We're using a partial backend configuration here to set the following azurerm backend settings:
  # resource_group_name
  # storage_account_name
  # container_name
  # key
  # We'll set those settings with values supplied in the following environment variables:
  # TF_STATE_AZURERM_RESOURCE_GROUP_NAME
  # TF_STATE_AZURERM_STORAGE_ACCOUNT_NAME
  # TF_STATE_AZURERM_STORAGE_CONTAINER_NAME
  # TF_STATE_AZURERM_KEY_NAME
  # And that all happens when calling terraform init as follows:
  # terraform init \
  # -backend-config="resource_group_name=$TF_STATE_AZURERM_RESOURCE_GROUP_NAME" \
  # -backend-config="storage_account_name=$TF_STATE_AZURERM_STORAGE_ACCOUNT_NAME" \
  # -backend-config="container_name=$TF_STATE_AZURERM_STORAGE_CONTAINER_NAME" \
  # -backend-config="key=$TF_STATE_AZURERM_KEY_NAME"
  # Which will set those values in the .terraform/terraform.tfstate file

  backend "azurerm" {
  }
}

# Connection details are supplied via the following environment variables:
# SNOWFLAKE_ACCOUNT
# SNOWFLAKE_REGION
# SNOWFLAKE_USER
# SNOWFLAKE_PRIVATE_KEY (be sure to include the BEGIN and END comment lines and newlines)
# SNOWFLAKE_PRIVATE_KEY_PASSPHRASE
provider "snowflake" {
}

provider "azurerm" {
  features {}
}
