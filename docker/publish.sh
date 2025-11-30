#!/bin/bash

version=$(cat VERSION)
# Build for multiple architectures using the updated Dockerfile
docker buildx build . --platform=linux/amd64,linux/arm64 --file Dockerfile --progress=plain \
    -t alsterlabs/ustoredb:$version -t alsterlabs/ustoredb:latest --push