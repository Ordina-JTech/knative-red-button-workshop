#!/usr/bin/env bash

if [ -z "$KNATIVE_NAMESPACE" ]
then
  export KNATIVE_NAMESPACE=$1
fi

# install serviceaccount
kubectl delete -f pipeline-run-definition.yaml -n "${KNATIVE_NAMESPACE}"
echo "PipelineRun removed"
