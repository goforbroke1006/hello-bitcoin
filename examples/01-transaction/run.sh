#!/bin/bash

# This example shows how to create 2 wallets,
# make deposits to both of them,
# move coins from wallet 2 to wallet 1

# https://developer.bitcoin.org/examples/transactions.html

set -e

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1
  pwd -P
)"
cd "${SCRIPTPATH}/../../"

# set up
docker-compose down --volumes
docker-compose up -d

export cli_args="-regtest -rpcuser=bitcoin -rpcpassword=bitcoin"

# health-check
while true; do
  if bitcoin-cli $cli_args ping; then
    break
  fi

  echo "Retry ping..."
  sleep 1
done

WALLET_1=testwallet1
WALLET_2=testwallet2

echo "Create '${WALLET_1}' and '${WALLET_2}' wallets"
bitcoin-cli $cli_args createwallet ${WALLET_1}
bitcoin-cli $cli_args createwallet ${WALLET_2}

bitcoin-cli $cli_args unloadwallet ${WALLET_1} >/dev/null 2>&1
bitcoin-cli $cli_args unloadwallet ${WALLET_2} >/dev/null 2>&1

bitcoin-cli $cli_args listwallets

echo "Wallet ${WALLET_1} balance:"
bitcoin-cli $cli_args loadwallet ${WALLET_1} >/dev/null 2>&1
bitcoin-cli $cli_args -rpcwallet=${WALLET_1} getbalance
bitcoin-cli $cli_args unloadwallet ${WALLET_1} >/dev/null 2>&1

echo "Wallet ${WALLET_2} balance:"
bitcoin-cli $cli_args loadwallet ${WALLET_2} >/dev/null 2>&1
bitcoin-cli $cli_args -rpcwallet=${WALLET_2} getbalance
bitcoin-cli $cli_args unloadwallet ${WALLET_2} >/dev/null 2>&1

echo "Deposit 500 blocks to ${WALLET_1}"
bitcoin-cli $cli_args loadwallet ${WALLET_1} >/dev/null 2>&1
walletAddr10=$(bitcoin-cli $cli_args -rpcwallet=${WALLET_1} getnewaddress)
bitcoin-cli $cli_args generatetoaddress 500 "$walletAddr10" >/dev/null 2>&1
bitcoin-cli $cli_args unloadwallet ${WALLET_1} >/dev/null 2>&1

echo "Deposit 200 blocks to ${WALLET_2}"
bitcoin-cli $cli_args loadwallet ${WALLET_2} >/dev/null 2>&1
walletAddr20=$(bitcoin-cli $cli_args -rpcwallet=${WALLET_2} getnewaddress)
bitcoin-cli $cli_args generatetoaddress 200 "$walletAddr20" >/dev/null 2>&1
bitcoin-cli $cli_args unloadwallet ${WALLET_2} >/dev/null 2>&1

# wait for blockchain sync
sleep 10

echo "Wallet ${WALLET_1} balance:"
bitcoin-cli $cli_args loadwallet ${WALLET_1} >/dev/null 2>&1
bitcoin-cli $cli_args -rpcwallet=${WALLET_1} getbalance
bitcoin-cli $cli_args unloadwallet ${WALLET_1} >/dev/null 2>&1

echo "Wallet ${WALLET_2} balance:"
bitcoin-cli $cli_args loadwallet ${WALLET_2} >/dev/null 2>&1
bitcoin-cli $cli_args -rpcwallet=${WALLET_2} getbalance
bitcoin-cli $cli_args unloadwallet ${WALLET_2} >/dev/null 2>&1

(
  #
  # get address of wallet # 1
  #
  bitcoin-cli $cli_args loadwallet ${WALLET_1} >/dev/null 2>&1
  walletAddr11=$(bitcoin-cli $cli_args -rpcwallet=${WALLET_1} getnewaddress)
  bitcoin-cli $cli_args unloadwallet ${WALLET_1} >/dev/null 2>&1

  #
  # send coins from wallet 2 to wallet 1
  #
  bitcoin-cli $cli_args loadwallet ${WALLET_2} >/dev/null 2>&1
  bitcoin-cli $cli_args -named sendtoaddress address=$walletAddr11 amount=10.00 fee_rate=25 verbose=true
  bitcoin-cli $cli_args unloadwallet ${WALLET_2} >/dev/null 2>&1

  # wait for blockchain sync
  sleep 10

  #
  # check balances after transaction
  #

  echo "Wallet ${WALLET_1} balance TOTAL:"
  bitcoin-cli $cli_args loadwallet ${WALLET_1} >/dev/null 2>&1
  bitcoin-cli $cli_args -rpcwallet=${WALLET_1} getbalance
  echo "== Wallet ${WALLET_1} balance from fake mining:"
  bitcoin-cli $cli_args getreceivedbyaddress $walletAddr10 0
  echo "== Wallet ${WALLET_1} balance from another wallet transaction:"
  bitcoin-cli $cli_args getreceivedbyaddress $walletAddr11 0
  bitcoin-cli $cli_args unloadwallet ${WALLET_1} >/dev/null 2>&1

  echo "Wallet ${WALLET_2} balance TOTAL:"
  bitcoin-cli $cli_args loadwallet ${WALLET_2} >/dev/null 2>&1
  bitcoin-cli $cli_args -rpcwallet=${WALLET_2} getbalance
  bitcoin-cli $cli_args unloadwallet ${WALLET_2} >/dev/null 2>&1
)

# tear-down
docker-compose down --volumes
