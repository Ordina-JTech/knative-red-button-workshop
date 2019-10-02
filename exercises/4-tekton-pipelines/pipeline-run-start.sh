#!/usr/bin/env bash

kubectl apply -f pipeline-run-definition.yaml
echo "-- PipelineRun started for namespace: $KNATIVE_NAMESPACE"
echo "-- Use kubectl commands or Tekton Dashboard to view pipelineRun status"
