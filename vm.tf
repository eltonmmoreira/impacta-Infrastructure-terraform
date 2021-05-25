resource "azurerm_linux_virtual_machine" "dataVmLinux" {
  name = "dataVmLinux"
  location = var.location
  resource_group_name = azurerm_resource_group.dataRg.name
  network_interface_ids = [
    azurerm_network_interface.dataNic.id
  ]
  size = "Standard_DS1_v2"

  computer_name = "dataVm"
  admin_username = var.credentials.username
  admin_password = var.credentials.passwd
  disable_password_authentication = false

  os_disk {
    name = "dataOSDisk"
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "18.04-LTS"
    version = "latest"
  }

//  admin_ssh_key {
//    username       = "azureuser"
//    public_key     = tls_private_key.example_ssh.public_key_openssh
//  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.dataStorage.primary_blob_endpoint
  }

  depends_on = [azurerm_resource_group.dataRg, azurerm_network_interface.dataNic, azurerm_storage_account.dataStorage]
}

//resource "tls_private_key" "example_ssh" {
//  algorithm = "RSA"
//  rsa_bits = 4096
//}

//output "tls_private_key" {
//  value = tls_private_key.example_ssh.private_key_pem
//}


