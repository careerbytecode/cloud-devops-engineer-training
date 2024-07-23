## To get the list of namespace avaialable
```
kubectl get ns
```
- see below all the deault name spaces created initially as part any kubernets cluster creation
```
rangarajbk_db@cloudshell:~$ kubectl get ns
NAME                 STATUS   AGE
default              Active   5h14m
gke-managed-system   Active   5h13m
gmp-public           Active   5h13m
gmp-system           Active   5h13m
kube-node-lease      Active   5h14m
kube-public          Active   5h14m
kube-system          Active   5h14m
```


- to see detailed information in default namespace .(dont delete default name space )
```
kubectl get all -n default
`````
- to see detailed information in kube-system namespace .(dont delete name space )
`````
kubectl get all -n kube-system
`````

- to see the same output in detailed manner with which host it is running.

`````
kubectl get all -n kube-system -o wide
`````
*******************************************************************************
## 1.Create namespace

- kubectl create ns <namespace name>
`````
kubectl create ns azure
`````
- to see the newly created namespace

```
kubectl get ns
```


`````
kubectl apply -f https://raw.githubusercontent.com/rangarajbk/cloud-devops-engineer-training/main/5-kubernetes_admin/1-namespace-Pod/namespace/namespace.yaml
`````
- to delete the namespace which created previously using namespace.yaml file
  
`````
kubectl delete -f https://raw.githubusercontent.com/rangarajbk/cloud-devops-engineer-training/main/5-kubernetes_admin/1-namespace-Pod/namespace/namespace.yaml
`````
*********************************************************************************
## 2.Create single pod using yaml file


`````
kubectl create ns twitter
`````
- to create a pod using 1-singlepod.yaml file
  
`````
kubectl apply -f https://raw.githubusercontent.com/rangarajbk/cloud-devops-engineer-training/main/5-kubernetes_admin/1-namespace-Pod/pod/1-singlepod.yml
`````


```
kubectl get all -n twitter
```


`````
kubectl get all -n twitter -l app=nginx
`````
`````
kubectl get all -n twitter -l version=v1
`````

- now nginx container is running in webserver pod.now we need to login in this container.
- this pod is running in twitter namespace
  
`````
kubectl exec -it pod/webserver bash -n twitter
`````

- now you need to understand that lablels will help you to create exact report and find the particular resources
  
`````
kubectl delete -f https://raw.githubusercontent.com/rangarajbk/cloud-devops-engineer-training/main/5-kubernetes_admin/1-namespace-Pod/pod/1-singlepod.yml
`````

************************************************************************************************
## 3.Create Multiple pod using yaml file
```
kubectl apply -f https://raw.githubusercontent.com/rangarajbk/cloud-devops-engineer-training/main/5-kubernetes_admin/1-namespace-Pod/pod/2-multipods.yml
```
- to see all resources in facebook namespace
```
kubectl get all -n facebook
```

```
kubectl get all -n facebook -l app=httpd
```
- to see detailed information on facebook namepsace
  
`````
kubectl describe pod/multicontainer-pods -n facebook
`````
`````
kubectl exec -it pod/multicontainer-pods bash -n facebook
`````
-
`````
kubectl exec -it pod/multicontainer-pods bash -n facebook -c web
`````
`````
kubectl exec -it pod/multicontainer-pods bash -n facebook -c db
`````
`````
kubectl delete -f https://raw.githubusercontent.com/rangarajbk/cloud-devops-engineer-training/main/5-kubernetes_admin/1-namespace-Pod/pod/2-multipods.yml
`````
************************************************************************************************************************************
## 4.Create duplicate port in pod using yaml file
- now we are going to create 1 pod and 2 container in facebook namespace

`````
kubectl apply -f https://raw.githubusercontent.com/rangarajbk/cloud-devops-engineer-training/main/5-kubernetes_admin/1-namespace-Pod/pod/2.1-duplicate-port-multipod.yaml
`````

-- same port it wont work.how to see ?
`````
kubectl get all -n facebook -l app=httpd
`````

- now u see error in the above command.which means 1 container is running in port 80.other container is having issues beacsue the other container also port 80.
  
`````
kubectl describe pod/multicontainer-pods -n facebook
`````
-- in this only one container will run another one will give you error
`````
kubectl logs pod/multicontainer-pods -n facebook -c httpd1
`````
`````
kubectl logs pod/multicontainer-pods -n facebook -c httpd2
`````
`````
kubectl delete -f https://raw.githubusercontent.com/rangarajbk/cloud-devops-engineer-training/main/5-kubernetes_admin/1-namespace-Pod/pod/2.1-duplicate-port-multipod.yaml
`````
***********************************************************************************************************************************

## 5. create pod with 2 containers

find out the below yaml file is deployed to which name space
`````
kubectl apply -f https://raw.githubusercontent.com/rangarajbk/cloud-devops-engineer-training/main/5-kubernetes_admin/1-namespace-Pod/pod/6-example.yml -n facebook
`````
`````
kubectl get all -n facebook
`````
`````
kubectl get pod/first-pod -n facebook
`````
`````
kubectl describe pod first-pod -n facebook
`````
`````
kubectl delete -f https://raw.githubusercontent.com/rangarajbk/cloud-devops-engineer-training/main/5-kubernetes_admin/1-namespace-Pod/pod/6-example.yml -n facebook
`````
********************************************************************************************
## 6. Deleting the namespace and pod 


`````
kubectl get ns
`````

- warning : if u delete namespace  means it will delete all resources in that namespace


`````
kubectl delete ns facebook twitter azure
`````

```
kubectl get ns
```
