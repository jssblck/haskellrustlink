
build: build-cargo
	cabal build

build-cargo:
	cargo build --release

.PHONY: build build-cargo
