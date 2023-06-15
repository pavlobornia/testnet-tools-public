#!/bin/bash
cd $HOME/massa/massa-client
massa_wallet_address=$(./massa-client --pwd $massa_password wallet_info | grep Address | awk '{ print $2 }')
while true
do
        balance=$(./massa-client --pwd $massa_password wallet_info | grep 'Balance' | awk '{print $3}' | sed 's/=/ /'|sed 's/,/ /'|awk '{print $2}')
        int_balance=${balance%%.*}
        if [ $int_balance -gt "99" ]; then
                echo "More than 99"
                resp=$(./massa-client --pwd $massa_password buy_rolls $massa_wallet_address $(($int_balance/100)) 0)
                echo $resp
        elif [ $int_balance -lt "100" ]; then
                echo "Less than 100"
        fi
        printf "sleep"
        for((sec=0; sec<60; sec++))
        do
                printf "."
                sleep 1
        done
        printf "\n"
done
