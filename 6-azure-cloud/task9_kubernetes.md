Step 1: Go to azure CLI in portal.azure.com cloud console

```
az login
```




Step 2: check kubectl command is there or not ?

```
kubectl version --client
```

Step 3: From Azure CLI


- command to show which subscription is currently selected.

```
az account show
```
- If you need to select a different account, you can list all existing subscriptions by running:


```
az account list
```


- To check if these providers are currently registered, you can use the az provider list subcommand as seen below. This subcommand will query the providers and limit the registrationState to Registered.


```
az provider list --query "[?registrationState=='Registered'].{Name:namespace, State:registrationState}" -o table
```


```
az group list
```

- to see all azure region list

```
az account list-locations -o table
```

************************************************************

Step 4: AKS - Azure Kubernetes Cluster

Creating a Resource Group
```
az group create --name k8s-dev-environment --location eastus
```
```
az aks get-versions --location eastus -o table
```

- create kubernetes cluster in azure cloud with only 1 worker node


```
az aks create --resource-group k8s-dev-environment --name my-cluster --location eastus --node-count 1 --generate-ssh-keys
```

- download the k8s cluster keys


```
az aks get-credentials --resource-group k8s-dev-environment --name my-cluster
```
```
kubectl get nodes
```

```
kubectl cluster-info
```
(Deploying a Sample Application)

Download Sample Application

```
wget https://raw.githubusercontent.com/careerbytecode/cloud-devops-engineer-training/main/6-azure-cloud/azure-vote-all-in-one-redis.yaml
```


```
kubectl apply -f azure-vote-all-in-one-redis.yaml
```


Checking the Deployment Status

```
watch -n 2 kubectl get all
```


from this above command get the external public ip address and access it.Now you can see application deployed on top of cluster.

use this Public IP address in browser.Now you will see sample application which deployed on top of AKS cluster.


