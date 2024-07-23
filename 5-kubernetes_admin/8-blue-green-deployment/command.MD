# Blue-Green Deployment

- why blue Green deployment ?
  - i have 2 version of application running.One is v1 and v2.V1 is already live.v2 is yet to live.Now as part of golive i want to bring v2 to operational.Blue green deployment will switch immedietly from v1 to v2 without any much impact.

## 1. Create a namespace bgdeploy
```
kubectl create ns bgdeploy
```

## 2. Deploy the blue application

- now we will deploy v1 application which blue
```
kubectl apply -f https://raw.githubusercontent.com/careerbytecode/cloud-devops-engineer-training/main/5-kubernetes_admin/8-blue-green-deployment/blue-deployment.yml -n bgdeploy
```

## 3. Deploy the green  application
- now we will deploy v2 application which green
```
kubectl apply -f https://raw.githubusercontent.com/careerbytecode/cloud-devops-engineer-training/main/5-kubernetes_admin/8-blue-green-deployment/green-deployment.yml -n bgdeploy

```

## 4. Deploy the blue application based on parameters 

- now i want to access from outside wordl v1 which blue.
```
wget https://raw.githubusercontent.com/careerbytecode/cloud-devops-engineer-training/main/5-kubernetes_admin/8-blue-green-deployment/blue-green-service.yml

```
- in the above file if app: blue is enabled then apply

```
kubectl apply -f blue-green-service.yml -n bgdeploy
```
- now access public ip from ur browser.take public ip from below command

```
kubectl get all -n bgdeploy
```
- now you will be able to access blue application

## 5. Deploy the green application based on parameters 

now i want to access from outside wordl v2 which green.

- in the below file if app: gree is enabled then apply

```
kubectl apply -f blue-green-service.yml -n bgdeploy
```

- now access public ip from ur browser.take public ip from below command

```
kubectl get all -n bgdeploy
```

- now you will be able to access green application

## 6. Delete the namespace bgdeploy
```
kubectl delete ns bgdeploy
```

