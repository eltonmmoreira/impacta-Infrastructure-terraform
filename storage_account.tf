resource "azurerm_storage_account" "dataStorage" {
//  name = "diag${random_id.randomId.hex}"
  name = "storageaccountmyvm"
  account_replication_type = "LRS"
  account_tier = "Standard"
  location = var.location
  resource_group_name = azurerm_resource_group.dataRg.name

  depends_on = [azurerm_resource_group.dataRg]

//  depends_on = [azurerm_resource_group.dataRg, random_id.randomId]
}

//resource "random_id" "randomId" {
//  keepers = {
//    resource_group = azurerm_resource_group.dataRg.name
//  }
//  byte_length = 8
//
//  depends_on = [azurerm_resource_group.dataRg]
//}