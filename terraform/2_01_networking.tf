# vnetaks
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.address-space-vnet]
  tags                = { project = var.prefix }
}

# Subred para los nodos/pods de AKS
resource "azurerm_subnet" "snet-aks" {
  name                              = "${var.prefix}-snet-aks"
  resource_group_name               = azurerm_resource_group.rg.name
  virtual_network_name              = azurerm_virtual_network.vnet.name
  address_prefixes                  = [var.address-space-snet-aks]
  private_endpoint_network_policies = "Enabled"
}

# Subred para ingress
resource "azurerm_subnet" "snet-ingress" {
  name                              = "${var.prefix}-snet-ingress"
  resource_group_name               = azurerm_resource_group.rg.name
  virtual_network_name              = azurerm_virtual_network.vnet.name
  address_prefixes                  = [var.address-space-snet-ingress]
  private_endpoint_network_policies = "Enabled"
}

