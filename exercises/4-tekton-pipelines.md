# Getting started with Tekton Pipelines
Now that you have learned what Tekton pipelines are and which components play a role, let's
start by playing with a simple Tekton Pipeline we created for you.

The pipeline contains a two step process that builds a Docker image and publishes it to a given
Docker registry. 

All resources for this exercise can be found in the folder `4-tekton-pipelines`. 
If at any time you need more insight into the components used, you can take a look at the online [documentation](https://github.com/tektoncd/pipeline/blob/master/docs/README.md). 


### Checkout the pipeline!
Let's start by opening the Tekton pipeline definition.  
Please take a moment to inspect all elements of this pipeline. 

`Pipeline` - the 'parent component'; orchestrates one or more tasks \
`Task` - a series of steps that are executed in a single pod \
`PipelineResource` - one or more objects that can be used as input or output of a Task \
`Secret` - a username and password, stored securely on the Kubernetes cluster \
`ServiceAccount` - links an account (or secret) to a pipeline-resource; allows login to e.g. DockerHub

Of each type of resource we have one definition, with the exception of PipelineResources.
PipelineResources are used to define both input and output parameters for a Pipeline.
As you might have noticed we have defined a Git PipelineResource and a Docker PipelineResource, to be used as input and output respectively.    


### The pipeline run
Where a Pipeline defines the generic structure of a Tekton build process, a PipelineRun fills in the blanks.
Take a look at the PipelineRun-definition.

We have setup a PipelineRun, but without many of the fields. 
Using what you have seen in the Pipeline definition, complete this file. 


### Modify the deploymentscript
Add the following snippet as the deployment-part of deploy.sh...
```
echo "Setting up pipeline"
kubectl apply -f /volume-docker/4-tekton-pipelines/pipeline.yaml

echo "Run pipeline"
PIPELINE_RUN=`kubectl create -f /volume-docker/4-tekton-pipelines/pipeline-run.yaml | cut -d' ' -f1`

echo "Wait for pipeline to finish"
kubectl wait ${PIPELINE_RUN} --for=condition=Succeeded --timeout=180s

echo "Deploy the application to the cloud"
#kn service create -f <-- ? -->
```

You might have noticed that de deployment line is commented out. For now that is ok.

Lets start the deployment and see if we can build a new Docker container at the push of a button.  

To verify that your pipeline ran successfully and delivered the proper image, checkout DockerHub:
https://hub.docker.com/r/knativeredbutton/knative-red-button-app/tags 

If all went well, a Docker-image tagged with your namespace can be found here.


### Monitor Pipeline execution
Using standard Kubernetes CLI commands it is possible to get information about a running pipeline:
```
kubectl get pipelineruns
kubectl describe pipelinerun <pipeline-name>
``` 
For more detailed information you can also use: `kubectl get pipelineruns/<pipeline-name> -o yaml`

The best way to visually see what your Tekton pipeline is doing is by making use of the
[Tekton Dashboard](https://github.com/tektoncd/dashboard). It provides a web-based UI, where you manage
and view PipelineRuns, TaskRuns and PipelineResources. 

From your command-line type the following:
```
kubectl port-forward -n tekton-pipelines --address 0.0.0.0 svc/tekton-dashboard 9097:9097 
```
You can now access the Tekton Dashboard at `http://localhost:9097`


### Deploy the application
As per previous assignments, try to complete the deployment script by using the `kn`-CLI. 

