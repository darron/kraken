CONTAINER_NAME ?= darron/litecoin

all: build

build:
	docker buildx build --platform linux/amd64 . -t $(CONTAINER_NAME):latest