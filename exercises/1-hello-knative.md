# Hello KNative
## Goal of the exercise
In this exercise you will learn to deploy a simple application to a remote cloud, using KNative. You will get familiar with the Kubernetes CLI and the KNative CLI.
Each deployment will be started with the push of a button.

### Deploy your application
We've already created a docker image for you. You can find this image at
`docker.io/knativeredbutton/game:latest`.

*_Note: you don't need to download this image, you'll use the string later on._*

Using the button, you will try to deploy that application to the cloud. Do not forget to give your service a name and deploy it in your own namespace.

Alter the deployment-script (deploy.sh in volume-docker folder), so that it performs the deployment when pushing the button...

*_Note: the output of deploy.sh is written to the file output-deploy-script.log which you can find after running the deploy.sh script in the volume-docker folder as well._*

When you push the button a deployment should be triggered and you will end up with a running service.
The final output shows a service with status `3 OK / 3` and a running pod.
It also prints the URL where you can access your application.

It should look like this.
```
Finished deployment at: 12:00:00

====================
List of services currently deployed:
NAME            URL                                             GENERATION   AGE    CONDITIONS   READY   REASON
<service>       http://<service>.<namespace>.52.148.255.5.sslip.io   1       3h5m   3 OK / 3     True

====================
List of services currently deployed:
NAME                                                 READY   STATUS    RESTARTS   AGE
<service>-<revisionname>-deployment-66d745fc5-7sf89  2/2     Running   0          3h5m
```

Try the URL to see if your application is up and running.

Congratulations, you've done your first KNative deployment!

_Note for GitBash users: if nothing happens although there is a success message shown, please check the EOL-type used in the deploy.sh script, this should be Unix style (LF) and not Windows style (CR LF) (you can convert this with Notepad++ for example)_


### Hi there!
Now lets meet KNative.

KNative is installed onto your Kubernetes cluster as a set of pods. The pods are deployed in a few namespaces, separating the pods into the three main pillars of KNative.

Run `kubectl get namespaces` to list all namespaces.

Run `kubectl get pods -n <namespace>` to list all pods within these namespaces.


KNative comes out-of-the-box with monitoring tooling. To access that tooling run the command below and navigate to the [KNative dashboard](http://localhost:3000).

```
kubectl port-forward --namespace knative-monitoring --address 0.0.0.0 \
$(kubectl get pods --namespace knative-monitoring --selector=app=grafana --output=jsonpath="{.items..metadata.name}") \
3000
```
See if you can find your namespace, pod and http-traffic.
