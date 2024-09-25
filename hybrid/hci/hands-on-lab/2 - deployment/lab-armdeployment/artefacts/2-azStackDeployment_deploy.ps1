<####################################################
2-azStackDeployment_deploy.ps1

Validate and deploy Azure Stack HCI cluster via ARM template
execution environment: Azure Cloud Shell (PowerShell)
created: 25-09-2024
author: bfrank

!!! Important !!! - change all values with ??? to your values some of them are from previous steps

#####################################################>


#$SubscriptionId = 'a2ba2...???'        # your Azure subscription ID
#$tenantId = '47f489...???'             # your Azure Entra ID tenant ID
$resourceGroup = "rg-myhci???"         # please change me!
#$location = "westeurope"

#az login --use-device-code --tenant $tenantId
#az account set --subscription $SubscriptionId  
#az group create --name $resourceGroup --location $location


# !!! Important !!! before kicking of the deployment - check and update the ??? in the parameters file

az deployment group create  `
  --name $("HCI_validation_" + ([datetime]::Now).ToString('dd-MM-yy_HH_mm')) `
  --template-file 2-azStackDeployment.json `
  --resource-group $resourceGroup `
  --parameters 2-azstackdeployment.parameters.json 
  
 # !!! Important !!! wait until the validation is finished and check the output

  az deployment group create  `
  --name $("HCI_deployment_" + ([datetime]::Now).ToString('dd-MM-yy_HH_mm')) `
  --template-file 2-azStackDeployment.json `
  --resource-group $resourceGroup `
  --parameters 2-azstackdeployment.parameters.json --parameters deploymentMode='Deploy' 


