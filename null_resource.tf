resource "time_sleep" "wait_30_seconds_db" {
  create_duration = "30s"
  depends_on = [azurerm_linux_virtual_machine.dataVmLinux]
}

resource "null_resource" "upload_db" {
  provisioner "file" {
    connection {
      type = "ssh"
      host = azurerm_public_ip.dataPublicIp.ip_address
      user = var.credentials.username
      password = var.credentials.passwd
    }

    source = "config"
    destination = "/home/azureuser"
  }

  depends_on = [time_sleep.wait_30_seconds_db]
}

resource "null_resource" "install-database" {
  triggers = {
    order = null_resource.upload_db.id
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      host = azurerm_public_ip.dataPublicIp.ip_address
      user = var.credentials.username
      password = var.credentials.passwd
    }

    script = "./bootstrap.sh"
  }
}

//resource "null_resource" "deploy_db" {
//  triggers = {
//    order = null_resource.upload_db.id
//  }
//  provisioner "remote-exec" {
//    connection {
//      type = "ssh"
//      host = azurerm_public_ip.dataPublicIp.ip_address
//      user = var.credentials.username
//      password = var.credentials.passwd
//    }
//    inline = [
//      "sudo apt-get update",
//      "sudo apt-get install -y mysql-server-5.7",
//      "sudo cp -f /home/azureuser/config/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf",
//      "sudo mysql < /home/azureuser/config/script.sql",
//      "sudo service mysql restart",
//      "sleep 20",
//    ]
//  }
//}