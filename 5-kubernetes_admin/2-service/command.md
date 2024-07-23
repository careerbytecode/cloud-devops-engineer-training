
## 1. Create a load balancing service in facebook and twitter namespace using the yaml file

## 2. Create a load balancing service to test the kubernetes cluster

-- Goto Google cloud and create GKE Cluster Engine


```
kubectl apply -f https://raw.githubusercontent.com/rangarajbk/cloud-devops-engineer-training/main/5-kubernetes_admin/2-service/service/loadbalancer-facebook.yaml
```

```
kubectl get all -n facebook -o wide
```

- in the above command ur get public ip.copy that public ip and paste in your browser

```
kubectl delete -f https://raw.githubusercontent.com/rangarajbk/cloud-devops-engineer-training/main/5-kubernetes_admin/2-service/service/loadbalancer-facebook.yaml
```
