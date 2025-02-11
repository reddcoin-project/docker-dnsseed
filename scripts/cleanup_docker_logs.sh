#!/bin/bash
# Rename $1 to CONTAINER_NAME for better readability
CONTAINER_NAME=$1

# Exit the script if container name not provided
if [ -z "${CONTAINER_NAME}" ]; then
    echo "ERROR: Please provide a container name!"
    exit 1
fi

# Using docker inspect -f to directly fetch container id.
# It makes the script more readable and a bit faster as we get rid of grep and cut.
CONTAINER_ID=$(docker inspect -f '{{.Id}}' ${CONTAINER_NAME})

# Exit the script if CONTAINER_ID is empty (i.e., the named container does not exist)
if [ -z "${CONTAINER_ID}" ]; then
    echo "ERROR: Could not find ${CONTAINER_NAME}!"
    exit 1
fi

# Introduce LOG_PATH variable. This improves code readability.
LOG_PATH=$(docker inspect --format='{{.LogPath}}' ${CONTAINER_NAME})
truncate -s 0 ${LOG_PATH}

# Echo on successful log truncation
echo "SUCCESS: Logs of ${CONTAINER_NAME} container have been cleared."
