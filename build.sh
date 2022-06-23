#!/bin/bash

docker login docker.io
docker build -f ./.docker/bitcoin/Dockerfile -t docker.io/goforbroke1006/bitcoin:latest ./.docker/bitcoin/
docker push docker.io/goforbroke1006/bitcoin:latest
