## 1.Create a single replica set 

```
kubectl apply -f https://raw.githubusercontent.com/rangarajbk/cloud-devops-engineer-training/main/5-kubernetes_admin/3-replicaset/replicaset/1-singlereplica.yml
```
```
kubectl get all -n twitter
```
```
kubectl describe all -n twitter
```
```
kubectl get pod,service,replicaset -n twitter -o wide
```

labels --> service -- selector , replica -- match ---> should be same
```
kubectl delete -f https://raw.githubusercontent.com/rangarajbk/cloud-devops-engineer-training/main/5-kubernetes_admin/3-replicaset/replicaset/1-singlereplica.yml
```
**************************************************************************************************************************************

## 2.Create a multiple replica set

```
kubectl apply -f https://raw.githubusercontent.com/rangarajbk/cloud-devops-engineer-training/main/5-kubernetes_admin/3-replicaset/replicaset/3-multireplica.yaml
```
```
kubectl get all -n facebook
```

```
kubectl delete -f https://raw.githubusercontent.com/rangarajbk/cloud-devops-engineer-training/main/5-kubernetes_admin/3-replicaset/replicaset/3-multireplica.yaml
```
