#!/bin/bash
# This script cleans all docker images and containers in a given host. 
# Usage: bash docker-cleanup.sh 


# List All Docker Images
echo "List of Docker Images"
echo "......................"
docker images

# List All Docker Containers
echo ""
echo "List of Docker Containers"
echo ".........................."
docker ps -a

# Stop all containers
docker stop $(docker ps -aq)
# Delete all containers
docker rm $(docker ps -aq)
# Delete all images
docker rmi --force $(docker images -q)
