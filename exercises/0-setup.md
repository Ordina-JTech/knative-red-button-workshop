#Setup your environment

## Downloads
Install the following if not yet installed 
- git-bash (only for Windows users) https://gitforwindows.org/   
- Java Runtime Environment JRE https://java.com/en/download/manual.jsp or https://www.oracle.com/technetwork/java/javase/downloads/index.html
- Docker or Docker Desktop (for Windows)

## Connect the red button
First connect the red button with the usb-cable. After that make the button listen to button pushes by running the `button.sh`. This script should keep running during the whole workshop.

## Run Docker Image
To run our prebuilt image and connect it to one of the clouds one must execute the following command:
```
# CLOUD should be one of: azure, aws or gcloud
# The volume mapping points to a location containing the deployment script and the logging will be written there
docker run -it -e CLOUD="gcloud" --name rb-button -p 9097:9097 -p 3000:3000 -v "$(pwd)/volume-docker":/volume-docker red-button-bridge

# For Windows with GitBash you might instead need to run this command to start the docker container
winpty docker.exe run -it -e CLOUD="gcloud" --name rb-button -p 9097:9097 -p 3000:3000 -v /$(pwd)/volume-docker:/volume-docker red-button-bridge
```
In this container you will execute all the kubectl and kn commands.

## Setup your environment variables in the deploy script
In the shell-script 'deploy' at the start you will find the following two environment variables. These will be used throughout the workshop to provide some consistency and separation of deployments. 

KNATIVE_NAMESPACE - can be any cluser-unique value, you can use your name e.g. \
KNATIVE_SERVICE - the name you want to give your application

## Create a namespace in Kubernetes
During this workshop you will be sharing a Kubernetes cluster. To  separate your work with that of the other participants we will setup a namespace you can use. 

Use the commands below to create your namespace.

```
kubectl create ns <your namespace which you filled in in the deploy script>
```

## Verify your setup
Running 'kubectl get namespaces' should include yours
Running 'kubectl get pods -n <your namespace>' should output nothing.
Running 'kubectl get pods --all-namespaces' should return a list of pods