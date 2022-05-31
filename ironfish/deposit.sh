#!/bin/bash

until (( ))
do
    . ./.bash_profile 
    REALY=$( yarn --cwd ~/ironfish/ironfish-cli/ start status | grep Syncer | awk '{print $2}' )
    if [[ $REALY == IDLE ]]; then
        echo $REALY
        BALANCE=$( yarn --cwd ~/ironfish/ironfish-cli/ start accounts:balance | grep Amount | awk '{print $6}' | sed 's/\,//' )
        if (( $(echo "${BALANCE} >= 0.10000001" | bc -l) )); then
            echo $BALANCE
            yarn --cwd ~/ironfish/ironfish-cli/ start deposit --confirm
            sleep 180     
        else            
            echo $BALANCE          
            echo Баланса недоcтатньо
            sleep 180
        fi
    else
        echo Статус: $REALY
        sleep 180
    fi
done