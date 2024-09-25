[JumpstartHCIBox]:https://azurearcjumpstart.io/azure_jumpstart_hcibox

# 2 - deployment: Cluster Deployment

## Introduction
This lab content is designed to guide you through the deployment of Azure Stack HCI (23H2).  
Azure Stack HCI is a hyper-converged infrastructure (HCI) solution that combines industry-standard hardware with Azure services to provide an integrated system with hybrid capabilities.

## Deployment methods
Azure Stack HCI (since 23H2) can be deployed in 2 ways:  
1) Using the Azure Portal (this page)
2) [Deploy from an Azure Resource Manager template](./lab-armdeployment/readme.md)

>**Tip:**  
>While 1. is recommended for beginners - 2. might offer you customization options which are not (yet) available in the wizard provided by 1. the Azure Portal.  
>My **recommendation would be do 1) first** and when successfully mastered and seeking for automation, replay then try 2) [Deploy from an Azure Resource Manager template](./lab-armdeployment/readme.md)

## Prerequisites
[Review deployment prerequisites for Azure Stack HCI, version 23H2](https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deployment-prerequisites)

## HCI Lab Options
>Note: There are several possibilites you have to setup a lab environment. You could use:  
1) ...your HCI validated hardware (i.e. on real physics) - see: [Azure Stack HCI solutions](https://azurestackhcisolutions.azure.microsoft.com/#/catalog)
2) ...older server HW with Hyper-V installed and setup a virtualized (nested) AzStack HCI - see: [Use CreateVmsUsingScript To Deploy A Nested Virtualization Environment To Test Azure Stack HCI 23H2](https://github.com/bfrankMS/CreateHypervVms/tree/master/Scenario-AzStackHCI)
3) ...the [Jumpstart HCIBox](JumpstartHCIBox) when you have no HW and want to simulate it in Azure instead.
4) ...

>**Important note:** **For the following labs we assume is that you are using option 2)** - So if you are chosing any other option some steps - screenshots may differ a little.

## The general setup steps for AzStack (23H2 current) are:
1. [Prepare Active Directory](https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deployment-prep-active-directory)
2. [Download the software](https://learn.microsoft.com/en-us/azure-stack/hci/deploy/download-azure-stack-hci-23h2-software)
3. [Install the OS](https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deployment-install-os)
4. [Register with Arc and set up permissions](https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deployment-arc-register-server-permissions?tabs=powershell)
5. [Deploy (Azure Portal | ARM template)](https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deploy-via-portal)
 

## The environment provided by  
[...Deploy A Nested Virtualization Environment To Test Azure Stack HCI 23H2](https://github.com/bfrankMS/CreateHypervVms/tree/master/)   
has some specifics or benefits:  
**[the DC]**
- It already has an AD installed and configured.
- acts as DNS and should provide NAT routing to your external network
- Windows Admin Center is pre-installed and reachable locally at https://localhost
- There is a code snipped in c:\temp\step_HCIADprep.ps1 which you can use to prepare the AD for HCI installation.  
    
**[2 HCI nodes]**
- There are 2 VMs (00-HCI-1 and 00-HCI-2) deployed + configured with the (virtual) HW required and tanked with the Az Stack HCI OS

### 1. Prepare Active Directory
- Navigate to c:\temp\step_HCIADprep.ps1
- Edit the file and enter a password at:
```PowerShell
$deployUserPwd = "........"
```
- save -> execute -> and check if you now have an OU in your AD....
### 2. Download the [Az Stack HCI] software - [done!]

### 3. Install the OS [done!] + *add some secret sauce*
[do this on every HCI node]
- Check internet connectivity - e.g. can you ping e.g. ibm.com? -> then your nat router (on the DC) works
- Disable IPv6 on all of the adapters if it was not configured by you. e.g.:  
```PowerShell
Disable-NetAdapterBinding -InterfaceAlias * -ComponentID ms_tcpip6
```

- Make sure you have a time server set (NTP)  
Take a time server that is close to you e.g.:
```PowerShell
w32tm /config /manualpeerlist:hu.pool.ntp.org /syncfromflags:manual /reliable:yes /update
w32tm /resync /force
w32tm /query /status
```

### 4.a Register with Arc
Onboard your AzStack HCI hosts to Azure using e.g.  
[do this on every HCI node]
```PowerShell
$verbosePreference = "Continue"
$subscription = "a2ba2.........7e6f"    # your subscription ID
$tenantID = "47f4...........aab0"       # your Entra ID 
$rg = "rg-myHCI...."    # an existing RG.
$region = "westeurope"  #or eastus???

Connect-AzAccount -TenantId $tenantID -Subscription $subscription -UseDeviceAuthentication
$armAccessToken = (Get-AzAccessToken).Token
$id = (Get-AzContext).Account.Id
Start-Sleep -Seconds 3
Invoke-AzStackHciArcInitialization -subscription $subscription -ResourceGroup $rg -TenantID $tenantID -Region $region -Cloud 'AzureCloud' -ArmAccesstoken $armAccessToken -AccountID $id -verbose
```

### 4.b ...and set up permissions
Assign the following roles to the user that will install AzStack HCI - see: [Assign required permissions for deployment](https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deployment-arc-register-server-permissions?tabs=powershell#assign-required-permissions-for-deployment)

### 5. Deploy using the Azure Portal
see [Deploy an Azure Stack HCI, version 23H2 system using the Azure portal](https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deploy-via-portal)  
Here are the most important Parameters:  
|Parameter|Value|Annotation|
|--|--|--|
|Region|e.g. *West Europe*| not all Azure regions are supported yet. [see](https://learn.microsoft.com/en-us/azure-stack/hci/concepts/system-requirements-23h2#azure-requirements)|
|clusterName                   |e.g. *myhci**00**clus*|The name of the hci cluster|
|storage Connectivity          |No switch for storage|The storage connectivity switchless value for deploying a hci cluster|
|networking Pattern            |Custom configuration|The networking pattern for deploying a hci cluster|
|intentList                    |<ul><table style='font-family:"Courier New", Courier, monospace; font-size:40%'><tr><th>name</th><th>mgmt</th></tr><tr><th>trafficType</th><th>{Management}</th></tr><tr><th>adapter</th><th>{aMGMT}</th></tr><tr><th>overrideVirtualSwitchConfiguration</th><th>False</th></tr><tr><th>virtualSwitchConfigurationOverrides</th><th>@{enableIov=; loadBalancingAlgorithm=}</th></tr><tr><th>overrideQosPolicy</th><th>False</th></tr><tr><th>qosPolicyOverrides</th><th>@{priorityValue8021Action_Cluster=7; priorityValue8021Action_SMB=3; bandwidthPercentage_SMB=50}</th></tr><tr><th>overrideAdapterProperty</th><th>True</th></tr><tr><th>adapterPropertyOverrides</th><th>@{jumboPacket=1514; networkDirect=Disabled; networkDirectTechnology=}</th></tr></table></ul></br><ul><table style='font-family:"Courier New", Courier, monospace; font-size:40%'><tr><th>name</th><th>compute</th></tr><tr><th>trafficType</th><th>{Compute}</th></tr><tr><th>adapter</th><th>{Comp1,Comp2}</th></tr><tr><th>overrideVirtualSwitchConfiguration</th><th>False</th></tr><tr><th>virtualSwitchConfigurationOverrides</th><th>@{enableIov=; loadBalancingAlgorithm=}</th></tr><tr><th>overrideQosPolicy</th><th>False</th></tr><tr><th>qosPolicyOverrides</th><th>@{priorityValue8021Action_Cluster=7; priorityValue8021Action_SMB=3; bandwidthPercentage_SMB=50}</th></tr><tr><th>overrideAdapterProperty</th><th>True</th></tr><tr><th>adapterPropertyOverrides</th><th>@{jumboPacket=1514; networkDirect=Disabled; networkDirectTechnology=}</th></tr></table></ul></br><ul><table style='font-family:"Courier New", Courier, monospace; font-size:40%'><tr><th>name</th><th>smb</th></tr><tr><th>trafficType</th><th>{Storage}</th></tr><tr><th>adapter</th><th>{SMB1,SMB2}</th></tr><tr><th>overrideVirtualSwitchConfiguration</th><th>False</th></tr><tr><th>virtualSwitchConfigurationOverrides</th><th>@{enableIov=; loadBalancingAlgorithm=}</th></tr><tr><th>overrideQosPolicy</th><th>False</th></tr><tr><th>qosPolicyOverrides</th><th>@{priorityValue8021Action_Cluster=7; priorityValue8021Action_SMB=3; bandwidthPercentage_SMB=50}</th></tr><tr><th>overrideAdapterProperty</th><th>True</th></tr><tr><th>adapterPropertyOverrides</th><th>@{jumboPacket=1514; networkDirect=Disabled; networkDirectTechnology=}</th></tr></table></ul>|The intent list for deploying a hci cluster|
|storageNetworkList            |<ul>SMB1 : 711</ul><ul>SMB2 : 712</ul>|The storage network list for deploying a hci cluster|
|subnetMask                    |255.255.255.0|The subnet mask for deploying a hci cluster|
|defaultGateway                |192.168.0.1|The default gateway for deploying a hci cluster|
|startingIPAddress             |192.168.0.10|The starting ip address for deploying a hci cluster|
|endingIPAddress               |192.168.0.30|The ending ip address for deploying a hci cluster|
|dnsServers                    |192.168.0.1|The dns servers for deploying a hci cluster|
|domainFqdn                    |e.g. *myhci**00**.org*|**Your** domain name of the active directory|
|adouPath                      |e.g. *OU=HCI,DC=myhci**00**,DC=org*|**Your** oU path|
|Username                      |asLCMUser|The domain deployment account that was created in step 1.|
|Password                      |%your password%|password for asLCMUser |
|Local administrator username  |asLocalAdmin | A local administrator account that was predeployed when using [...Deploy A Nested Virtualization Environment To Test Azure Stack HCI 23H2](https://github.com/bfrankMS/CreateHypervVms/tree/master/)    |
|Local administrator password  |%your password%|password for local Admin user depending on what you have specified in [...Deploy A Nested Virtualization Environment To Test Azure Stack HCI 23H2](https://github.com/bfrankMS/CreateHypervVms/tree/master/)  |
|Volumes             |Create workload volumes|The volume type for deploying a hci cluster|




[◀ 1 - planning](../1%20-%20planning/readme.md) | [🔼 hands-on-lab](../readme.md) | [3 - governance ▶](../3%20-%20governance/readme.md)