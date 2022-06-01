# Скрипти для проекту IronFish

### Перевірка статусу і балансу

###### Встановлення:

wget -q -O ironfish_status.sh https://raw.githubusercontent.com/pavlobornia/testnet-tools-public/master/ironfish/status.sh && chmod +x ironfish_status.sh

###### Запуск:

. ironfish_status.sh

### Скрипт для відправки транзакцій

###### Встановлення:

wget -q -O ironfish_deposit.sh https://raw.githubusercontent.com/pavlobornia/testnet-tools-public/master/ironfish/deposit.sh && chmod +x ironfish_deposit.sh

###### Запуск:

Запускаємо через tmux

Створюємо сессію з назвою deposit

tmux new-session -s deposit

Запускаємо скрипт

. ./ironfish_deposit.sh

Підключитись до сессії:

tmux attach -t session

