## Introduction 

DaemonSets can improve the performance of a Kubernetes cluster by distributing maintenance tasks and support services via deploying Pods across all nodes. They are well suited for long-running services like monitoring or log collectio

- From cli run this command and ensure all nodess are ready state

```
kubectl get nodes
```

## 1. Create a namespace daemonset
```
kubectl create ns daemonset
```
## 2 .Create a nginux demonset
```
kubectl apply -f https://raw.githubusercontent.com/rangarajbk/cloud-devops-engineer-training/main/5-kubernetes_admin/5-Daemonset/daemonset-nginx.yaml -n daemonset
```

```
kubectl get all -n daemonset
```

- see now daemonset is 2 and running in each worker/client node.because daemonset is mandatory for each worker or client node.

```
watch -n 1 kubectl get all -n daemonset -o wide
```

- after executed the above command,now go to gcp cloud kubernetes console and add one more worker node in the existing cluster

- now you should have 3 workernode in the GKE cluster


- go to cli and run the below command

```
kubectl get nodes
```
- you  must see all nodes are ready state.you see now 3 worker noder running in the above command

- see now daemonset is 3 and running in each worker/client node.because daemonset is mandatory for each worker or client node.

```
watch -n 1 kubectl get all -n daemonset -o wide
```
```
kubectl delete ns daemonset
```
