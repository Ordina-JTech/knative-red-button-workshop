# Left or right? - KNative Routing

After your first deployment it won't be long before a new deployment to production is needed. But not every change is put live immediately. With KNative you can easily setup a staging deployment and incrementally migrate traffic from the old to the new deployment.  


## The first release

Routing is not yet implemented in the `kn` cli. We thus have to access the KNative API via `kubectl`. 

Create a file with the following content, and name it service.yaml. Fill in the blank fields. 

````
apiVersion: serving.knative.dev/v1alpha1
kind: Service
metadata:
  name: <--->
  namespace: <--->
spec:
  template:
    metadata:
      name: <--->
    spec:
      containers:
        - image: docker.io/knativeredbutton/game:latest
          env:
          - name: style
            value: <monochrome|vim|retro|custom>
````

Alter the script `deploy.sh` so that it now runs `kubectl apply -f service.yaml` in stead of using the `kn` command.
Then start the deployment. 

You have now setup the first revision of your application. 


## Staging the next release
For a final check you might want to put a next release live, without directly exposing it to the users. 

Try to deploy a new release without routing any traffic to it, by adding the following segment to your service definition. 
Make sure to change the 'style' environment variable, so you can differentiate between the releases from your browser. 
That way, you can identify which revision is handling your request.

````
...
spec:
  template:
  ....
  traffic:
  - tag: current
    revisionName: <-- name of first revision-->
    percent: <-- -->
  - tag: staged
    latestRevision: true
    percent: <-- -->
````

Use `kubectl` to get the url for the staged revision. 
`kubectl get route ${KNATIVE_SERVICE} --output jsonpath="{.status.traffic[*].url}"`

Check if it is up. Also verify that the styling is different from the previous release.



## Migrating traffic to the new release
Using the traffic segment of your service definition create a 50/50 split between the first and the second revision.

In your browser you should be able to get both revisions after a few requests.