#!/bin/bash

curl https://raw.githubusercontent.com/pavlobornia/testnet-tools-public/master/logo/logo.sh | bash

# умова циклу пуста тому він буде виконуватись безкінечно ???



until (( ))
do 
    # start timer
    start=$(date +%s) 
    # перечитуємо змінні і перевіряємо чи нода синхронізована.
    . ./.bash_profile 
    REALY=$( yarn --cwd ~/ironfish/ironfish-cli/ start status | grep Syncer | awk '{print $2}' )
    if [[ $REALY == IDLE ]]; then
        echo $REALY
        echo "Нода синхронізована! Перевіряємо баланс"
        BALANCE=$( yarn --cwd ~/ironfish/ironfish-cli/ start accounts:balance | grep Amount | awk '{print $6}' | sed 's/\,//' )
        if (( $(echo "${BALANCE} >= 0.10000001" | bc -l) )); then

            echo $BALANCE 
            echo "Баланс достатній, робимо транзакцію"
            yarn --cwd ~/ironfish/ironfish-cli/ start deposit --confirm
            sleep 180     
            # навіщо таке довге очікування після депозиту ???
        else            
            echo $BALANCE          
            echo "Балансу недоcтатньо, наступна спроба через три хвилини."
            sleep 180
        fi
    else
        echo "Нода не синхронізована! Наступна спроба через три хвилини."
        echo Статус: $REALY
        sleep 180
    fi
    #stop timer & count result
    end=$(date +%s)
    seconds=$(echo "$end - $start" | bc)

    #show timer result
    echo ""
    echo "Готово, час виконання $seconds ceк."
done