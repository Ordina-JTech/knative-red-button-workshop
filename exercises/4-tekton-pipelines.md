# Getting started with Tekton Pipelines
Now that you have learned what Tekton pipelines are and which components play a role, let's
start by playing with a simple Tekton Pipeline we created for you.

The pipeline contains a two step process that builds a Docker image and publishes it to a given
Docker registry. We have taken the burden of creating this pipeline for you but... we broke it
on purpose! We challenge you to have a look and try to fix the issue in the pipeline so that it
can publish images to the Docker registry again. Let's get started!

Before you start, make sure you are working on your own branch.

### 1. Open and view Pipeline contents
Let's start by opening the Tekton pipeline YAML file, do this using your favourite YAML editor.

* Open file `pipeline-definition.yaml`

Looking at it's contents it is important to verify that all the pieces needed in the pipeline are
available. We do this by inspecting the `kind` property of each resource, we should have the following
components:

* 2 Pipeline resource components (act as input and output components) - `kind: PipelineResource`
* 1 Pipeline definition containing one Task reference - `kind: Pipeline`
* Task definition containing one Step definition - `kind: Task`

For more information about Tekton Pipelines and it's build components, go to:
[Tekton Pipelines](https://github.com/tektoncd/pipeline/blob/master/docs/README.md)

Note that all components are separated by three dashes `---`, this makes it possible to combine several
build components in one file and apply them in Kubernetes(K8s).

### 2. Change/modify Pipeline definition
So, as we mentioned before the pipeline is broken. We need to make some changes to make it work.
Your changes should be committed on separate Git branch,
let's configure that in our pipeline.

1. Search for PipelineResource with name: `git-source-pr` and modify key/value param: `revision` to
contain value: `fill-in-your-branch-name`. This should match the branch name you will be working in;
2. Search for PipelineResource with name: `docker-image-pr` and modify key/value param: `url` to contain
value: `docker.io/knativeredbutton/<unique-docker-image-name>`. Change the placeholder to contain a unique
name for the application you will be serving/deploying;
3. Search for Pipeline resource with name: `build-and-deploy-pipeline` and rename it to something
unique (i.e. `bdp-team-ordina`);
4. Save changes and close the file;

### 3. Apply Pipeline changes
We can now apply the modified pipeline.

```sh
./pipeline-definition-installer.sh <participant-namespace>
```

### 4. Open and view Pipeline Runner contents
This file contains the Pipeline runner definition that will kick-start the pipeline process. A pipeline
runner is of kind: `PipelineRun`.

* Open file: `pipeline-run-definition.yaml`

Looking at this file we can see that it too contains a name, a reference to the pipeline we created and
the needed pipeline resources.

### 5. Change/modify Pipeline Runner definition
We need to make some changes so that we trigger the correct pipeline.

1. Change pipeline metadata, so that it's property `name` and `generateName` contain a unique value;
2. Make sure the property `name` from `pipelineRef` contains the pipeline name you used from previous step;
3. Save changes and close the file;

### 6. Apply Pipeline Runner changes & Kickstart Pipeline
When we apply the pipeline runner file in K8s it will also Kickstart the pipeline. So make sure that
all changes are set properly and apply the file:

```sh
./pipeline-starter.sh <participant-namespace>
```

### 7. Monitor Pipeline execution
With the following command's it is possible to get status info about the running pipeline(s):

```
kubectl describe pipelinerun <pipeline-name> -n <participant-namespace>
```
Or you can also use:
```
kubectl get pipelineruns/<pipeline-name> -n <participant-namespace> -o yaml
```

With the optional `--watch` property applied to the command makes it possible to monitor real-time
state changes, no need to trigger the same command multiple times.

Watch carefully as the pipeline runs, an error should be displayed containing failure information to act upon.

### 7a. Monitoring with Tekton Dashboard
The best way to visually see what your Tekton pipeline is doing is by making use of the
[Tekton Dashboard](https://github.com/tektoncd/dashboard). It provides users with a web-bases UI where you manage
and view PipelineRuns, TaskRuns and it's resources. So how to we access this Tekton dashboard?

From your command-line type the following:
```
kubectl -n tekton-pipelines port-forward svc/tekton-dashboard 9097:9097
```
You can now access the Tekton Dashboard at `http://localhost:9097`

Or... you can also access the Tekton dashboard by creating a proxy.

```
kubectl proxy
```

Now you can access the dashboard at http://localhost:8001/api/v1/namespaces/tekton-pipelines/services/tekton-dashboard:http/proxy/

### 8. Fix issue and restart Pipeline
Were you able to spot the issue?? good for you!, now let's do the following:

1. Make changes to your local personal Git branch, commit and push those changes;
2. Remove your previous pipelineRun;
```sh
./pipeline-deleter.sh <participant-namespace>
```
3. Restart pipelineRun again (see previous step) and monitor state changes;

If all goes well our pipelineRun status should be `status.conditions.type: Succeded`. If not try again
and repeat steps one to three until it works by making changes and monitoring the pipeline state.

### 9. Verify built image is available in Docker registry
If the pipeline run is successful then a fresh image should be available for deployment. Go to the Docker
registry at https://hub.docker.com/u/knativeredbutton and search your image. The image name your looking
for should match the name used in the PipelineResource `docker-image-pr`, should be something
like `http://docker.io/knativeredbutton/<image-name>`

### 10. Deploy docker image to the cluster
It's time to deploy our Docker image to the K8s cluster. You have done this in previous examples by
using pre-built bash scripts like `deploy.sh`, but this time we will run the command ourselves.

Don't forget to replace `<placholder>` information in the command. It should match with your configuration.
```
kn service create <knative-service> \
        --image docker.io/knativeredbutton/<image-name>:latest \
        --namespace <participant-namespace> \
        --env TARGET="hello"
```

### 11. Access deployed service
Time to check our service is deployed correctly! For this step we must open the `4_access_service_deployment\1.verify.sh`
script and modify the `service-name` and `participant-namespace` values to match with previous deployment.

After making those changes, fire up the script. If all went well the `CURL` command fired by the script
should be able to access the deployed service. If not, have a look at what went wrong in the output and
make sure your script input is correct.

# The Challenger!
Did you fly through the steps and was this too easy for you? Don't worry there is plenty to improve! how about
automating the deployment yourself? We challenge you to automate this process in your Pipeline by adding a new step.
