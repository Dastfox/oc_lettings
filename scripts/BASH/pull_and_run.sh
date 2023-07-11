#!/bin/bash

i=0

while IFS= read -r line; do
  ((i++))
  tag[$i]=$line
  echo "$i. $line"
done < scripts/commit_history.txt

echo
read -p "Tag number: " image_tag

# Validation of the input
if [[ ! ${tag[$image_tag]} ]]; then
  echo "Invalid choice"
  exit 1
fi

full_tag="${tag[$image_tag]}"
image_tag=$(echo "$full_tag" | awk -F'=' '{print $2}')

echo "Pulling: $DOCKER_USERNAME/$DOCKER_APP_NAME:$image_tag"
# Pull Docker image
docker pull "$DOCKER_USERNAME/$DOCKER_APP_NAME:$image_tag"

# Run Docker image
docker run --env-file .env -p 8000:8000 --name "$DOCKER_APP_NAME"_container_"$image_tag" "$DOCKER_USERNAME/$DOCKER_APP_NAME:$image_tag"
