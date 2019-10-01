#!/usr/bin/env bash

if [ -z "$KNATIVE_NAMESPACE" ]
then
  export KNATIVE_NAMESPACE=$1
fi

kubectl apply -f pipeline-definition.yaml -n "$KNATIVE_NAMESPACE"
echo "Pipeline definition installed for namespace: $KNATIVE_NAMESPACE"
