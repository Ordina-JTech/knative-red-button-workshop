#!/usr/bin/env bash

kubectl delete -f pipeline-definition.yaml --namespace "$1"
kubectl delete -f pipeline-run-definition.yaml --namespace "$1"
kubectl delete -f pipeline-service-account.yaml --namespace "$1"
echo "-- Pipeline CRDS (pipeline definition, pipeline runner and serviceaccount) removed for namespace: $1"
