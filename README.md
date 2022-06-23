# hello-bitcoin

```shell
bitcoin-cli -regtest -rpcuser=bitcoin -rpcpassword=bitcoin createwallet "testwallet1"

bitcoin-cli -regtest -rpcuser=bitcoin -rpcpassword=bitcoin loadwallet "testwallet1"
bitcoin-cli -regtest -rpcuser=bitcoin -rpcpassword=bitcoin -rpcwallet=testwallet1 getbalance
bitcoin-cli -regtest -rpcuser=bitcoin -rpcpassword=bitcoin -rpcwallet=testwallet1 -generate 200
bitcoin-cli -regtest -rpcuser=bitcoin -rpcpassword=bitcoin -rpcwallet=testwallet1 getbalance
bitcoin-cli -regtest -rpcuser=bitcoin -rpcpassword=bitcoin -rpcwallet=testwallet1 getnewaddress

bitcoin-cli -regtest -rpcuser=bitcoin -rpcpassword=bitcoin createwallet "testwallet2"

bitcoin-cli -regtest -rpcuser=bitcoin -rpcpassword=bitcoin loadwallet "testwallet2"
bitcoin-cli -regtest -rpcuser=bitcoin -rpcpassword=bitcoin -rpcwallet=testwallet2 getbalance
bitcoin-cli -regtest -rpcuser=bitcoin -rpcpassword=bitcoin -rpcwallet=testwallet2 -generate 20
bitcoin-cli -regtest -rpcuser=bitcoin -rpcpassword=bitcoin -rpcwallet=testwallet2 getbalance
bitcoin-cli -regtest -rpcuser=bitcoin -rpcpassword=bitcoin -rpcwallet=testwallet2 getnewaddress

bitcoin-cli -regtest -rpcuser=bitcoin -rpcpassword=bitcoin generatetoaddress 1 $(bitcoin-cli -regtest -rpcuser=bitcoin -rpcpassword=bitcoin -rpcwallet=testwallet2 getnewaddress)

```