## Introduction 

A Pod can have multiple containers running apps within it, but it can also have one or more init containers, which are run before the app containers are started.

Init containers are exactly like regular containers, except:

Init containers always run to completion.
Each init container must complete successfully before the next one starts.

```
kubectl get nodes
```

- the above command output should show all nodes are ready state.


## 1 . Create a namespace app1

- create new namespace called app1

```
kubectl create ns app1
```
## 2 . Create a node server
```
kubectl apply -f https://raw.githubusercontent.com/rangarajbk/cloud-devops-engineer-training/main/5-kubernetes_admin/6-initcontainers/node-redis/node.yml -n app1
```

- first deploy above yaml file and run below command

```
kubectl get all -n app1 -o wide
```

- you will see init is waiting.coz the dependency is not yet launched or stopped

## 3 . Create a Redis database  

```
kubectl apply -f https://raw.githubusercontent.com/rangarajbk/cloud-devops-engineer-training/main/5-kubernetes_admin/6-initcontainers/node-redis/redis.yml -n app1
```

- now immdietly riun below command

## 4 . Testing the init containers 

```
kubectl get all -n app1 -o wide
```

- you will see now running state

```
kubectl delete ns app1
```
