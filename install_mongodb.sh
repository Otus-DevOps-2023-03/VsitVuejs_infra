#!/bin/bash
sudo apt-get install -y apt-transport-https
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y mongodb-org-shell
sudo apt-get install -y mongodb-org-server
sudo apt-get install -y mongodb-org-mongos
sudo apt-get install -y mongodb-org
sudo apt-get install libc6
sudo service mongod start
sudo service mongod status
