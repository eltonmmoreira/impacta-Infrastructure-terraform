resource "azurerm_public_ip" "dataPublicIp" {
  name = "dataPublicIp"
  location = var.location
  resource_group_name = azurerm_resource_group.dataRg.name
  allocation_method = "Static"

  depends_on = [azurerm_resource_group.dataRg]
}