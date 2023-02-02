#!/bin/bash

curl https://raw.githubusercontent.com/pavlobornia/testnet-tools-public/master/logo/logo.sh | bash
echo "Залітайте в наше Discord комюніті https://discord.gg/weSuTQ2Dx7"
echo "Оновлення ноди Sui в мережі тестнет встановленої за гайдом NodesGuru."
systemctl stop suid.service
cd $HOME 
rm -rf sui /var/sui/suidb/*
git clone https://github.com/MystenLabs/sui.git
cd sui
git remote add upstream https://github.com/MystenLabs/sui
git fetch upstream
git checkout -B testnet --track upstream/testnet
git log --oneline -1
cargo build --release --bin sui-node
sudo mv ~/sui/target/release/sui-node /usr/local/bin/
systemctl restart suid.service
echo ""
sui -V
echo "Нода оновлена. Перевіряємо логи"
sleep 10
if dpkg --list | grep -q ccze;
then
        journalctl -fn 10 -u suid.service | ccze -A
else
        journalctl -fn 10 -u suid.service
fi   
