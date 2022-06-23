# hello-bitcoin

```shell
# start environment
docker-compose up -d

# load wallets
bitcoin-cli -regtest -rpcuser=bitcoin -rpcpassword=bitcoin loadwallet "testwallet1"
bitcoin-cli -regtest -rpcuser=bitcoin -rpcpassword=bitcoin loadwallet "testwallet2"

# check balances
bitcoin-cli -regtest -rpcuser=bitcoin -rpcpassword=bitcoin -rpcwallet=testwallet1 getbalance
bitcoin-cli -regtest -rpcuser=bitcoin -rpcpassword=bitcoin -rpcwallet=testwallet2 getbalance

# deposit to both wallets
bitcoin-cli -regtest -rpcuser=bitcoin -rpcpassword=bitcoin generatetoaddress 100 $(bitcoin-cli -regtest -rpcuser=bitcoin -rpcpassword=bitcoin -rpcwallet=testwallet1 getnewaddress)
bitcoin-cli -regtest -rpcuser=bitcoin -rpcpassword=bitcoin generatetoaddress 100 $(bitcoin-cli -regtest -rpcuser=bitcoin -rpcpassword=bitcoin -rpcwallet=testwallet2 getnewaddress)

# get balances again
bitcoin-cli -regtest -rpcuser=bitcoin -rpcpassword=bitcoin -rpcwallet=testwallet1 getbalance
bitcoin-cli -regtest -rpcuser=bitcoin -rpcpassword=bitcoin -rpcwallet=testwallet2 getbalance

```
