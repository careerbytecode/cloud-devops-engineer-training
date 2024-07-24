# azure-dotnet-demo-web-app
**Create Test Dot.Net App**

install dotnetsdk for dotnetcore 
https://dotnet.microsoft.com/download

go to one empty folder and run the following command

dotnet new mvc

now go to that directory and you will see the code has been created.

wait till the azure required assets to build and debug are missing (popup sand say yes)


now run the following command

dotnet publish -c Release -o ./publish

now see publish folder has been created.



copy all the above folder files including publish folder to new github repository

**Or you can use the below test app which already available in github**

https://github.com/cloudnloud/azure-dotnet-demo-web-app

now go to portal.azure.com --> go to your web app --> go to deployment center  --> deploy the demo app using the belw link.

https://github.com/cloudnloud/azure-dotnet-demo-web-app

now access webapp url and see application is working..
