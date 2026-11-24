.PHONY: build build-no-cache run

NAME=hermes
TARGET=release
TAG=latest

build:
	@podman build --pull=never --ssh default --file Containerfile --tag localhost/$(NAME):$(TAG)
	@podman image tree localhost/$(NAME):$(TAG)

build-no-cache:
	@podman build --pull=never --no-cache --ssh default --file Containerfile --tag localhost/$(NAME):$(TAG)
	@podman image tree localhost/$(NAME):$(TAG)

run:
	@podman run --rm -it -p 3000:3000 localhost/$(NAME):$(TAG) bash
