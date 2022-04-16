#!bin/bash

curl https://raw.githubusercontent.com/pavlobornia/testnet-tools-public/master/logo/logo.sh | bash

sleep 1

echo "Зупиняємо archway"
sudo systemctl stop archwayd
sudo systemctl disable archwayd
rm /etc/systemd/system/archwayd.service

sleep 1

echo "Бекапимо конфіг"

cp -rf .archway/config $HOME/archway.backup.$(date +%d-%m-%Y)

sleep 1

echo "Перезавантажуємо daemon"

sudo systemctl daemon-reload

echo "Видаляємо файли archway"

cd $HOME
rm -rf .archway archway 
rm -rf $(which archwayd)

sleep 1

echo "Готово, нода archway видалена"