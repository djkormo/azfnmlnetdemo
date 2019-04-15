# based on https://markheath.net/post/deploying-azure-functions-with-azure-cli
# based on http://luisquintanilla.me/2018/08/21/serverless-machine-learning-mlnet-azure-functions/
# based on https://azurecitadel.com/prereqs/cli/cli-4-bash/

RND=$RANDOM

AZURE_GROUP=rg-ml-fun
AZURE_LOCATION=westeurope
AZURE_STORAGEACC=mymlserverless$RND
AZURE_PLAN=MyPlan$RND
AZURE_FUN_APP=mymlfunc$RND
az configure --defaults group=$AZURE_GROUP
az configure --defaults location=$AZURE_LOCATION


# Create a resource group.
az group create --name $AZURE_GROUP --location $AZURE_LOCATION

#  storage account 

az storage account create -n $AZURE_STORAGEACC -g $AZURE_GROUP -l $AZURE_LOCATION  --sku Standard_LRS

az storage account keys list --account-name $AZURE_STORAGEACC --resource-group $AZURE_GROUP -o table 

AZURE_STORAGEACC_KEY=$(az storage account keys list --account-name $AZURE_STORAGEACC --resource-group $AZURE_GROUP --query [0].value --output tsv)


az storage container create --name models --account-key $AZURE_STORAGEACC_KEY --account-name $AZURE_STORAGEACC --fail-on-exist

az storage blob upload --container-name models --account-name $AZURE_STORAGEACC --file model/model/model.zip --name model.zip

az storage blob list --container-name models --account-name $AZURE_STORAGEACC  --output table

#  consumption plan for function 

az functionapp create --resource-group $AZURE_GROUP --consumption-plan-location $AZURE_LOCATION \
--name $AZURE_FUN_APP --storage-account  $AZURE_STORAGEACC --runtime dotnet 
#--use-32bit-worker-process false

#az functionapp plan create -g $AZURE_GROUP -n $AZURE_PLAN --sku F1

#  function app 
#az functionapp create -g $AZURE_GROUP  -p $AZURE_PLAN -n $AZURE_FUN_APP -s $AZURE_STORAGEACC


