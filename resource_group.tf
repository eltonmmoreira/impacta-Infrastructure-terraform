resource "azurerm_resource_group" "dataRg" {
  location = var.location
  name = "dataRg"
}