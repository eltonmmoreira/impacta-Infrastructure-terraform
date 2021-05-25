sudo apt update
sudo apt install -y mysql-server-5.7
sudo cp -f /home/azureuser/config/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
sudo mysql < /home/azureuser/config/script.sql
sudo systemctl restart mysql.service
sleep 30