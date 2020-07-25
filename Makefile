.PHONY: bootstrap
bootstrap: vendor/c64unit vendor/acme

vendor/c64unit:
	./bin/c64unit-dependency.sh

vendor/acme:
	git clone https://github.com/meonwax/acme.git vendor/acme