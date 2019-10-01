#!/usr/bin/env bash

if [ -z "$KNATIVE_NAMESPACE" ]
then
  export KNATIVE_NAMESPACE=$1
fi

# install serviceaccount
kubectl apply -f pipeline-run-definition.yaml -n "$KNATIVE_NAMESPACE"
echo "PipelineRun started. Use kubectl commands or Tekton Dashboard to view pipelineRun status"
