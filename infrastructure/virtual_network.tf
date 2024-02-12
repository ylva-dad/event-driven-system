# Define the virtual network
resource "azurerm_virtual_network" "this" {
  name                = local.virtual_network_name
  address_space       = ["10.0.0.0/8"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

# Define the DMZ subnet
resource "azurerm_subnet" "dmz_subnet" {
  name                 = "subnet-dmz"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.1.0.0/16"]
}

# Define the compute subnet
resource "azurerm_subnet" "compute_subnet" {
  name                 = "subnet-compute"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.2.0.0/16"]
}

# Define the data subnet
resource "azurerm_subnet" "data_subnet" {
  name                 = "subnet-data"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.3.0.0/16"]
}

resource "azurerm_network_security_group" "nsg_dmz" {
  name                = "nsg-dmz"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_network_security_rule" "dmz_https_inbound" {
  name                        = "allow-https"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*" # Allow from any source"
  destination_address_prefix  = azurerm_subnet.compute_subnet.address_prefixes[0]
  resource_group_name         = azurerm_resource_group.this.name
  network_security_group_name = azurerm_network_security_group.nsg_dmz.name
}

resource "azurerm_network_security_group" "nsg_compute" {
  name                = "nsg-compute"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_network_security_rule" "compute_https_inbound" {
  name                        = "allow-https"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = azurerm_subnet.dmz_subnet.address_prefixes[0]
  destination_address_prefix  = azurerm_subnet.compute_subnet.address_prefixes[0]
  resource_group_name         = azurerm_resource_group.this.name
  network_security_group_name = azurerm_network_security_group.nsg_compute.name
}
