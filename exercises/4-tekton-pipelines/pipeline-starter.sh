#!/usr/bin/env bash

kubectl apply -f pipeline-run-definition.yaml --namespace "$1"
echo "-- PipelineRun started for namespace: $1"
echo "-- Use kubectl commands or Tekton Dashboard to view pipelineRun status"
