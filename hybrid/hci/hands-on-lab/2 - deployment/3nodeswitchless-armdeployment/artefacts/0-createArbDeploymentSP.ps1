
#az login

#adjust the vars to your needs!
$SPName = "arbDeploymentApp{0}_{1}" -f  $(Get-Date -Format "dd-MM"),$(Get-Random -Minimum 100 -Maximum 999)   #your value here!

#get the current context
$ctx = az account show | ConvertFrom-Json

#create Service Principal (it needs to be owner to set permissions on azure artefacts - especially the application group users)
$sp = az ad sp create-for-rbac -n "$SPName" --role 'Azure Resource Bridge Deployment Role' --scopes "/subscriptions/$($ctx.id)"

#az role assignment create --assignee "$($context.user.name)" --role "Key Vault Secrets Officer" --scope "$keyvaultid"

$sp = $sp | ConvertFrom-Json
$spID=$(az ad sp list --display-name $($sp.displayName) --query "[].{spID:id}" --output tsv)

$output = @"
=====please copy your credentials:=====
# displayName: '$($sp.displayName)'
`$arbDeploymentAppID= '$($sp.appId)'
`$arbDeploymentAppSecret= '$($sp.password)'
`$arbDeploymentSPNObjectID= '$($spID)'

# You are $($ctx.user.name)
`$principalId = '$(az ad user list --upn $($ctx.user.name) --query "[].{USERID:id}" --output tsv )'

`$hciResourceProviderObjectID = '$(az ad sp list --display-name 'Microsoft.AzureStackHCI Resource Provider' --query "[].{spID:id}" --output tsv)'
=====end=====
"@

Write-Host $output -ForegroundColor Magenta  


