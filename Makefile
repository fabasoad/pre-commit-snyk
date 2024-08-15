.PHONY: build clean test

.DEFAULT_GOAL := build

build: clean
	@./scripts/build.sh

clean:
	@./scripts/clean.sh

test:
	@./tests/run.sh
