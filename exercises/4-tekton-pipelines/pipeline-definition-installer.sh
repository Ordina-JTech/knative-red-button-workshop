#!/usr/bin/env bash

kubectl apply -f pipeline-definition.yaml
kubectl apply -f pipeline-service-account.yaml
echo "-- Pipeline definition installed for namespace: $KNATIVE_NAMESPACE"
