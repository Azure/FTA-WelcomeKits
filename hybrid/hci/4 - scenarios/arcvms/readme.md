[RBAC]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/assign-vm-rbac-roles
[arvvms]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/create-arc-virtual-machines
[arboverview]:https://learn.microsoft.com/en-us/azure/azure-arc/resource-bridge/overview
[createcsv]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/create-volumes
[storagepathcli]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/create-storage-path?tabs=azurecli
[storagepathportal]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/create-storage-path?tabs=azureportal
[logicalnetworkcli]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/create-logical-networks?tabs=azurecli
[logicalnetworkportal]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/create-logical-networks?tabs=azureportal
[networkinterfacecli]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/create-network-interfaces?tabs=azurecli
[imagesmarketcli]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/virtual-machine-image-azure-marketplace?tabs=azurecli
[imagesmarketportal]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/virtual-machine-image-azure-marketplace?tabs=azureportal
[imagessacli]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/virtual-machine-image-storage-account?tabs=azurecli
[imagessaportal]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/virtual-machine-image-storage-account?tabs=azureportal
[imageslocalcli]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/virtual-machine-image-local-share?tabs=azurecli
[imageslocalportal]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/virtual-machine-image-local-share?tabs=azureportal
[prepubuntu]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/virtual-machine-image-linux-sysprep
[prepcentos]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/virtual-machine-image-centos
[prepredhat]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/virtual-machine-image-red-hat-enterprise
[networkinterfacecli]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/create-network-interfaces?tabs=azurecli

# Arc VM Management for Azure Stack HCI

This guide walks you through options and approaches for the deployment and management of VM workloads onto Azure Stack HCI.

As part of the 23H2 deployment the Azure Resource Bridge and Custom Locations are automatically deployment as part of the base deployment,  with these it enables the following:

-   Role-based access control via builtin Azure Stack HCI roles ensures that only authorized users can perform VM management operations thereby enhancing security. For more information, see [Azure Stack HCI Arc VM management roles][rbac].

-   Arc VM management provides the ability to deploy with Resource Manager templates, Bicep, and Terraform.

-   The Azure portal acts as a single pane of glass to manage VMs on Azure Stack HCI clusters and Azure VMs. With Azure Arc VM management, you can perform various operations from the Azure portal or Azure CLI including:

    -   Create, manage, update, and delete VMs. For more information, see [Create Arc VMs][arvvms]
    -   Create, manage, and delete VM resources such as virtual disks, logical networks, network interfaces, and VM images.
-   The self-service capabilities of Arc VM management reduce the administrative overhead.

# Arc VM Management Infrastructure Resources

As part of the deployment the following resources are created in the Azure Portal and there is a direct 1-to-1 mapping between these resources instances and a Azure Stack HCI Cluster:

-   **Arc Resource Bridge**: This lightweight Kubernetes VM connects your on-premises Azure Stack HCI cluster to the Azure Cloud. The Arc Resource Bridge is created automatically when you deploy the Azure Stack HCI cluster, and is represented in the Azure Portal as a Resource Bridge Resource

    For more information, see the [Arc Resource Bridge overview][arboverview].

-   **Custom Location**: Just like the Arc Resource Bridge, a custom location is created automatically when you deploy your Azure Stack HCI cluster. You can use this custom location to deploy Azure services. The custom location will then have extensions installed which bring 
    - Azure Stack HCI (vmss-hci) - This extension enabled the deployment and management of VM's and there associated resource
    - microsoft.hybridaksoperator (hybridaksextension) - This extension enabled the deployment and management AKS Clusters
    - 

# Arc VM Management Workloads components

When deploying a VM there are certain building blocks which are needed to allow for their deployment.

## Storage Paths

Storage Paths are a representation of a CSV which exists on cluster.  They are used when create VM's, data disks and images and allow for the specific placement of these resources onto specific CSV's.  When regards the the CSV's and there Storage Paths there are 2 options of how these are created:

- Automatic - During the deployment of the cluster if the options is to create the user storage then these are create automatically during deployment, and additional ones created when/if a node is added to the cluster
- Manual -  During the deployment of the cluster if the options is to not create the user storage then the CSV's will need to be [manually created][createcsv], and then the Storage Path needs to be created, this can be with either [Azure CLI][storagepathcli] or the [Azure Portal][storagepathportal]

## Virtual Networks

Currently the only network type available with Arc VM Management are Logical Networks.  They are a representation of a VMSwitch which is configured within a cluster and along with an associated VLAN tag, if applicable.  

With Logical Networks the IP allocation method for resources are:

- DHCP - which would require a DHCP service available from the associated VMSwitch and VLAN
- Static - which requires the following additional information when created
    - IPv4 address space
    - IP pools
      - No Pool - this means all IP addresses in the address space will be used
      - Pool - this allows for a subset of the IP address in the address space will be used, multiple pools can be provided
    - Default gateway address
    - DNS server address

The deployment of Logical Networks can created via [Azure CLI][logicalnetworkcli] or the [Azure Portal][logicalnetworkportal].

## VM Images

The VM images are the source images which the VM workloads will be deployed from, these images are stored locally on the cluster to allow for a quicker deployment from them.  There are a number of Azure Marketplace images available, or you have the option to bring your own images.

### Marketplace Images

These are VM Images which are taken from the Azure Marketplace and are ready to use straight away.  Currently these images are a mix of Windows 10 and Windows 11 single session and multi-session images (which can be used as part of AVD running on HCI) and also some Windows Server 20222 images.  These images can be created via [Azure CLI][imagesmarketcli] or the [Azure Portal][imagesmarketportal].

### Bring your own images

If the images available via the Marketplace are not sufficient then you can create your own images and the create these as VM Images.  When creating a Windows Based image then the usual process to create a sysprepped VHD(x) while should be followed.  When create custom images for linux distributions then guidance is available for this for [Ubuntu][prepubuntu], [CentOS][prepcentos] and [Red Hat Enterprise][prepredhat].

Once these VHD(x) files have been created then these can be either stored in a Azure Storage Account or on a local file share.  

-  To create the VM Image from a Azure Storage Account then created via [Azure CLI][imagessacli] or the [Azure Portal][imagessaportal].
-  To create the VM Image from a local share then created via [Azure CLI][imageslocalcli] or the [Azure Portal][imageslocalportal].

## Network Interfaces

The network interfaces are associated with a logical network and a VM.  These 
