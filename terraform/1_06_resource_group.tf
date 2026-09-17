resource "azurerm_resource_group" "rg" {
  name     = "resourcegroup-${var.prefix}-${var.env}"
  location = var.location
  tags = {
    project     = var.prefix
    environment = var.env
  }
}
