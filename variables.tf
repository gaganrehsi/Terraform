//Common
variable "resource_group_name" {
  default = "Test-GP-Terraform"
  description = "Resource group name for Azure"
}

variable "resource_prefix_name" {
  default = "Test-GP"
  description = "Prefix to add on each resource name"
}

# Zone
variable "location" {
  default = "East US"
  description = "Azure location"
}

# Network
variable "vnet_address_space" {
  default = "10.3.0.0/16"
  description = "The address space that is used the virtual network"
}

# Subnet
variable "subnet_address_prefix" {
  default = "10.3.1.0/24"
  description = "The address prefix to use for the subnet"
}