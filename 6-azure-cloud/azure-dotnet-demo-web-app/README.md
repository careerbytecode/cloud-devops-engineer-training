# azure-dotnet-demo-web-app
**Create Test Dot.Net App**

# Step1: Download and Install the .Net sdk 8 in your local  

```
https://dotnet.microsoft.com/download
```

# Step2: Create a directory code and run the below command on the code directory using the cmd

```
dotnet new mvc
```

now go to that directory and you will see the code has been created.

![image](https://github.com/user-attachments/assets/601978f4-dc07-4811-a29a-8bff6db97d6a)


# Step3: Run the below command to create the publish directory

```
dotnet publish -c Release -o ./publish
```

- Now see publish folder has been created.
- Copy all the above folder files including publish folder to new github repository

**Or you can use the below test app which already available in github**

https://github.com/cloudnloud/azure-dotnet-demo-web-app

now go to portal.azure.com --> go to your web app --> go to deployment center  --> deploy the demo app using the belw link.

https://github.com/cloudnloud/azure-dotnet-demo-web-app

now access webapp url and see application is working..
