IMAGE_TAG := $(shell git rev-parse HEAD)
IMAGE_NAME := parkr/golang-auto
IMAGE := $(IMAGE_NAME):$(IMAGE_TAG)

all: build test

build:
	docker build -t $(IMAGE) .

test:
	docker run \
		-e GOLANG_PACKAGE=github.com/parkr/ping \
		-e GOLANG_PACKAGE_SHA1=00d3c8d6bb926e5a890185e65c564ca57432de4d \
		$(IMAGE) \
		ping -h || true
	docker run \
		-e GOLANG_PACKAGE=golang.org/x/build/maintner \
		-e GOLANG_PACKAGE_SHA1=978be913b44daae8f73405697bfdf7dbfbf59bc5 \
		$(IMAGE) \
		maintserve -h

docker-release: build
	docker push $(IMAGE)
