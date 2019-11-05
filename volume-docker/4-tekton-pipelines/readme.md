# Some handy commands to work on pipeline and secret objects

## Start pipelinerun
`kubectl apply -f <name-of-file.yaml>`

## Remove pipelinerun
`kubectl delete -f <name-of-file.yaml`

## Verify pipeline state
With this command it is possible to get status info about the running pipeline.
`kubectl describe pipelinerun <pipeline-name>` or `kubectl get pipelineruns/<pipeline-name> -o yaml`

## See pipeline resources
To see all resources created as part of Tekton pipelines, run:
`kubectl get tekton-pipelines`

## Get all secrets
`kubectl get secrets`

## Inspect secret data
`kubectl describe secrets/<secret-name>` - Gives you specific secret information.
`kubectl get secret <secret-name>` - Just like the above..
`kubectl get secret <secret-name> -o yaml` - Gives you secret information in YAML format

### Resources
The following resources where used to extract the needed information to build
and trigger a Tekton pipeline.

* https://medium.com/01001101/tekton-pipeline-kubernetes-native-pipelines-296478f5c835
* https://developer.ibm.com/tutorials/knative-build-app-development-with-tekton/
* https://github.com/tektoncd/pipeline/blob/master/docs/tutorial.md
* https://github.com/tektoncd/pipeline/blob/master/docs/auth.md
* https://github.com/tektoncd/pipeline/blob/master/docs/resources.md#image-resource
* https://github.com/tektoncd/pipeline/blob/master/examples/pipelineruns/pipelinerun.yaml
* https://github.com/fabric8io/kansible/blob/master/vendor/k8s.io/kubernetes/docs/user-guide/kubectl/kubectl_create_secret_docker-registry.md
* https://www.padok.fr/en/blog/kubernetes-secrets
* https://kubernetes.io/docs/concepts/configuration/secret/
