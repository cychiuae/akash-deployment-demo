#!/bin/bash -e

AKASH_NET="https://raw.githubusercontent.com/ovrclk/net/master/mainnet"
echo "Fetching akash version..."
AKASH_VERSION="$(curl -s "$AKASH_NET/version.txt")"
echo "Fetching akash chain id..."
export AKASH_CHAIN_ID="$(curl -s "$AKASH_NET/chain-id.txt")"
echo "Fetching akash node..."
export AKASH_NODE="$(curl -s "$AKASH_NET/rpc-nodes.txt" | shuf -n 1)"
echo $AKASH_NODE $AKASH_CHAIN_ID $AKASH_KEYRING_BACKEND
