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
