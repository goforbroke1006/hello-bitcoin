all:
	bash ./setup.sh
.PHONY: all

image:
	docker login docker.io
	docker build \
		-f ./.docker/bitcoin/Dockerfile \
		-t docker.io/goforbroke1006/bitcoin:latest \
		./.docker/bitcoin/
	docker push docker.io/goforbroke1006/bitcoin:latest
.PHONY: image
