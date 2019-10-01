#!/usr/bin/env bash
set -e

echo "Starting deployment at: $(date +"%T")"

echo
echo '===================='
echo 'Setting up environment...'
#source environment.sh

echo
echo '===================='
echo 'Verifying namespace...'
kubectl get namespace ${KNATIVE_NAMESPACE} --no-headers=true

echo
echo '===================='
echo 'Running deployment...'

kn service create --help

echo
echo '===================='
echo "Finished deployment at: $(date +"%T")"
echo
echo '===================='
echo 'List of services currently deployed:'
kn service list

echo
echo '===================='
echo 'List of services currently deployed:'
kubectl get pods -n ${KNATIVE_NAMESPACE}
echo
echo '===================='
exit 0
