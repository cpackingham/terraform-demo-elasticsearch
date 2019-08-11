#! /bin/bash

sudo apt update

sudo apt install curl 

# Install filebeat
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.3.0-amd64.deb
sudo dpkg -i filebeat-7.3.0-amd64.deb

# Remove the default config and place in our config
sudo rm /etc/filebeat/filebeat.yml
sudo mv /home/ubuntu/filebeat.yml /etc/filebeat/filebeat.yml