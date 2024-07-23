
### Prerequisite
- Kubernetes Cluster up and running with master and node or GKE or EKS or any other type of k8s setup.
- Here we are using GCP as a cloud provider for LoadBalancer Service. In case if you do not want to use LoadBalancer you can skip the steps.


## 1. Deploy the first application 

- deploy hello-kubernetes-first.yaml

```
kubectl apply -f https://raw.githubusercontent.com/rangarajbk/cloud-devops-engineer-training/main/5-kubernetes_admin/7-ingress/hello-kubernetes-first.yaml
```

```
kubectl get all -o wide
```

- You’ll find that the newly created Service has a ClusterIP assigned, which means that it is working properly. All traffic sent to it will be forwarded to the selected Deployment on port 8080. Now that you have deployed the first variant of the hello-kubernetes app, you’ll work on the second one.

## 2. Deploy the Second application 
- deploy hello-kubernetes-second.yaml

```
kubectl apply -f https://raw.githubusercontent.com/rangarajbk/cloud-devops-engineer-training/main/5-kubernetes_admin/7-ingress/hello-kubernetes-second.yaml 
```

```
kubectl get all -o wide 
```

## 3. Install  the ingress controller 

 - Installing the Kubernetes Nginx Ingress Controller
 
 - To install the Nginx Ingress Controller to your cluster, you’ll first need to add its repository to Helm by running:

```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
```

- Update to let Helm know what it contains:

```
helm repo update
```


- Finally, run the following command to install the Nginx ingress:

```
helm install nginx-ingress ingress-nginx/ingress-nginx --set controller.publishService.enabled=true
```

- This command installs the Nginx Ingress Controller from the stable charts repository, names the Helm release nginx-ingress, and sets the publishService parameter to true.


- You can watch the Load Balancer become available by running:

```
kubectl --namespace default get services -o wide -w nginx-ingress-ingress-nginx-controller
```

- now if you access external public ip you get not found mssage or error.
********************************************************************************************************

Exposing the App Using an Ingress
```
kubectl apply -f https://raw.githubusercontent.com/rangarajbk/cloud-devops-engineer-training/main/5-kubernetes_admin/7-ingress/hello-kubernetes-ingress.yaml
```
You define an Ingress Resource with the name hello-kubernetes-ingress. Then, you specify two host rules, so that hw1.your_domain is routed to the hello-kubernetes-first Service, and hw2.your_domain is routed to the Service from the second deployment (hello-kubernetes-second).

```
kubectl get all -o wide
```

## 4. Testing the ingress controller 

- note external ip 
- now if u access external ip address from browser you still get not found error

- now in your windows laptop go to C:\Windows\System32\drivers\etc directory and open hosts file in ur notepad ++ and add your external ip like below 
```
34.69.167.205	www.example.com
34.69.167.205	hw1.example.com
34.69.167.205	hw2.example.com
```

- in the above replace your external ip from kubectl get all -o wide command output


- after saved the entry in host fileaccess below domain name in browser

```
hw1.example.com
```

```
hw2.example.com
```

