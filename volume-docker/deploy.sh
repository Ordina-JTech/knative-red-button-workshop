#!/usr/bin/env bash
set -e
export LOG_FILE=/volume-docker/output-deploy-script.log
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>${LOG_FILE} 2>&1

## To be changed by participant
export KNATIVE_NAMESPACE=""
export KNATIVE_SERVICE=""
export DOCKER_IMAGE=""
export STYLE="monochrome"

echo '===================='
echo 'Set namespace to your namespace...'
kubectl config set-context --current --namespace=${KNATIVE_NAMESPACE}

echo
echo '===================='
echo 'Verifying namespace...'
kubectl get namespace ${KNATIVE_NAMESPACE} --no-headers=true

echo
echo '===================='
echo "Starting deployment at: $(date +"%T")"
echo 'Running deployment...'

# Here the magic happens
kn service create ${KNATIVE_SERVICE} --namespace ${KNATIVE_NAMESPACE} --image ${DOCKER_IMAGE} --env STYLE=${STYLE}

echo
echo '===================='
echo "Finished deployment at: $(date +"%T")"
echo
echo '===================='
echo 'List of services currently deployed:'
kn service list

echo
echo '===================='
echo 'Pods currently active:'
kubectl get pods -n ${KNATIVE_NAMESPACE}
echo
echo '===================='

exit 0