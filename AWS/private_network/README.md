# Private network image

`[TODO]`

# Usage

Create a genesis file with puppeth

```bash
puppeth
```

Fill in the required data:

- TODO

Extract the genesis from the puppeth file

```bash
jq .genesis $HOME/.puppeth/name_of_your_network > $HOME/genesis.json
```

Fill in the missing values in `masternode.env`:

- TODO

Start your node

```bash
docker-compose up -d -f masternode.yml
```

