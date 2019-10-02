#!/usr/bin/env bash

kubectl delete -f pipeline-definition.yaml
echo "-- Pipeline CRDS (pipeline definition) removed for namespace: $KNATIVE_NAMESPACE"
