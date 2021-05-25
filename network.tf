resource "azurerm_virtual_network" "dataVnet" {
  address_space = ["10.0.0.0/16"]
  location = var.location
  name = "dataVnet"
  resource_group_name = azurerm_resource_group.dataRg.name

  depends_on = [azurerm_resource_group.dataRg]
}

resource "azurerm_subnet" "dataSubnet" {
  name = "dataSubnet"
  resource_group_name = azurerm_resource_group.dataRg.name
  virtual_network_name = azurerm_virtual_network.dataVnet.name
  address_prefixes = ["10.0.2.0/24"]

  depends_on = [azurerm_resource_group.dataRg, azurerm_virtual_network.dataVnet]
}

resource "azurerm_network_security_group" "dataNSC" {
  name = "dataNSC"
  location = var.location
  resource_group_name = azurerm_resource_group.dataRg.name

  security_rule {
    name = "SSH"
    access = "Allow"
    direction = "Inbound"
    priority = 100
    protocol = "Tcp"
    destination_port_range = "22"
    source_port_range = "*"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name = "DATA"
    access = "Allow"
    direction = "Inbound"
    priority = 1001
    protocol = "Tcp"
    destination_port_range = "3306"
    source_port_range = "*"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }

  depends_on = [azurerm_resource_group.dataRg]
}

resource "azurerm_network_interface" "dataNic" {
  name = "dataNic"
  location = var.location
  resource_group_name = azurerm_resource_group.dataRg.name

  ip_configuration {
    name = "dataNicConfiguration"
    subnet_id = azurerm_subnet.dataSubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.dataPublicIp.id
  }

  depends_on = [azurerm_resource_group.dataRg, azurerm_public_ip.dataPublicIp, azurerm_subnet.dataSubnet]
}

resource "azurerm_network_interface_security_group_association" "dataNicNsg" {
  network_interface_id = azurerm_network_interface.dataNic.id
  network_security_group_id = azurerm_network_security_group.dataNSC.id

  depends_on = [azurerm_network_interface.dataNic, azurerm_network_security_group.dataNSC]
}