#!/usr/bin/env bash

if [ -z "$NAMESPACE" ]
then
  export NAMESPACE=$1
fi

# install serviceaccount
kubectl apply -f pipeline-run-definition.yaml -n $NAMESPACE
echo "PipelineRun started. Use kubectl commands or Tekton Dashboard to view pipelineRun status"
