# Step 1: Install dotnetsdk for dotnetcore 

https://dotnet.microsoft.com/download

# Step 2: Create a folder code in your local and run the below command in that directory using cmd
```
mkdir code 
dotnet new mvc
```
now go to that directory and you will see the code has been created.

wait till the azure required assets to build and debug are missing (popup sand say yes)


Step 3:  now run the following command

dotnet publish -c Release -o ./publish

now see publish folder has been created.



copy all the above folder files including publish folder to new github repository


now go to portal.azure.com --> go to your web app --> go to deployment center  --> deploy the demo app using the belw link.

https://github.com/cloudnloud/azure-dotnet-demo-web-app

now access webapp url and see application is working..
