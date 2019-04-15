# Azure Functions ML.NET Sample Application

This application showcases how to build a classification model with ML.NET and deploy it to Azure Functions. More detailed step-by-step instructions on building and deploying this project can be found in the following blog [post](http://luisquintanilla.me/2018/08/21/serverless-machine-learning-mlnet-azure-functions/).

## Build Model

```bash
git clone https://github.com/djkormo/azfnmlnetdemo.git
cd model
mkdir model
cd model
mkdir data
curl -o data/iris.txt https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data


dotnet restore
dotnet run
```

## Deploy

Follow blog post instructions.
