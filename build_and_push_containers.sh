#!/bin/bash

# Output executed commands and stop on errors
set -e -x

# Ensure the correct builder is in use
docker buildx use secure-edge-pro

# Build the node-red image
docker buildx build --platform linux/arm64/v8 --tag 192.168.140.1:5000/eclipse-mosquitto:2.0 --push .
