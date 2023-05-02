#!/bin/bash
sudo apt-get update
sudo apt-get install -y apt-transport-https
sudo apt install -y libcurl3
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo mkdir -p /data/db/
sudo mongod --fork --logpath /var/log/mongod.log
