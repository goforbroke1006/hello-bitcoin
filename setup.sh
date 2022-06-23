#!/bin/bash

sudo apt-get update

sudo apt install -y python3.8-venv
if [[ ! -d ./venv/ ]]; then
  python3 -m venv ./venv/
  source ./venv/bin/activate
fi

sudo add-apt-repository ppa:luke-jr/bitcoincore -y
sudo apt-get update

sudo apt-get install -y bitcoind
