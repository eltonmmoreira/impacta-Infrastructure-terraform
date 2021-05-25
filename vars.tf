variable "location" {
  default = "eastus"
}

variable "credentials" {
  type = map
  default = {
    username = "azureuser"
    passwd = "azureuser@2100415"
  }
}
