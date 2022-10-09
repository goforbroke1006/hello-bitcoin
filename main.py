from bitcoinrpc.authproxy import AuthServiceProxy

rpc_user = "bitcoin"
rpc_pass = "bitcoin"
rpc_host = "127.0.0.1"
rpc_port = 18443


def print_blocks_info():
    rpc_client = AuthServiceProxy(f"http://{rpc_user}:{rpc_pass}@{rpc_host}:{rpc_port}", timeout=5)

    block_count = rpc_client.getblockcount()
    print("---------------------------------------------------------------")
    print("Block Count:", block_count)
    print("---------------------------------------------------------------\n")

    blockhash = rpc_client.getblockhash(block_count)
    block = rpc_client.getblock(blockhash)

    nTx = block['nTx']
    if nTx > 10:
        it_txs = 10
        list_tx_heading = "First 10 transactions: "
    else:
        it_txs = nTx
        list_tx_heading = f"All the {it_txs} transactions: "
    print("---------------------------------------------------------------")
    print("BLOCK:", block_count)
    print("-------------")
    print("Block Hash...: ", blockhash)
    print("Merkle Root..: ", block['merkleroot'])
    print("Block Size...: ", block['size'])
    print("Block Weight.: ", block['weight'])
    print("Nonce........: ", block['nonce'])
    print("Difficulty...: ", block['difficulty'])
    print("Number of Tx.: ", nTx)
    print(list_tx_heading)
    print("---------------------")
    i = 0
    while i < it_txs:
        print(i, ":", block['tx'][i])
        i += 1
    print("---------------------------------------------------------------\n")


if __name__ == '__main__':
    print_blocks_info()
