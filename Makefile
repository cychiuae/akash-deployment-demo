AKASH_KEY_NAME := akash-wallet
AKASH_KEYRING_BACKEND := file

.PHONY: account
account:
	@echo "akash key name: $(AKASH_KEY_NAME)"
	akash keys add $(AKASH_KEY_NAME) --keyring-backend  $(AKASH_KEYRING_BACKEND) --keyring-dir ./wallet/akash-wallet

.PHONY: network
network:
	@./scripts/configure-network.sh

.PHONY: check-account-balance
check-account-balance: network
	$(eval AKASH_ACCOUNT_ADDRESS := $(shell akash keys show $(AKASH_KEY_NAME) -a --keyring-backend file --keyring-dir ./wallet/akash-wallet))
	akash query bank balances --node $(AKASH_NODE) $(AKASH_ACCOUNT_ADDRESS)

.PHONY: account-certificate
account-certificate: network
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
