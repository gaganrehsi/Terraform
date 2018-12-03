# Create a resource group
resource "azurerm_resource_group" "rg" {
  name      = "${var.resource_group_name}"
  location  = "${var.location}"
}

# Create a resource network security group for subnet
resource "azurerm_network_security_group" "subnet-nsg" {
  name                = "${var.resource_prefix_name}-subnet-nsg"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  # SSH rule access
  security_rule {
    name                       = "Deny-Outbound-Internet"
    description                = "Does not allow internet access"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
    access                     = "Deny"
    priority                   = 100
    direction                  = "Outbound"
  }

}

# Create a Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.resource_prefix_name}-vnet"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  address_space       = ["${var.vnet_address_space}"]
  location            = "${azurerm_resource_group.rg.location}"
}

# Create Subnet
resource "azurerm_subnet" "subnet" {
  address_prefix = "${var.subnet_address_prefix}"
  name = "${var.resource_prefix_name}-subnet"
  network_security_group_id = "${azurerm_network_security_group.subnet-nsg.id}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  }
