#!/bin/bash

curl -s https://raw.githubusercontent.com/pavlobornia/testnet-tools-public/master/logo/logo.sh | bash

echo "Перезавантажуємо сервіс IronFish"

sleep 1

service ironfishd restart

sleep 1

echo "Перевіряємо статус"

ironfish status

echo "Перевіряємо баланс"

ironfish accounts:balance



