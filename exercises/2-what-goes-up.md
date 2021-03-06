# What goes up... KNative Serving

During times of high load you want your applications to scale up without bothering you. KNative allows you to setup automatically scaling applications with ease.

In the previous exercise you have deployed a single application to the cluster. Now, we are going to use that application to simulate a heavily loaded system.

Using the `kn` command-line client, we will try to setup a deployment that automatically scales up to a maximum of three pods when under load.
When the load decreases, the pods should automatically scale down to zero.


## Generating load
When KNative registers to many concurrent open requests, it scales up the number of pods.
For this exercise we've added an endpoint that mimics a slow operation in your application.
Using the script [`generate-load.sh`](2-what-goes-up/generate-load.sh) you can call that endpoint with multiple concurrent requests.
Find the URL for your service using `kn` and modify the script accordingly.

First run `kubectl get pods` to get the current list of pods.
That will give you a list of pods that are currently active. Perhaps none, but at most one.

Run the `generate-load.sh`-script start making requests to the service.

If all went well, you see that two or three pods have been created.

In the monitoring tool the load will be visualized.
Checkout the 'Knative Serving - Scaling Debugging' dashboard. \
```
kubectl port-forward -n knative-monitoring --address 0.0.0.0 \
$(kubectl get pods -n knative-monitoring --selector=app=grafana --output=jsonpath="{.items..metadata.name}") \
3000
```
_Tip: if you want to open multiple bash terminals in your container you can attach to a container as often as you want by running `docker exec -it rb-button bash` or for Windows:`winpty docker.exe exec -it rb-button bash` in a new terminal window._


## Panic!
The Autoscaler implements a scaling algorithm with two modes of operation: Stable Mode and Panic Mode.
In Stable Mode the Autoscaler adjusts the size of the Deployment to achieve the desired average concurrency per Pod.
It calculates the observed concurrency per pod by averaging all data points over the 60 second window.

In addition to the 60-second window, it also keeps a 6-second window (the panic window).
If the 6-second average concurrency reaches 2 times the desired average, then the Autoscaler transitions into Panic Mode.

Modify the `generate-load.sh`-script to create a greater load on the system and force the Autoscaler to go into Panic Mode.

In our monitoring tool this peek will be visualized.
Checkout the 'Knative Serving - Scaling Debugging' dashboard.

