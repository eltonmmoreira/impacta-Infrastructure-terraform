resource "azurerm_storage_account" "dataStorage" {
  name = "storageaccountmyvm"
  account_replication_type = "LRS"
  account_tier = "Standard"
  location = var.location
  resource_group_name = azurerm_resource_group.dataRg.name

  depends_on = [azurerm_resource_group.dataRg]
}