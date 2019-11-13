#Setup your environment

## Downloads
Install the following if not yet installed 
- git-bash (only for Windows users) https://gitforwindows.org/   
- Java Runtime Environment JRE https://java.com/en/download/manual.jsp or https://www.oracle.com/technetwork/java/javase/downloads/index.html
- Docker (Desktop) https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe or https://docs.docker.com/docker-for-windows/release-notes/

## Connect the red button
First connect the red button with the usb-cable. After that make the button listen to button pushes by running the `button.sh` (in GitBash). This script should keep running during the whole workshop.

## Load Docker Image
We have build our own Docker image in order to let you access the clouds without that you need to install all kinds of CLI's. We first need to load the red-button-bridge.tgz zip file. You can find this file in the 'docker-image' directory. \
Now load the image into Docker with the following command:
```
docker load < red-button-bridge.tgz
``` 

## Run Docker Image
_Note: Windows users should share their C-drive (or D-drive if this repo is pulled to there) in Docker Desktop (use settings menu in Docker)._

To run our prebuilt image and connect it to one of the clouds one must execute the following command while being located in the root directory of this repository:
```
# CLOUD should be one of: azure, aws or gcloud
# The volume mapping points to the folder 'volume-docker' containing the deployment script and the logging will be written there
docker run -it -e CLOUD="<choose>" --name rb-button -p 9097:9097 -p 3000:3000 -v "$(pwd)/volume-docker":/volume-docker red-button-bridge

# For Windows with GitBash you might instead need to run this command to start the docker container
winpty docker.exe run -it -e CLOUD="<choose>" --name rb-button -p 9097:9097 -p 3000:3000 -v /$(pwd)/volume-docker:/volume-docker red-button-bridge
```
In this container you will execute all the kubectl and kn commands. This container should keep running during the whole workshop.

## Setup your environment variables in the deploy script
In the shell-script 'deploy' you will find the following two environment variables. These will be used throughout the workshop to provide some consistency and separation of deployments. 

KNATIVE_NAMESPACE - can be any cluser-unique value, you can use your name e.g. \
KNATIVE_SERVICE - the name you want to give your application

## Create a namespace in Kubernetes
During this workshop we all will use the same Kubernetes cluster. To  separate your work with that of the other participants we will setup a namespace you should use. 

Use the commands below to create your namespace.

```
kubectl create ns <your namespace which you filled in in the deploy script>
```

## Verify your setup
Running `kubectl get nodes` should show the Kubernetes nodes, the names of the nodes might also indicate on which cloud you are working \
Running `kubectl get namespaces` should include yours \
Running `kubectl get pods -n <your namespace>` should output nothing for now \
Running `kubectl get pods --all-namespaces` should return a list of pods