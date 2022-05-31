# Скрипти для проекту IronFish

### Перевірка статусу і балансу

###### Встановлення:

wget -q -O ironfish_status.sh https://raw.githubusercontent.com/pavlobornia/testnet-tools-public/feat/ironfish/ironfish/status.sh && chmod +x ironfish_status.sh

###### Запуск:

. ironfish_status.sh

### Скрипт для відправки транзакцій

###### Встановлення:

wget -q -O ironfish_deposit.sh https://raw.githubusercontent.com/pavlobornia/testnet-tools-public/feat/ironfish/ironfish/deposit.sh && chmod +x ironfish_deposit.sh

###### Запуск:

Запускаємо через tmux

. ./ironfish_deposit.sh


