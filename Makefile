.PHONY: install clean test

.DEFAULT_GOAL := install

install: clean
	@./scripts/install.sh

clean:
	@./scripts/clean.sh

test:
	@./tests/run.sh
