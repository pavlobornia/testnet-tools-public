#!/bin/bash

curl https://raw.githubusercontent.com/pavlobornia/testnet-tools-public/master/logo/logo.sh | bash


echo "Install Rust"
sudo curl https://sh.rustup.rs -sSf | sh -s -- -y
source $HOME/.cargo/env

echo "Check rust version"
rustc --version

mkdir $HOME/.sui

cd $HOME
git clone https://github.com/MystenLabs/sui.git
cd sui
git remote add upstream https://github.com/MystenLabs/sui
git fetch upstream
git checkout --track upstream/testnet

cp $HOME/sui/crates/sui-config/data/fullnode-template.yaml $HOME/.sui/fullnode.yaml

sed -i.bak "s|db-path:.*|db-path: \"$HOME\/.sui\/db\"| ; s|genesis-file-location:.*|genesis-file-location: \"$HOME\/.sui\/genesis.blob\"| ; s|127.0.0.1|0.0.0.0|" $HOME/.sui/fullnode.yaml

wget -P $HOME/.sui https://github.com/MystenLabs/sui-genesis/raw/main/testnet/genesis.blob

cargo build --release -p sui-node -p sui

sudo mv $HOME/sui/target/release/sui-node /usr/local/bin/
sudo mv $HOME/sui/target/release/sui /usr/local/bin/

echo "[Unit]
Description=Sui Node
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=/usr/local/bin/sui-node --config-path $HOME/.sui/fullnode.yaml
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/suid.service

echo "Add peers to config"

sudo tee -a $HOME/.sui/fullnode.yaml << END

p2p-config:
  seed-peers:
   - address: "/dns/sui-rpc-pt.testnet-pride.com/udp/8084"
     peer-id: 0b10182585ae4a305721b1823ea5a9c3ce7d6ac4b4a8ce35fe96d9914c8fcb73
   - address: "/dns/sui-rpc-pt2.testnet-pride.com/udp/8084"
     peer-id: bf45f2bd2bbc4c2d53d10c05c96085d4ef18688af04649d6e65e1ebad1716804
   - address: "/dns/sui-rpc-testnet.bartestnet.com/udp/8084"
   - address: "/ip4/38.242.197.20/udp/8080"
   - address: "/ip4/178.18.250.62/udp/8080"
   - address: "/ip4/162.55.84.47/udp/8084"
   - address: "/dns/wave-3.testnet.n1stake.com/udp/8084"
END

sudo systemctl restart suid.service
sudo systemctl daemon-reload
sudo systemctl enable suid.service
sudo systemctl start suid.service

if dpkg --list | grep -q ccze;
then
        journalctl -fn 10 -u suid.service | ccze -A
else
        journalctl -fn 10 -u suid.service
fi   