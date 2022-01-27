AKASH_NODE := http://akash.c29r3.xyz:80/rpc
AKASH_CHAIN_ID := akashnet-2

AKASH_PROVIDER := akash1m7tex89ddnwp3cm63ehfzfe2kj2uxmsugtx2qc

AKASH_ACCOUNT_ADDRESS := akash1jd7hz99wmanpzrup4mlcn6ex9dmj5x2rtlmnvu
AKASH_KEY_NAME := akash-wallet
AKASH_KEYRING_BACKEND := file
AKASH_DSEQ := 4455584
AKASH_OSEQ=1
AKASH_GSEQ=1

.PHONY: account
account:
	@echo "akash key name: $(AKASH_KEY_NAME)"
	akash keys add $(AKASH_KEY_NAME) --keyring-backend  $(AKASH_KEYRING_BACKEND) --keyring-dir ./wallet/akash-wallet

.PHONY: network
network:
	@./scripts/configure-network.sh

.PHONY: check-account-balance
check-account-balance:
	akash query bank balances --node $(AKASH_NODE) $(AKASH_ACCOUNT_ADDRESS)

.PHONY: account-certificate
account-certificate:
	akash tx cert create client \
		--chain-id $(AKASH_CHAIN_ID) \
		--keyring-backend file \
		--keyring-dir ./wallet/$(AKASH_KEY_NAME) \
		--from $(AKASH_KEY_NAME) \
		--node $(AKASH_NODE) \
		--fees 5000uakt

.PHONY: deployment-template
deployment-template:
	curl -s https://raw.githubusercontent.com/ovrclk/docs/master/guides/deploy/deploy.yml > deploy.template.yaml

.PHONY: deployment
deployment:
	akash tx deployment create deploy.template.yaml \
		--chain-id $(AKASH_CHAIN_ID) \
		--node $(AKASH_NODE) \
		--from $(AKASH_KEY_NAME) \
		--keyring-backend file \
		--keyring-dir ./wallet/$(AKASH_KEY_NAME) \
		--fees 5000uakt -y

.PHONY: update-deployment
update-deployment:
	akash tx deployment update deploy.template.yml
		--chain-id $(AKASH_CHAIN_ID) \
		--node $(AKASH_NODE) \
		--from $(AKASH_KEY_NAME) \
		--keyring-backend file \
		--keyring-dir ./wallet/$(AKASH_KEY_NAME) \
		--dseq $(AKASH_DSEQ) \
		--fees=5000uakt

.PHONY: deployment-value
deployment-value:
	@echo $(AKASH_DSEQ) $(AKASH_OSEQ) $(AKASH_GSEQ)

.PHONY: check-deployment-bid
check-deployment-bid:
	akash query market bid list --owner=$(AKASH_ACCOUNT_ADDRESS) --node $(AKASH_NODE) --dseq $(AKASH_DSEQ)

.PHONY: create-deployment-lease
create-deployment-lease:
	akash tx market lease create \
		--chain-id $(AKASH_CHAIN_ID) \
		--node $(AKASH_NODE) \
		--from $(AKASH_KEY_NAME) \
		--keyring-backend file \
		--keyring-dir ./wallet/$(AKASH_KEY_NAME) \
		--owner $(AKASH_ACCOUNT_ADDRESS) \
		--provider $(AKASH_PROVIDER) \
		--dseq $(AKASH_DSEQ) \
		--gseq $(AKASH_GSEQ) \
		--oseq $(AKASH_OSEQ) \
		--gas auto \
		--fees 5000uakt

.PHONY: close-deployment-bid
close-deployment-bid:
	akash tx deployment close \
		--from=$(AKASH_KEY_NAME) \
		--dseq $(AKASH_DSEQ) \
		--fees 5000uakt \
		--gas auto

.PHONY: check-lease
check-lease:
	akash query market lease list \
		--owner $(AKASH_ACCOUNT_ADDRESS) \
		--node $(AKASH_NODE) \
		--dseq $(AKASH_DSEQ)

.PHONY: upload-manifest
upload-manifest:
	akash provider send-manifest deploy.template.yaml \
		--node $(AKASH_NODE) \
		--from $(AKASH_KEY_NAME) \
		--provider $(AKASH_PROVIDER) \
		--gseq $(AKASH_GSEQ) \
		--oseq $(AKASH_OSEQ) \
		--dseq $(AKASH_DSEQ)

.PHONY: confirm-lease
confirm-lease:
	akash provider lease-status \
		--node $(AKASH_NODE) \
		--from $(AKASH_KEY_NAME) \
		--provider $(AKASH_PROVIDER) \
		--home ~/.akash \
		--dseq $(AKASH_DSEQ)
