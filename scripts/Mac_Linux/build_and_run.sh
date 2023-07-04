#!/bin/bash

# Get the commit hash
commit_hash=$(git rev-parse --short HEAD)

# Run linting with Black
black .

# Check if the image exists before destroying it
if docker inspect dastfox/oc_lettings:$commit_hash &> /dev/null; then
    # Destroy the existing image
    docker rmi dastfox/oc_lettings:$commit_hash
fi

# Build and tag the Docker image
docker build -t dastfox/oc_lettings:$commit_hash --label commit_hash=$commit_hash --build-arg PORT=8000 .

# Check if the container exists before removing it
if docker inspect oc_lettings_container &> /dev/null; then
    # Remove the existing container
    docker rm -f oc_lettings_container
fi

# Run the site locally using the tagged image with a custom container name
docker run -p 8000:8000 --name oc_lettings_container dastfox/oc_lettings:$commit_hash
