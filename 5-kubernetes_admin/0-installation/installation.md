# Kubernetes installation in ubuntu

- Step 1: Create k8s cluster in 3 node lab setup (1 master & 2 worker node)
- **create ubuntu 18.0 LTS machines like below**

- Server --> 2 CPU, 4GB RAM
- node1 --> 2 CPU, 4GB RAM
- node2 --> 2 CPU, 4GB RAM


- Server is going to be the kubenetes master
- node1,node2 going to be Worker nodes

- in all the nodes run the following command



- **Install Docker Engine (run all the nodes)**
---------------------

```
apt-get update && apt-get install -y apt-transport-https curl
```

```
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
```
```
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
```
```
apt-get update
```
```
apt-get install -y kubelet kubeadm kubectl 
```

```
apt-mark hold kubelet kubeadm kubectl 
```


# Install Docker packages (run all the nodes)

```
sudo apt-get remove docker docker-engine docker.io containerd runc
```

```
sudo apt-get update
```

```
sudo apt-get install     ca-certificates     curl     gnupg     lsb-release
```

```
sudo mkdir -p /etc/apt/keyrings
```

```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```
```
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

```
sudo apt-get update
```

```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```



```
mkdir -p /etc/systemd/system/docker.service.d
```

```
systemctl daemon-reload
systemctl restart docker
systemctl enable docker
```

```
docker -v
```


```
rm /etc/containerd/config.toml
systemctl restart containerd
````


*********************************************************************************
run this below command in only Server (Master node).coz we are going to make master machine as kube master

```
kubeadm init --apiserver-advertise-address $(hostname -i) --pod-network-cidr=192.168.0.0/16
```

- you get the below in you output also from above command.

```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
export kubever=$(kubectl version | base64 | tr -d '\n')
```

- https://www.weave.works/docs/net/latest/kubernetes/kube-addon/ (kube proxy addons installation)

```

kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
```

- verify:

```
kubectl get nodes
````


- now from node1 and node2 join to the k8s cluster 

```
kubectl get nodes 
```

- (this command output must show all nodes are ready status)

**********************************************************************************************

```
watch -n 1 kubectl get nodes
```
