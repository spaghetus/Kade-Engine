#!/bin/bash
echo "Preparing builder image..."
docker build . -t kade-build
echo "Building..."
docker run --rm -v $(pwd):/src -v $(realpath out):/out kade-build
