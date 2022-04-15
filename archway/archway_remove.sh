#!bin/bash

sudo systemctl stop archwayd
sudo systemctl disable archwayd
rm /etc/systemd/system/archwayd.service
sudo systemctl daemon-reload
cd $HOME
rm -rf .archway archway 
rm -rf $(which archwayd)