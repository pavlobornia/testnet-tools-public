#!/bin/bash

start=$(date +%s)

curl -s https://raw.githubusercontent.com/pavlobornia/testnet-tools-public/master/logo/logo.sh | bash

echo "1. Перезавантажуємо сервіс IronFish"
systemctl restart ironfishd
echo "Сервіс перезавантажено"

sleep 5
echo ""
echo "Перевіряємо статус"
ironfish status

echo ""
echo "Перевіряємо баланс"
ironfish accounts:balance

end=$(date +%s)
seconds=$(echo "$end - $start" | bc)

echo $seconds' sec'




