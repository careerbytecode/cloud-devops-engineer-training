# Vpc creation
resource "azurerm_virtual_network" "generic" {
  name                = "network-generic"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.generic.location
  resource_group_name = azurerm_resource_group.generic.name
}

# Subnet configuration
resource "azurerm_subnet" "http" {
  name                 = "subnet-http"
  resource_group_name  = azurerm_resource_group.generic.name
  virtual_network_name = azurerm_virtual_network.generic.name
  address_prefixes       = ["10.0.2.0/24"]
}

# Subnet configuration
resource "azurerm_subnet" "db" {
  name                 = "subnet-db"
  resource_group_name  = azurerm_resource_group.generic.name
  virtual_network_name = azurerm_virtual_network.generic.name
  address_prefixes       = ["10.0.3.0/24"]
}
