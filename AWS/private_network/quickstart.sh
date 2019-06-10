#/usr/bin/env bash

GENESIS_PATH="$(pwd)/genesis.json"

# check if the network name was specified
if [ ! -z $1 ]
then
    # if yes, check that there is a corresponsing puppeth network
    echo "  Finding puppet network ${1}"
    puppet_network_path="${HOME}/.puppeth/${1}"
    if [ -f "$puppet_network_path" ]
    then
        echo "  Found ${puppet_network_path}"
        echo "  Extracting genesis"
        genesis=$(jq '.genesis' $puppet_network_path)
        if [ ! -z "$genesis" ]
        then
            echo $genesis > $GENESIS_PATH
            echo "  Created ${GENESIS_PATH}"
        else
            echo "! The file doesn't contain a genesis"
            exit 1
        fi

    else
        echo "! No puppeth network found with the name ${1}"
        exit 1
    fi
else
    echo "! Please provide a network name"
    exit 1
fi
# we need the private key for the node container
echo "? Please enter your masternode coinbase private key"
private_key=$(read -sp "> (hidden) "); echo ""
echo "  Creating your masternode container"
# use latest for now as custom genesis env var is not yet in a stable release
docker create \
    --name "${1}01" \
    -e IDENTITY="${1}01" \
    -e PRIVATE_KEY="${private_key}" \
    -e NETWORK_ID="$(jq .config.chainId ${GENESIS_PATH})" \
    -e VERBOSITY=4 \
    -e GENESIS_PATH="./genesis.json" \
    -v ${GENESIS_PATH}:/tomochain/genesis.json \
    tomochain/node:latest 1> /dev/null 2> error.log
if [ $? -eq 0 ]
then
    echo "  Container ${1}01 created"
else
    echo "x Could not create container ${1}01"
fi
