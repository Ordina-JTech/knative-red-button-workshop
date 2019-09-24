#Setup your environment

## Downloads
Install the following if not yet installed 
- git-bash (only for Windows users) https://gitforwindows.org/   
- Java Runtime Environment JRE https://java.com/en/download/manual.jsp or https://www.oracle.com/technetwork/java/javase/downloads/index.html


## Add CLI's to your path
During the workshop we rely heavily on the CLI's kubectl (for Kubernetes) and kn (for KNative).
To save you some time, we've included those in this Git-repository. You can find them in the `clis`-directory.

## Setup your environment script
In the shell-script 'environment' you will find the following three environment variables. These will be used throughout the workshop to provide some consistency and separation of deployments. 

KNATIVE_CLOUD - can be either "azure" or "aws"
KNATIVE_NAMESPACE - can be any cluser-unique value
KNATIVE_SERVICE - the name you want to give your application

## Create a namespace in Kubernetes
During this workshop you will be sharing a Kubernetes cluster. To  separate your work with that of the other participants we will setup a namespace you can use. 

Use the commands below to create your namespace.

```
kubectl create ns ${KNATIVE_NAMESPACE}
```

## Setup your envirionment in your console
In bash run `"source environment.sh"`.
If all is setup correctly, this will output the following.

```
KUBECONFIG has been set to: /....../configurations/...../config.yaml
Context "...." modified.
```

## Verify your setup
Running 'kubectl get namespaces' should include yours
Running 'kubectl get pods' should output nothing.
Running 'kubectl get pods --all-namespaces' should return a list of pods