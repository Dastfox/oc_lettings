#!/bin/bash

# Get the commit hash
commit_hash=$(git rev-parse --short HEAD)

# Add the commit hash with the current date to a file
echo "$(date +%F) $(date +%T)=$commit_hash" >> scripts/commit_history.txt

# Read .env file
while IFS='=' read -r key value; do
  if [[ -n $key ]]; then
    export "$key"="$value"
    echo "$key=$value"
  fi
done < .env

# Build and tag the Docker image
docker build -t "$DOCKER_USERNAME/$DOCKER_APP_NAME:$commit_hash" --label commit_hash="$commit_hash" --build-arg PORT=8000 .

# Push the image to Docker Hub
docker push "$DOCKER_USERNAME/$DOCKER_APP_NAME:$commit_hash"

# Run the site locally using the tagged image with a custom container name
docker run --env-file .env -p 8000:8000 --name "$DOCKER_APP_NAME"_container_"$commit_hash"_latest "$DOCKER_USERNAME/$DOCKER_APP_NAME:$commit_hash"
