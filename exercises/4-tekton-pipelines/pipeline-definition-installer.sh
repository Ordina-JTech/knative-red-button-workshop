#!/usr/bin/env bash

kubectl apply -f pipeline-definition.yaml --namespace "$1"
kubectl apply -f pipeline-service-account.yaml --namespace "$1"
echo "-- Pipeline definition installed for namespace: $1"
