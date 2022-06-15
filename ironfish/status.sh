#!/bin/bash

curl -s https://raw.githubusercontent.com/pavlobornia/testnet-tools-public/master/logo/logo.sh | bash

start=$(date +%s)

echo "1. Перезавантажуємо сервіс IronFish"
systemctl restart ironfishd
echo "Сервіс перезавантажено"

echo ""
echo "2. Перевіряємо статус"
sleep 15
ironfish status

echo ""
echo "3. Перевіряємо баланс"
ironfish accounts:balance

end=$(date +%s)
seconds=$(echo "$end - $start" | bc)

echo ""
echo "Готово, час виконання $seconds ceк."


