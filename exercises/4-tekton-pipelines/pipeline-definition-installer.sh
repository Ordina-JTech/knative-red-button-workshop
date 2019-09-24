#!/usr/bin/env bash

if [ -z "$NAMESPACE" ]
then
  export NAMESPACE=$1
fi

kubectl apply -f pipeline-definition.yaml -n $NAMESPACE
echo "Pipeline definition installed"
