#!/bin/bash

curl -s https://raw.githubusercontent.com/pavlobornia/testnet-tools-public/master/logo/logo.sh | bash

# start timer
start=$(date +%s)

# restart ironfish service to optimize performance
echo "1. Перезавантажуємо сервіс IronFish"
systemctl restart ironfishd
echo "Сервіс перезавантажено"

# checking status 
echo ""
echo "2. Перевіряємо статус"
sleep 10
ironfish status

# checking balance 
echo ""
echo "3. Перевіряємо баланс"
ironfish accounts:balance

#stop timer & count result
end=$(date +%s)
seconds=$(echo "$end - $start" | bc)

#show timer result
echo ""
echo "Готово, час виконання $seconds' ceкунд'"




