# Scripts for IronFish

## Balacne and status checking

### Installig:

```
wget -q -O ironfish_status.sh https://raw.githubusercontent.com/pavlobornia/testnet-tools-public/master/ironfish/status.sh && chmod +x ironfish_status.sh
```

### Running:

```
. ironfish_status.sh
```

## Script for sending transaction

### Installing:

```
wget -q -O ironfish_deposit.sh https://raw.githubusercontent.com/pavlobornia/testnet-tools-public/master/ironfish/deposit.sh && chmod +x ironfish_deposit.sh
```

### Running:

Run with tmux

Create new session called deposit

```
tmux new -s deposit
```

Run the script

```
. ./ironfish_deposit.sh
```

Connect to the session:

```
tmux attach -t session
```
