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
[portaldeplyment]:https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deploy-via-portal
[tempaltespecs]:https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/template-specs?tabs=azure-powershell
[armtempaltedeployment]:https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deployment-azure-resource-manager-template
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

As part of the deployment there needs to be pre-staged objects in Active Directory which are then used as part of the deployment.  These are created [automatically with a script][preparead] and this should be ran with different values for each cluster deployed  These include:

-   A cluster OU which has a Computers and a Users OU.  For these GPO inheritance is blocked to ensure that any existing GPO's to no impact the Azure Stack HCI Nodes
-   A computer object for the cluster and also for each of the nodes, these are in the Computers created as part of this process.
-   A user account which is the LCM user which is is used for the active directory integrations of the cluster during deployment and then also as part of the management lifecycle of the cluster
-   A number of AD groups (Domain Local Groups) which are used for allocation of permissions

The values entered during the script will be needed as part of the deployment.

At this point then consider running the [Active Directory Checker][adchecker] to ensure the node is ready and passes all tests.


## Preparing the Hardware

In some cases the hardware will be delivered and will already be prepared with the OS and drivers installed, and the correct firmware installed.  The below is a list of steps to perform on the hardware prior to the deployment:

-   [Download the ISO][downloadiso] and [install the OS][installos], this the deployment is at scale you may wish to automate this process using tools such as Window Deployment Servers, or boot strapping the installation
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
-   Create an additional local administrator account on each node, this can be then used as part of the deployment (the “administrator” account is disabled at the end of the deployment)
-   Ensure that the name, driver version, firmware version and component ID is consistent across all nodes and adapter usage types e.g. they should be consistent across comp-mgmt-1 and comp-mgmt-2 across all nodes.  (this is required for Network ATC)
  
At this point then consider running the [Hardware Checker][hardwarechecker] to ensure the node is ready and passes all tests.

## Arc Registration and Permissions

The next stage is to onboard the nodes to Azure.  A [script is provided which will install the Arc Agent][arconboarding] and also the required extensions which are used as part of the deployment.  The extensions which are installed are:

-   Azure Edge Device Management
-   Azure Edge Lifecycle Manager
-   Remote Edge Support
-   Telemetry and Diagnostics

When the script is showing as complete there is some time that it takes for the installation to complete so it is important to check the node resource in the Azure Portal and ensure that it shows all Extensions are successfully installed.

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

-   [Portal Deployment][portaldeplyment] - this is a manual process of entering all of the setting.  You can also use [Arm Template Specs][tempaltespecs] which can pre-populate a number of the fields to allow for a consistency across the deployment, e.g. configuration of intents, domain and OU name
-   [ARM Template][armtempaltedeployment]  - this is the standard ARM Template deployment approach with requires the json template and also a parameters while which will be specific to the deployment.  With this approach there are some [resource which need to be pre-deployed][prepareresource] and also some [additional permissions][assignresourcepermissions] which need to be assigned.

With the Portal Deployment method there will then be a number of resources which are created automatically they are:

- The Azure Stack HCI Cluster Resource
- A Key Vault
- Storage Account for the Cloud Witness
- Storage Account for the Diagnostic settings for the Key Vault
- Permissions to the Key Vault
- The credentials for the LCM user, local user and keys for the storage accounts will be written to the Key Vault

Once this is complete then the next step is to run the validation.  This includes all of the checked which have been mentioned in the Deployment Planning and Readiness, so these should complete successfully, if the readiness checks have been complete.

Once these are successful then then the deployment can now be started.  It is expected the deployment to take 2.5-3 hours with some steps taking 30-45 minutes to complete. This deployment process can be monitored from the Azure Stack HCI Cluster Resource and then under deployments.

Additionally there are a series of logs which can be checked during the deployment, these are outline in [this blog post][deploymenttroubleshooting].