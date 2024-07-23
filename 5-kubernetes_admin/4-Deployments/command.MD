# Introduction 
In this exercise we are going to install 3 versions of the nginux and restore them whenver required 

## 1. Get the 3 active versions of nginx in docker hub 

- go to hub.docker.com - https://hub.docker.com/_/nginx ...get some 3 nginx tag version

```
1.27.0-alpine
1.27
1.26.1

which means

nginx:1.27.0-alpine
nginx:1.27
nginx:1.26.1
```

## 2. Create a namespace facebook
```
kubectl create ns facebook
```

## 3. Deploy the nginx:1.27.0-alpine
```
wget https://raw.githubusercontent.com/careerbytecode/cloud-devops-engineer-training/main/5-kubernetes_admin/4-Deployments/deployments/1-deployment-facebook.yaml
```
```
kubectl apply -f 1-deployment-facebook.yaml
```

```
kubectl get all -n facebook -o wide
```


- check the current image version --> 1.27.0-alpine
- below command will initiailise the deployment mode

```
kubectl rollout status deployment/nginx -n facebook
```

## 4 . Increase the replica to 12

- below command will create 12 replicas which means 12 pod replicas
```
kubectl scale deployment/nginx --replicas=12 -n facebook --> to increase your replicas
```

- after executed above 12 replicas command run the below coammnd.you will now see 12 pod replicas has been created.
```
kubectl get all -n facebook -o wide
```

## 5 . Editing the configuration in realtime 

- the same above increasing no oif replica using command we can also achive directly via editing the config file.However below step is not at all recommended.

kubectl edit deployment.apps/nginx -n facebook --> go and increase replicas count and save >--- then immedietly run the below command

- below command will initiailise the deployment mode
```
kubectl rollout status deployment/nginx -n facebook
```

## 6 . Changing the nginux version to 1.27

- now inthe config yaml and change the nginix version.now change the nginx version to 1.27 in yaml file and apply

```
kubectl apply -f 1-deployment-facebook.yaml -n facebook
```

```
kubectl get all -n facebook -o wide
```

- now in the above command you will see nginx version 1.27

- below command will initiailise the deployment mode

```
kubectl rollout status deployment/nginx -n facebook
```

## 7 . Changing the nginux version to 1.26.1

- now inthe config yaml and change the nginix version.now change the nginx version to 1.26.1 in yaml file and apply

```
kubectl apply -f 1-deployment-facebook.yaml -n facebook
```

```
kubectl get all -n facebook -o wide
```

- now in the above command you will see nginx version 1.26.1

- below command will initiailise the deployment mode

```
kubectl rollout status deployment/nginx -n facebook
```


- below command will list the order of nnginx version stored as part deployments
```
kubectl rollout history deploy/nginx -n facebook
```

## 8 . Changing the nginux version to 1.27.0-alpine

```
kubectl rollout undo deployment nginx --to-revision=1 -n facebook --> from 3rd version to first version we can go........
```

- below command will list the order of nnginx version stored as part deployments
```
kubectl rollout history deploy/nginx -n facebook
```


to see the status now --> kubectl rollout status deploy/nginx -n facebook

```
kubectl delete ns facebook
```
