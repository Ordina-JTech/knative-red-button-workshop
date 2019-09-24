#!/usr/bin/env bash

if [ -z "$NAMESPACE" ]
then
  export NAMESPACE=$1
fi

# install serviceaccount
kubectl delete -f pipeline-run-definition.yaml -n ${NAMESPACE}
echo "PipelineRun removed"
