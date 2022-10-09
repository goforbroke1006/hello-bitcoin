#!/bin/bash

BITCOIN_RPC_USERNAME=${BITCOIN_RPC_USERNAME:-bitcoin}
BITCOIN_RPC_PASSWORD=${BITCOIN_RPC_PASSWORD:-bitcoin}

mkdir -p /root/.bitcoin/
rm -f /root/.bitcoin/bitcoin.conf
touch /root/.bitcoin/bitcoin.conf
chmod 0600 /root/.bitcoin/bitcoin.conf

tee /root/.bitcoin/bitcoin.conf <<EOF
rpcuser=${BITCOIN_RPC_USERNAME}
rpcpassword=${BITCOIN_RPC_PASSWORD}
regtest=1
regtest.rpcallowip=0.0.0.0/0
regtest.rpcbind=0.0.0.0
EOF
#fallbackfee=0.0002

cat /root/.bitcoin/bitcoin.conf

chmod -R 0777 /root/.bitcoin/

# shellcheck disable=SC2068
bitcoind -conf=/root/.bitcoin/bitcoin.conf -daemon -printtoconsole $@

tail -f /dev/null
