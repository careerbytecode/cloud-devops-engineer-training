Pre-Requisities: 

You need to have basic idea on how to create custom docker image and how to push it to Docker Repository

Before Learn Azure Container Instance handson,learn the manual docker container hands on lab.

Class13

- Docker Hands-on Lab

https://youtu.be/qxHHPOYKDfQ


- Docker-Container-Manual-Lab-Commands-Guide

- https://github.com/cloudnloud/azure-training/tree/main/Class13-Docker-Container-Manual-Lab

********************************************************

Step 1 -  Configure AZURE CLI in any linux machine

- reference - https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=dnf#install-azure-cli
```
sudo dnf install -y https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm
```

```
sudo dnf install azure-cli
```

```
az login
```

Now your linux machine has been fully authenticated with AZURE login.


****************************************************************
Step 2 - first install docker in the local linux machine

```
 yum install epel-release -y
 yum repolist
```
#Add the stable Docker repository by typing:
```
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

#Now that we have Docker repository enabled, we can install the latest version of Docker CE (Community Edition) using yum by typing:
```
yum install docker-ce -y
```


#Once the Docker package is installed, we start the Docker daemon with:
```
systemctl start docker
```
#To verify that the Docker service is running type:
```
systemctl status docker
```
#Enable the Docker service to be automatically started at boot time:
```
systemctl enable docker
```
#At the time of the writing of this article, the current stable version of Docker is 18.03.1, we can check our Docker version by typing:
```
sudo gpasswd -a <username> docker
```

```
docker -v
```
```
docker info
```

********************************************************************************************************

Step 3 - Azure Container Registry

Creating an Azure Container Registry (ACR) Instance
```
az group list  | grep -i name --> to see what are all Azure resource Group List
```
Create resource group 
```
az group create --name dev-ranga-bb-app --location eastus
```

Create an Azure container registry under dev-ranga-bb-app RG group.
```
az acr create --resource-group dev-ranga-bb-app --name rangapublicrepo --sku Basic --admin-enabled true
```
```
az login
```


```
az acr login --name rangapublicrepo --resource-group dev-ranga-bb-app
```


```
docker images
```
now downloading the sample image microsoft repository

```
docker pull nginx
```

Prepare your downloaded sample image towards Microsoft Repository standards 

```
docker tag <your custom image> <ACRName>.azurecr.io/<imagenameofchoice>
```
now in the above command replace like this below

```
docker tag nginx rangapublicrepo.azurecr.io/nginx:v1.0
```

verify via docker images command

```
docker images
```

Push your customised Docker image which you created into ACR repository

```
docker push rangapublicrepo.azurecr.io/nginx:v1.0
```


now we have pushed to azure container repository.

goto azure console and go to azure container repository.


look for this repo and right click the 3 dots and click launch instance from there.Once launched paste that conatiner machine ip address and you will see the web application.
