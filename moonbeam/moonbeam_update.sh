#!/bin/bash

export UID=${UID}
export GID=${GID}
export NODE_NAME="NannyNode"

docker-compose down
docker-compose pull
docker-compose up -d
