#!/bin/bash

echo 'alias minima_profile="curl 127.0.0.1:9005/incentivecash | jq"' >> $HOME/.bash_profile 

source $HOME/.bash_profile

read -p 'MINIMA_ID: ' MINIMA_ID

echo "Ваш id:" $MINIMA_ID 

wget -O minima_remove.sh https://raw.githubusercontent.com/minima-global/Minima/master/scripts/minima_remove.sh && chmod +x minima_remove.sh && sudo ./minima_remove.sh -p 9001 -x

sleep 1

echo "Видаляємо базу"
sleep 1

rm -rf /home/minima

mkdir -p /home/minima 

wget -O minima_setup.sh https://raw.githubusercontent.com/pavlobornia/testnet-tools-public/feat/minima/minima/scripts/minima_setup.sh && chmod +x minima_setup.sh && sudo ./minima_setup.sh -p 9001

echo "Очікуємо повного запуску "

sleep 15

echo "Перезаписуємо ID"

curl 127.0.0.1:9005/incentivecash%20uid:$MINIMA_ID | jq

echo "Перевіряємо ID"

curl 127.0.0.1:9005/incentivecash | grep $MINIMA_ID

echo "Перевіряємо логи"

if dpkg --list | grep -q ccze;
then
        journalctl -n 10 -f -u minima_9001.service | ccze -A
else
        journalctl -n 10 -f -u minima_9001.service
fi  

