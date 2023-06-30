#!/bin/bash

# Get the commit hash
commit_hash=$(git rev-parse --short HEAD)

# Check if the image exists before building it
docker inspect dastfox/oc_lettings:$commit_hash > /dev/null 2>&1
if [ $? -ne 0 ]; then
    # Build and tag the Docker image
    docker build -t dastfox/oc_lettings:$commit_hash --label commit_hash=$commit_hash .
fi

# Check if the container exists before removing it
docker inspect oc_lettings_container > /dev/null 2>&1
if [ $? -eq 0 ]; then
    # Remove the existing container
    docker rm -f oc_lettings_container
fi

# Run the site locally using the tagged image with a custom container name
docker run -p 8000:8000 --name oc_lettings_container dastfox/oc_lettings:$commit_hash
