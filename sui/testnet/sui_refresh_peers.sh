#!/bin/bash

curl https://raw.githubusercontent.com/pavlobornia/testnet-tools-public/master/logo/logo.sh | bash
echo "Залітайте в наше Discord комюніті https://discord.gg/weSuTQ2Dx7"


cp $HOME/sui/crates/sui-config/data/fullnode-template.yaml $HOME/.sui/fullnode.yaml

sed -i.bak "s|db-path:.*|db-path: \"$HOME\/.sui\/db\"| ; s|genesis-file-location:.*|genesis-file-location: \"$HOME\/.sui\/genesis.blob\"| ; s|127.0.0.1|0.0.0.0|" $HOME/.sui/fullnode.yaml

sudo tee -a /root/.sui/fullnode.yaml << END
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
   - address: "/ip4/46.4.119.19/udp/8084"
   - address: "/ip4/89.58.5.19/udp/8084"
   - address: "/dns/sui-testnet.fort.software/udp/8080"
   - address: "/ip4/207.180.201.73/udp/8084"
   - address: "/ip4/65.109.108.186/udp/8084"
   - address: "/ip4/51.161.87.146/udp/8084"
     peer-id: 54c469f0337a0c845d98e1e68f30e5168fcdbdfae803be1e20c94841cfa6a0e5
   - address: "/dns/testnet.sui-fullnode.com/udp/8080"
   - address: "/dns/au.testnet.sui-fullnode.com/udp/8080"
END

sudo systemctl restart suid.service
