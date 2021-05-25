output "publicIp" {
  value = azurerm_public_ip.dataPublicIp.ip_address
}

output "fqdn" {
  value = azurerm_public_ip.dataPublicIp.fqdn
}

output "user" {
  value = var.credentials.username
}

output "pass" {
  value = var.credentials.passwd
}

