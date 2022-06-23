#!/bin/bash

BITCOIN_RPCUSER=${BITCOIN_RPCUSER:-bitcoin}
BITCOIN_RPCPASSWORD=${BITCOIN_RPCPASSWORD:-bitcoin}

mkdir -p /root/.bitcoin/
rm -f /root/.bitcoin/bitcoin.conf
touch /root/.bitcoin/bitcoin.conf
chmod 0600 /root/.bitcoin/bitcoin.conf

echo "regtest=1" >>/root/.bitcoin/bitcoin.conf &&
  echo "rpcuser=${BITCOIN_RPCUSER}" >>/root/.bitcoin/bitcoin.conf &&
  echo "rpcpassword=${BITCOIN_RPCPASSWORD}" >>/root/.bitcoin/bitcoin.conf &&
  echo "regtest.rpcallowip=0.0.0.0/0" >>/root/.bitcoin/bitcoin.conf &&
  echo "regtest.rpcbind=0.0.0.0" >>/root/.bitcoin/bitcoin.conf

# create wallets for regtest
if [[ -n ${BITCOIN_REGTEST_CREATE_WALLETS} ]]; then
  bitcoind -conf=/root/.bitcoin/bitcoin.conf -regtest -daemon
  sleep 5

  for walletName in ${BITCOIN_REGTEST_CREATE_WALLETS//,/ }; do
    bitcoin-cli -regtest -rpcuser="${BITCOIN_RPCUSER}" -rpcpassword="${BITCOIN_RPCPASSWORD}" createwallet "$walletName" || true
  done

  bitcoin-cli -regtest stop
fi

# shellcheck disable=SC2068
bitcoind -conf=/root/.bitcoin/bitcoin.conf -daemon -printtoconsole $@
sleep 5
chmod -R 0777 /root/.bitcoin/
tail -f /dev/null
