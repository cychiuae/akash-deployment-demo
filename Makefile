AKASH_KEY_NAME := akash-wallet
AKASH_KEYRING_BACKEND := file

.PHONY: account
account:
	@echo "akash key name: $(AKASH_KEY_NAME)"
	akash keys add $(AKASH_KEY_NAME) --keyring-backend  $(AKASH_KEYRING_BACKEND) --keyring-dir ./wallet/akash-wallet
