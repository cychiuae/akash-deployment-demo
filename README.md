# Akash Deployment

## What I did

### 1. Install akash cli

Follow the instruction in https://docs.akash.network/guides/cli/part-1.-install-akash to install the akash cli

```sh
$ brew tap ovrclk/tap
$ brew install akash
$ brew link akash --force

$ akash version
v0.14.1
```

### 2. Create an akash account

Create an account with `make account`

```
$ make account

- name: mywallet
  type: local
  address: an-address
  pubkey: an-pubkey
  mnemonic: ""
  threshold: 0
  pubkeys: []

seedphrase seedphrase seedphrase seedphrase seedphrase seedphrase seedphrase seedphrase seedphrase seedphrase seedphrase seedphrase
```

Store and blackbox encrypt the info in wallet/akash-wallet.txt

### 3. Get some AKT

I sent some AKTs to the wallet.

### 4. Configure the network info

```sh
$ ./scripts/configure-network.sh

Fetching akash version...
Fetching akash chain id...
Fetching akash node...
http://akash.c29r3.xyz:80/rpc akashnet-2

```

### 5. Query account balance

```sh
$ make check-account-balance

balances:
- amount: "5000000"
  denom: uakt
pagination:
  next_key: null
  total: "0"

```

### 6. Create a certificate for akash-wallet

```sh
$ make account-certificate
```

Received the response and confirm transaction and save the info in wallet/akash-wallet/certificate.txt

### 7. Create a deployment

```sh
$ akash tx deployment create deploy.yaml --from $AKASH_KEY_NAME --node $AKASH_NODE --chain-id $AKASH_CHAIN_ID --fees 5000uakt -y

```

### 8

set gas to auto

### 9

Deployment flow

1. Run `make deployment`
1. Update `AKASH_DSEQ` in Makefile
1. Run `make check-deployment-bid`
1. Choose the one you want
   - My experience is some providers is on9. Even though your deployment created and uploaded successfully, they still cant serve your service
1. Update `AKASH_PROVIDER` in Makefile
1. Run `make create-deployment-lease`
1. Run `make check-lease`. Make sure the status is active but not close
1. Run `make upload-manifest`
1. Run `make confirm-lease` to get the public uri
