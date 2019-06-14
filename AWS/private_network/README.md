# Private network image

`[TODO]`

# Usage

Create a genesis file with puppeth.

```bash
puppeth
```

Enter your network name.

Chose option 2 (Configure new genesis).

Chose option 3 (Posv - proof-of-stake-voting).

Fill in the required data:

- **How many seconds should blocks take? (default = 2)**
  
  This will be your block time.
  The default of 2s is recommended.
  You can just press enter to validate a default value.
  
- **How many Ethers should be rewarded to masternode? (default = 10)**
  
  This is the amount of coins that will be rewarded to masternodes on each epoch.
  
- **Who own the first masternodes? (mandatory)**

  This is the address of the account that will own the inital masternodes.
  Not to be mistaken with the accounts *used* by a masternode.
  
- **Which accounts are allowed to seal (signers)? (mandatory at least one)**

  This is the addresses of the first masternode that are authorized to producs blocks at start.
  We advise to fill at least 3 addresses as the consensus will not work with less than 3 masternodes.
  The addresses must be unique.
  
- **How many blocks per epoch? (default = 900)**

  This is the number of blocks per epoch.
  It will also determine the duration of an epoch by multiplying this value by the block time.
  We don't advise to put a value too low as there is a lot of work done at checkpoint.
  The default value of 900 blocks is safe to use and gives epochs of ~30 min.
  
- **How many blocks before checkpoint need to prepare new set of masternodes? (default = 450)**

  This is determining how many blocks before checkpoint the new list of masternodes for the next epoch should be calculated.
  The default value of 450 blocks is safe to use as it let the list being ready before the checkpoint.
  
- **What is foundation wallet address? (default = 0x0000000000000000000000000000000000000068)**
  
  This is the address of the fundation wallet.
  10% of the rewards are sent to the fundation wallet.
  See the [white paper](https://docs.tomochain.com/wp-and-research/technical-whitepaper/#reward-mechanism) for more details on how rewards are distributed.
  
- **Which accounts are allowed to confirm in Foudation MultiSignWallet?**

  Those are the accounts authorized to confirm transactions of the fundation wallet.
  
- **How many require for confirm tx in Foudation MultiSignWallet? (default = 2)**
  
  This is the minimum number of confirmations (from last step accounts) required to validate a transaction.

- **Which accounts are allowed to confirm in Team MultiSignWallet?**

  Those are the accounts authorized to confirm transactions of the team wallet.
  
- **How many require for confirm tx in Team MultiSignWallet? (default = 2)**

  This is the minimum number of confirmations (from last step accounts) required to validate a transaction.

- **What is swap wallet address for fund 55m tomo?**

  This is the address of the swap account for the 55 millions initial circulating coins.
  
- **Which accounts should be pre-funded? (advisable at least one)**

  This option let you prefund an accound.
  We advise to set at least an account here to easy access to funds.
  
- **Specify your chain/network ID if you want an explicit one (default = random)**
  
  This is the chainid used by your chain.
  You can set one manually or just use a random one.
  
At this point your genesis should be created.

```
INFO [06-14|04:51:31] Configured new genesis block 
```

Simply leave puppeth with `ctrl + c`.

Extract the genesis from the puppeth file.

```bash
jq .genesis $HOME/.puppeth/name_of_your_network > $HOME/genesis.json
```

Fill in the missing values in `masternode.env`:

- TODO

Start your node.

```bash
docker-compose up -d -f masternode.yml
```

