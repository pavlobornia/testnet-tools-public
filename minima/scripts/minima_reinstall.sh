#!/bin/bash

echo 'alias minima_profile="curl 127.0.0.1:9005/incentivecash | jq"' >> $HOME/.bash_profile 

source $HOME/.bash_profile

read -p 'MINIMA_ID: ' MINIMA_ID

echo "Ваш id:" $MINIMA_ID 

curl 127.0.0.1:9005/incentivecash%20uid:$MINIMA_ID | jq

minima_profile



