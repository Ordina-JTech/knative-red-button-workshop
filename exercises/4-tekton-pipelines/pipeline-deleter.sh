#!/usr/bin/env bash

kubectl delete -f pipeline-definition.yaml
kubectl delete -f pipeline-run-definition.yaml
kubectl delete -f pipeline-service-account.yaml
echo "-- Pipeline CRDS (pipeline definition, pipeline runner and serviceaccount) removed for namespace: $KNATIVE_NAMESPACE"
