#!/bin/bash

curl https://raw.githubusercontent.com/pavlobornia/testnet-tools-public/master/logo/logo.sh | bash

echo "1. Зупиняємо та видаляємо сервіс"

systemctl stop kyved
systemctl disable kyved

echo "2. Видаляємо файли"

rm -Rvf /usr/bin/kyve* $HOME/kyve

echo "3. Видаляємо файли сервісу та перезавантажуємо демон"

rm -v /etc/systemd/system/kyved.service
systemctl daemon-reload