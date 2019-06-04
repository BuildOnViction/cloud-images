#/usr/bin/env bash

# check if the network name was specified
if [ ! -z $1 ]
then
    # if yes, check that there is a corresponsing genesis
    genesis_path="${HOME}/.puppeth/${1}"
    if [ -f "$genesis_path" ]
    then
        echo "! | Found a genesis for network ${1}"
        
    else
        echo "x | No genesis found with that network name"
        echo "  | Please create one with puppeth"
        exit 1
    fi
else
    echo "x | Please provide a network name"
    exit 1
fi

# create the container with the right startup options
echo "  | Creating your masternode container"
# ask for private key
echo "? | Please enter your masternode coinbase private key"
private_key=$(read -sp "> | "); echo ""

exit
# this is not correct yet
docker create \
    --name "${1}01" \
    -e IDENTITY="${1}01" \
    -e PRIVATE_KEY="${private_key}" \
    -e NETWORK_ID="$(jq .genesis.config.chainId ${genesis_path})" \
    -e VERBOSITY=3 \
    -e GENESIS_PATH="/tomochain/genesis.json" \
    -v ${genesis_path}:/tomochain/genesis.json \
    tomochain/node:stable
