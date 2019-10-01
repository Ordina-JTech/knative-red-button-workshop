#!/usr/bin/env bash

## To be changed by participant
export KNATIVE_CLOUD="aws"
export KNATIVE_NAMESPACE="tijmen"
export KNATIVE_SERVICE="hello-tijmen-game2"


# Setup cloud configuration
export WORKSPACE=`pwd`
export KUBECONFIG=${WORKSPACE}/configurations/${KNATIVE_CLOUD}/config.yaml
echo "KUBECONFIG has been set to: $KUBECONFIG"
if [[ ! -f "${KUBECONFIG}" ]]; then
    echo "Configuration for kubectl not found. Please check your script."
    return
fi
kubectl config set-context --current --namespace=${KNATIVE_NAMESPACE}

# Setup CLI's
source <(kubectl completion bash)
source <(kn completion)

# Aliasses
alias knmonitor='kubectl port-forward --namespace knative-monitoring $(kubectl get pods --namespace knative-monitoring --selector=app=grafana --output=jsonpath="{.items..metadata.name}") 3000'
