#!/usr/bin/env bash
set -e

echo "Starting  at: $(date +"%T")"
echo "Fire docker command"
docker exec -d rb-button sh //volume-docker/deploy.sh

exit 0