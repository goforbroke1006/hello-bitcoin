FROM ubuntu:20.04

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y software-properties-common

RUN add-apt-repository ppa:luke-jr/bitcoincore -y
RUN apt-get update
RUN apt-get install -y bitcoind

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

EXPOSE 8332
EXPOSE 8333

# testnet
EXPOSE 18332

 # regtest
EXPOSE 18443
EXPOSE 18444
EXPOSE 18445
