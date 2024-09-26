<####################################################

Create HCI prerequisites in your resource group (i.e. assign roles, create storage account, keyvault, HCI cluster object)
execution environment: Azure Cloud Shell (PowerShell)
created: 25-09-2024
author: bfrank

!!! Important !!! - change all values with ??? to your values

#####################################################>


#$SubscriptionId = 'a2ba2...???'        # your Azure subscription ID
#$tenantId = '47f489...???'             # your Azure Entra ID tenant ID
$resourceGroup = "rg-myhci???"         # please change me!
$location = "westeurope"

#az login --use-device-code --tenant $tenantId
#az account set --subscription $SubscriptionId  
az group create --name $resourceGroup --location $location

$clustername = 'myhci???clus' # your value here! e.g. myhci00clus
$localAdminUserName = '???' # is it 'asLocalAdmin' ?
$localAdminPassword = '???' # your value here!
$AzureStackLCMAdminUsername = '???' # is it 'asLCMUser' ?
$AzureStackLCMAdminPasssword = '???' # your value here!

#=====please copy your credentials from previous step: 0-createArbDeploymentSP.ps1=====
# displayName: 'arbDeploymentApp17-09__136'
$arbDeploymentAppID = '???'
$arbDeploymentAppSecret = '???'
$arbDeploymentSPNObjectID = '???'

# You are bfrank@bfrankvs.onmicrosoft.com
$principalId = '???'
$hciResourceProviderObjectID = '???'
#=====end=====


az deployment group create  `
    --name $("HCIprereqs_" + ([datetime]::Now).ToString('dd-MM-yy_HH_mm')) `
    --template-file '1-azStackPrereqs.json' `
    --resource-group $resourceGroup `
    --parameters location=$location `
    principalId=$principalId  `
    clustername=$clustername `
    arbDeploymentAppID=$arbDeploymentAppID `
    arbDeploymentAppSecret=$arbDeploymentAppSecret `
    localAdminUserName=$localAdminUserName `
    localAdminPassword=$localAdminPassword `
    AzureStackLCMAdminUsername=$AzureStackLCMAdminUsername `
    AzureStackLCMAdminPasssword=$AzureStackLCMAdminPasssword `
    hciResourceProviderObjectID=$hciResourceProviderObjectID `
    tags=$('{""CreatedBy"": ""me"",""deploymentDate"": ""'+ $(([datetime]::Now).ToString('dd-MM-yyyy_HH-mm')) + '"",""Service"": ""HCI"",""Environment"": ""PoC""}')
# when launched somewhere else in PS - escaping may be different
#    tags=$('{\"CreatedBy\": \"me\",\"deploymentDate\": \"'+ $(([datetime]::Now).ToString('dd-MM-yyyy_HH_mm')) + '\",\"Service\": \"HCI\",\"Environment\": \"PoC\"}')