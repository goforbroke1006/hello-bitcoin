FROM ubuntu:20.04

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y software-properties-common
RUN #apt-get install -y gnupg

#RUN apt-get install -y build-essential
#RUN apt-get install -y libtool autotools-dev autoconf
#RUN apt-get install -y libssl-dev
#RUN apt-get install -y libboost-all-dev

RUN add-apt-repository ppa:luke-jr/bitcoincore -y
RUN apt-get update

RUN apt-get install -y bitcoind

RUN mkdir -p /root/.bitcoin/
RUN echo "regtest=1" >> /root/.bitcoin/bitcoin.conf && \
    echo "rpcuser=bitcoin" >> /root/.bitcoin/bitcoin.conf && \
    echo "rpcpassword=bitcoin" >> /root/.bitcoin/bitcoin.conf && \
    echo "regtest.rpcallowip=0.0.0.0/0" >> /root/.bitcoin/bitcoin.conf && \
    echo "regtest.rpcbind=0.0.0.0" >> /root/.bitcoin/bitcoin.conf

ENTRYPOINT [ "bitcoind", "-conf=/root/.bitcoin/bitcoin.conf", "-printtoconsole" ]

EXPOSE 8332
EXPOSE 8333
