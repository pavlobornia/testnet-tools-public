#!/bin/bash

curl https://raw.githubusercontent.com/pavlobornia/testnet-tools-public/master/logo/logo.sh | bash
echo "Залітайте в наше Discord комюніті https://discord.gg/weSuTQ2Dx7"
echo "Оновлення ноди Sui в менежі девнет встановленої за гайдом NodesGuru."
read -p "Видалити базу даних? (y/n) " answer
systemctl stop suid.service
cd $HOME 
if [ "$answer" == "y" ]; then
  rm -rf /var/sui/suidb/*    
  echo "База даних видалена."
fi
rm -rf /var/sui/genesis.blob $HOME/sui
source $HOME/.cargo/env
cd $HOME
git clone https://github.com/MystenLabs/sui.git
cd sui
git checkout devnet-0.27.0
cargo build --bin sui-node --bin sui --release
mv ~/sui/target/release/sui-node /usr/local/bin/
mv ~/sui/target/release/sui /usr/local/bin/
wget -O /var/sui/genesis.blob https://github.com/MystenLabs/sui-genesis/raw/main/devnet/genesis.blob
systemctl restart suid.service
echo ""
sui-node --version
echo "Нода оновлена. Перевіряємо логи"
sleep 10
if dpkg --list | grep -q ccze;
then
        journalctl -fn 10 -u suid.service | ccze -A
else
        journalctl -fn 10 -u suid.service
fi