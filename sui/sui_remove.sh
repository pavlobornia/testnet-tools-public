#!/bin/bash

curl https://raw.githubusercontent.com/pavlobornia/testnet-tools-public/master/logo/logo.sh | bash

echo "Stopping and disable the service"
systemctl stop suid.service
systemctl disable suid.service
systemctl daemon-reload
rm /etc/systemd/system/suid.service

echo "Removing Sui files"
rm -rf ~/sui ~/.sui /var/sui/ /usr/local/bin/sui*
