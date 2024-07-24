# Step1 Creation of VM and Docker installation

Create a Azure VM with the  ubuntu 22.04 image 

Docker Installation in UBUNTU

```
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io

sudo systemctl start docker

sudo systemctl enable docker

sudo gpasswd -a rangarajbk docker
```
# To check the docker information and Version
```
docker info
docker --version
```

********************************************************
# Step 2 Installation of AZ cli in the Vm

Get packages needed for the installation process:

```
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
```
Download and install the Microsoft signing key:

```
sudo mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
  gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg
```

Add the Azure CLI software repository:

```
AZ_DIST=$(lsb_release -cs)
echo "Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: ${AZ_DIST}
Components: main
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/microsoft.gpg" | sudo tee /etc/apt/sources.list.d/azure-cli.sources
```
Update repository information and install the azure-cli package:

```
sudo apt-get update
sudo apt-get install azure-cli
```

```
az login
```

for testing please issue the below command 

```
az group create --name DevResourceGroup --location eastus
```
********************************************************************************************************

# Step 3 - Azure Container Registry

- Creating an Azure Container Registry (ACR) Instance

- To see what are all Azure resource Group List

```
az group list  | grep -i name 
```

- Create resource group 

```
az group create --name dev-ranga-bb-app --location eastus
```

- Create an Azure container registry under dev-ranga-bb-app RG group

```
az acr create --resource-group dev-ranga-bb-app --name rangapublicrepo --sku Basic --admin-enabled true
```
- to login into the azure private repo(Azure container registry)

```
az acr login --name rangapublicrepo --resource-group dev-ranga-bb-app
```

- Command to check the images avaialable 

```
docker images
```

- now downloading the sample image microsoft repository

```
docker pull nginx
```

- Prepare your downloaded sample image towards Microsoft Repository standards 

```
docker tag <your custom image> <ACRName>.azurecr.io/<imagenameofchoice>
```

- now in the above command replace like this below

```
docker tag nginx rangapublicrepo.azurecr.io/nginx:v1.0
```

- verify via docker images command

```
docker images
```

- Push your customised Docker image which you created into ACR repository

```
docker push rangapublicrepo.azurecr.io/nginx:v1.0
```


now we have pushed to azure container repository.

goto azure console and go to azure container repository.


look for this repo and right click the 3 dots and click launch instance from there.Once launched paste that conatiner machine ip address and you will see the web application.
