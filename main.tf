#SAMPLE TERRAFORM TEMPLATE - GAGAN SINGH - PLEASE USE AS A SAMPLE ONLY

terraform {
  required_version = ">= 0.12"
}

#CHANGE BELOW VALUES AS PER YOUR ENVIRONMENT
provider "azurerm" {
  version = ">=1.29.0"
  features{}
  subscription_id = "XXXXXXXXX"
  client_id       = "XXXXXXXXXXX"
  client_secret   = "XXXXXXXXX"
  tenant_id       = "XXXXXXXXXX"
}

resource "random_string" "random" {
  length = 6
  special = false
  upper = false
}

resource "azurerm_virtual_network" "example" {
  name                = "${random_string.random.result}-network"
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
  resource_group_name = "keyvault1"
}

resource "azurerm_subnet" "example" {
  name                 = "${random_string.random.result}-subnet"
  resource_group_name  = "keyvault1"
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefix       = "10.0.1.0/24"

  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_key_vault" "gagankv" {
  name                        = "${random_string.random.result}-gagankv"
  location                    = "eastus"
  resource_group_name         = "keyvault1"
  tenant_id                   = "XXXXXXXXXXXXXXXXXXX"
 
  sku_name = "standard"
}
 

resource "azurerm_private_endpoint" "example" {
  name                = "${random_string.random.result}-endpoint"
  location            = "eastus"
  resource_group_name = "keyvault1"
  subnet_id           = azurerm_subnet.example.id

  private_service_connection {
    name                           = "${random_string.random.result}-privateserviceconnection"
    private_connection_resource_id = azurerm_key_vault.kv.id
    subresource_names              = [ "vault" ]
    is_manual_connection           = false
  }
}
