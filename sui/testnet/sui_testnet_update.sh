#!/bin/bash

curl https://raw.githubusercontent.com/pavlobornia/testnet-tools-public/master/logo/logo.sh | bash
echo "Залітайте в наше Discord комюніті https://discord.gg/weSuTQ2Dx7"
# read -p "Видалити базу даних? (y/n) " answer
systemctl stop suid.service
# cd $HOME 
# if [ "$answer" == "y" ]; then
#   rm -rf /var/sui/suidb/* 
#   echo "База даних видалена."
# fi

rm -rf sui 
git clone https://github.com/MystenLabs/sui.git
cd sui
git fetch upstream
git reset --hard c525ba6489261ff6db65e87bf9a3fdda0a6c7be3
cargo build --release --bin sui-node
sudo mv ~/sui/target/release/sui-node /usr/local/bin/
systemctl restart suid.service
# echo ""
# sui-node --version
# echo "Нода оновлена. Перевіряємо логи"
# sleep 10
# if dpkg --list | grep -q ccze;
# then
#         journalctl -fn 10 -u suid.service | ccze -A
# else
#         journalctl -fn 10 -u suid.service
# fi   
