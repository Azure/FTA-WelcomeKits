[clouddeployment]:https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deployment-introduction
[deploy22h2]:https://learn.microsoft.com/en-us/azure-stack/hci/deploy/create-cluster?tabs=use-network-atc-to-deploy-and-manage-networking-recommended
[stretchcluster22h2]:https://learn.microsoft.com/en-us/azure-stack/hci/deploy/create-cluster-powershell#step-5-set-up-sites-stretched-cluster
[deploy22h2video]:https://www.youtube.com/watch?v=LIkW5s4mQoA&list=PLDk1IPeq9PPdd1Al9VitnrFrr5DnTI5sZ
[stretchcluster22h2video]:https://www.youtube.com/watch?v=QmLmcKjmf_U&list=PLDk1IPeq9PPfzO44pB-9-82r07Q4K6tYW
[planningwelcomekit]:https://aka.ms/FTAWelcomeKit/Hybrid/Planning
[environmentchecker]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/use-environment-checker?tabs=connectivity
[connectivitychecker]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/use-environment-checker?tabs=connectivity#run-readiness-checks
[hardwarechecker]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/use-environment-checker?tabs=hardware#run-readiness-checks
[adchecker]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/use-environment-checker?tabs=active-directory
[networkchecker]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/use-environment-checker?tabs=network
[arcintegrationschecker]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/use-environment-checker?tabs=arc-integration
[downloadiso]:https://learn.microsoft.com/en-us/azure-stack/hci/deploy/download-azure-stack-hci-23h2-software
[installos]:https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deployment-install-os
[configureos]:https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deployment-install-os#configure-the-operating-system-using-sconfig
[installhyperv]:https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deployment-install-os#install-required-windows-roles
[preparead]:https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deployment-prep-active-directory
[arconboarding]:https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deployment-arc-register-server-permissions
[azurepermissions]:https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deployment-arc-register-server-permissions#assign-required-permissions-for-deployment
[portaldeployment]:https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deploy-via-portal
[tempaltespecs]:https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/template-specs?tabs=azure-powershell
[armtempaltedeployment]:https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deployment-azure-resource-manager-template
[biceptempaltedeployment]:https://learn.microsoft.com/en-us/samples/azure/azure-quickstart-templates/create-cluster-with-prereqs/?tabs=azurecli
[quickstart]:https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.azurestackhci
[prepareresource]:https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deployment-azure-resource-manager-template#step-1-prepare-azure-resources
[assignresourcepermissions]:https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deployment-azure-resource-manager-template#step-2-assign-resource-permissions
[deploymenttroubleshooting]:https://techcommunity.microsoft.com/t5/fasttrack-for-azure/troubleshooting-azure-stack-hci-23h2-preview-deployments/ba-p/4036222

# Welcome Kit - Azure Stack HCI - Deployment

Welcome to the "Azure Stack HCI - Deployment Welcome Kit." With the release of Azure Stack HCI 23H2 the deployment method has now changed.  With all 23H2 deployments the [cloud deployment][clouddeployment] must be used.  Currently at GA 23H2 does not support the deployment of stretch clustering, meaning until the GA of stretch clustering with Azure Stack HCI 23H2, then 22H2 should be used.  

Resources are still available for the deployment of 22H2:

-   [Deploying single site cluster with 22H2][deploy22h2]
-   [Deploying single site cluster with 22H2 Video Series][deploy22h2video]
-   [Deploying stretch cluster with 22H2][stretchcluster22h2]
-   [Deploying stretch cluster with 22H2 Video Series][stretchcluster22h2video]
  
## Deployment Planning and Readiness

When looking to the deployment of Azure Stack HCI then there are a number of design decisions which need to be taken anf these are covered within the [Planning Welcome Kit][planningwelcomekit].  Once all of these decision and design have been complete then the next step is to ensure that the environment is ready for the deployment.  The [Environment Checker][environmentchecker] provides the following checks which should all be complete and pass successfully to help a smooth deployment as possible:



-   [Connectivity Checker][connectivitychecker] - This validates the connection to all of the Azure Endpoints which are needed.  This can be ran before the hardware is available from a client which is on the same network/subnet which the nodes will be deployed to
-   [Hardware Checker][hardwarechecker] - This validates the hardware meets all of the requirements needed.  This should be ran on each of the nodes
-   [Active Directory Checker][adchecker] - This validates the AD Preparation has been complete, and meets all of the requirements.  This can be ran from any client which can access Active Directory
-   [Network Checker][networkchecker] - This validates that IP addresses to be used for the deployment are free an available.  This can be ran from any client which is allowed ping(ICMP), WinRM(TCP/5985 and TCP/5986) and SSH (TCP/22) to those address, ideally on the same network/subnet which the nodes will be deployed to
-   [Arc Integrations][arcintegrationschecker] - This validates the that resources with matching names don't already exist in Azure, Support Region, Resource Limit etc.  This can be ran from any client which can access Azure

## Preparing the Active Directory

The requirements for Active Directory are:

 - A dedicated Organization Unit (OU).
 - Group policy inheritance that is blocked for the applicable Group Policy Object (GPO).
 - A user account that has all rights to the OU in the Active Directory.

A [PowerShell module][adprep] is available which can be used set this up these requirements, however this is not a requirement and these can bet set up manually.  A additional consideration is the presences of enforced policies as these will not be blocked when Group policy inheritance that is blocked, alternative methods would need to block these such as [WMI Filter][wmifilter] or [Security Groups][securitygroups].

At this point then consider running the [Active Directory Checker][adchecker] to ensure the node is ready and passes all tests.


## Preparing the Hardware

In some cases the hardware will be delivered and will already be prepared with the OS and drivers installed, and the correct firmware installed.  The below is a list of steps to perform on the hardware prior to the deployment:

-   [Download the ISO][downloadiso] and [install the OS][installos], this the deployment is at scale you may wish to automate this process using tools such as Window Deployment Servers, or boot strapping the installation.  Do not install any updates as these are handled as part of the deployment
-   Ensure the administrator password is identical across all nodes
-   [Configure an IP address on a single interface][configureos], this will be the 1st of the interfaces which will used as part of the management intent
-   [Configure a time source on the node][configureos], which is not the BIOS, typically this will be the server which owns the PDC Roles in Active Directory
-   Install all of the available update on each node
-   [Install the Hyper-V role][installhyperv]
-   Disable any adapters which are not going to be used e.g. iDRAC
-   Disable IPv6 on all interfaces, this can lead to the test-cluster during the deployment to fail
-   Rename all adapters to be the same across all nodes.  E.G.
    - comp-mgmt-1
    - comp-mgmt-2
    - smb-1
    - smb-2
-   Ensure there is only one default route existing on each node
-   Create an additional local administrator account on each node, this can be then used as part of the deployment (the “administrator” account is renamed to "ASBuiltInAdmin" at the end of the deployment)
-   Ensure that the name, driver version, firmware version and component ID is consistent across all nodes and adapter usage types e.g. they should be consistent across comp-mgmt-1 and comp-mgmt-2 across all nodes.  (this is required for Network ATC)
  
At this point then consider running the [Hardware Checker][hardwarechecker] to ensure the node is ready and passes all tests.

## Preparing the networking

With regards to the networking then it is important to remember that during the deployment as part of the Network ATC and RDMA configuration that a VLAN tag is applied to the storage interfaces, due to this it is mot likely that the switch ports which the the storage adapters are connected to will need to be set as trunk ports with the intended VLANs for storage set as allowed ports.  If the port is set as an access port with the VLAN set or the intended VLAN for storage is set ad the native/default VLAN then the traffic will be dropped due to the double tagging of the VLAN.

## Arc Registration and Permissions

The next stage is to onboard the nodes to Azure.  A [script is provided which will install the Arc Agent][arconboarding] and also the required extensions which are used as part of the deployment.  The extensions which are installed are:

-   Azure Edge Device Management
-   Azure Edge Lifecycle Manager
-   Remote Edge Support
-   Telemetry and Diagnostics

When the script is showing as complete there is some time that it takes for the installation to complete so it is important to check the node resource in the Azure Portal and ensure that it shows all Extensions are successfully installed.  If there is a failure the extension can be re-moved from the portal and then re-installed by re-running the onboarding script.

There are 2 locations which [Azure Permissions][azurepermissions] need to be set.  They are:

-   At a subscription level the user which will run the deployment will need to have a minimum of
    -   Azure Stack HCI Administrator
    -   Reader
-   At a Resource Group level the user which will run the deployment will need to have a minimum of
    -   Key Vault Administrator
    -   Key Vault Contributor
    -   Storage Account Contributor
  

## Deployment of the Cluster

The actual configuration and deployment of the cluster is is now totally cloud/Azure Portal driven and uses the Azure Arc Extensions to initiate nd then track the deployment progress.  There are 2 methods for the deployment are they are:

-   [Portal Deployment][portaldeployment] - this is a manual process of entering all of the setting.  You can also use [Arm Template Specs][tempaltespecs] which can pre-populate a number of the fields to allow for a consistency across the deployment, e.g. configuration of intents, domain and OU name
-   [ARM Template][armtempaltedeployment]  - this is the standard ARM Template deployment approach with requires the json template and also a parameters while which will be specific to the deployment.  With this approach there are some [resource which need to be pre-deployed][prepareresource] and also some [additional permissions][assignresourcepermissions] which need to be assigned.  This does require the template to be ran in validation mode and then deploy mode.
-   [BICEP Template][biceptempaltedeployment]  - this is the standard BICEP Template deployment approach with requires the json template and also a parameters while which will be specific to the deployment.  This template will deploy the additional resources required and does require the template to be ran in validation mode and then deploy mode.

[Quick Start Templates][quickstart] for both ARM and BICEP are available are a starting position for the deployment.

With the Portal Deployment method there will then be a number of resources which are created automatically they are:

- The Azure Stack HCI Cluster Resource
- A Key Vault
- Storage Account for the Cloud Witness
- Storage Account for the Diagnostic settings for the Key Vault
- Permissions to the Key Vault
- The credentials for the LCM user, local user and keys for the storage accounts will be written to the Key Vault

During the section of the deployment where the storage is configured if the option to only create the infrastructure volume then the volumes for the workloads will need to be created manually.  If the option to to create the volumes is selected then these volumes are created as 

Once this is complete then the next step is to run the validation.  This includes all of the checks which have been mentioned in the Deployment Planning and Readiness, so these should complete successfully, if the readiness checks have been complete.

Once these are successful then then the deployment can now be started.  It is expected the deployment to take 2.5-3 hours with some steps taking 30-45 minutes to complete. This deployment process can be monitored from the Azure Stack HCI Cluster Resource and then under deployments.

Additionally there are a series of logs which can be checked during the deployment, these are outline in [this blog post][deploymenttroubleshooting].