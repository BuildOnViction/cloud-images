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

# create the container with the right startup options
echo "  Creating your masternode container"
# ask for private key
echo "? Please enter your masternode coinbase private key"
private_key=$(read -sp "> (input is hidden) "); echo ""

exit
# this is not correct yet
docker create \
    --name "${1}01" \
    -e IDENTITY="${1}01" \
    -e PRIVATE_KEY="${private_key}" \
    -e NETWORK_ID="$(jq .config.chainId ${GENESIS_PATH})" \
    -e VERBOSITY=3 \
    -e GENESIS_PATH="/tomochain/genesis.json" \
    -v ${GENESIS_PATH}:/tomochain/genesis.json \
    tomochain/node:stable

if [ $? -eq 0 ]
then
    echo "  Container ${1}01 created"
else
    echo "x Could not create container ${1}01"
fi
