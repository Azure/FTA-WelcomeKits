# SDN Deployment Guide for Azure Stack HCI

This guide walks you through deciding when to use Software Defined Networking (SDN) as part of your Azure Stack HCI deployment, then describes the deployment and configuration process to get you started. 

## Who should use SDN for Azure Stack HCI?

Customers typically choose to implement SDN on their Azure Stack HCI clusters for a couple reasons:

- **Microsegmentation**: Customers who want to implement a micro-segmented environment may deploy SDN to leverage the Network Security groups SDN can apply at the Hyper-v Virtual Switch. This capability enables you to apply simple distributed firewall rules to virtual machine traffic within your cluster, removing the requirement to route all traffic through a network appliance.
- **Service provider models**: Customers who want to delegate network management to tenants or business units running on their Azure Stack HCI cluster may deploy SDN with Virtual Networks. Virtual Networks are an overlay network built on top of your physical network, typically deployed per-customer or workload.
- **Isolated networking**: Some customers require deploying workloads or applications in dedicated, isolated network environments. Using either SDN Logical Networks or Virtual Networks, these customers can define and implement these dedicated networks, with little or no networking changes to the underlying physical networking.
- **Kubernetes**: Customer deploying AKS on thier Azure Stack HCI cluster may want to use SDN to provide networking to their AKS cluster. With this approach, AKS uses SDN Virtual Networks and Load Balancers for node IPs and ingress/egress--enabling a more dynamic environment.

With the many features of SDN comes added complexity to your environment, and it is not always the right choice for customers. Scenarios where SDN may not be the best approach are:

- Customers with limited networking experience or resources
- Customers with limited resources in their Azure Stack HCI cluster
- Customers who's current networking configuration is meeting their requirements sufficiently (SDN can always be deployed later)
- Customers planning to deploy VMs using Arc Resource Bridge (Resource Bridge is not SDN-aware as of 10/01/23)
- Customers using Stretch Clusters (SDN is not supported with Stretch Clusters as of 10/01/23)

## SDN components and phased implementations

There are three components to an SDN deployment. Which components you will need to deploy will depend on the SDN features you require.

- **Network Controller**: Network Controllers, or NCs, serve two primary features: enabling you to configure your SDN environment and applying your desired configuration to the environment. All changes to your SDN configuration are made using the NC's API (called through WAC, PowerShell, or REST method). The NC then ensures that the requested configuration is applied to the Hyper-v hosts, Software Load Balancers, and Gateways. The Network Controller service is made highly available by running in a Service Fabric cluster on multiple VMs, usually deployed on your Azure Stack HCI cluster.
- **Software Load Balancer**: Software Load Balancer, or MUXes, provide software load balancing to your SDN workloads, enabling inbound and outbound connectivity using dedicated public and private IP addresses.
- **Gateway**: The Gateway service in SDN provides external connectivity for SDN Virtual Networks. This connectivity can be VPN, GRE, or layer 3. Gateways are typically deployed when the ingress/egress capabilities of the SDN Software Load Balancer does not meet requirements, such as when all Virtual Network IPs should be routable from the rest of the corprate network.

When deploying SDN, it is generally advisable to deploy just the SDN components that you will need. See the [SDN Configuration Options table](https://learn.microsoft.com/azure-stack/hci/plan/network-patterns-sdn-considerations#sdn-configuration-options) to see which roles are required for different scenarios. 

## Deploying SDN

Although there are a couple approaches which can be taken when deploying your SDN infrastructure, today we usually recommend using the SDNExpress PowerShell module and configuration file approach. With SDNExpress, you declare the SDN infrastructure configuration you would like deployed in a PowerShell PSD1 file and pass it to the SDNExpress script for provisioning. 

When using SDNExpress, the high-level steps are:

1. Aquire an Azure Stack HCI VHDX image file
1. Download the SDNExpress repo to a management system or HCI node
1. Modify a sample config PSD1 file to meet your requirements
1. Execute the SDNExpress script, passing in your configuration file
1. Connect Windows Admin Center to your SDN Network Controllers, enabling you to configure and monitor your SDN environment

The SDNExpress scripts are designed to be idempoent and can be re-run to complete a partial migration or modify a deployed configuration.

## Managing SDN

### Network Controller Database Backup

Backing up your Network Controller database regularly is a critical step to recover from disaster and should be configured before deploying workloads. While your cluster will continue to function when the Network Controller is unavailable, you will be unable to change your SDN configuration, migrate virtual machines between nodes, or deploy new SDN-connected virtual machines. Rebuilding an SDN configuration from scratch would be very challenging.

[How to back up your Network Controller database](https://learn.microsoft.com/windows-server/networking/sdn/manage/update-backup-restore)

### Monitoring

Monitoring SDN is primarily available reactively through Windows Admin Center--were you can see lists of services, their components, and health status. While it is expected that SDN monitoring will be included in HCI Insights monitoring eventually, customers today are left to devop their own monitoring approach. 

Because SDN does not write to Windows Event Logs, one approach is to call the `Get-NetworkController*` PowerShell commands on a schedule and monitor the output for unhealthy statuses. There is an internal solution using this approach that FastTrack can share on request. 

## Common SDN Scenario Considerations

### Microsegementation

This section contains resources for customers looking to implement Network Security Groups on Logical Networks (not Virtual Networks) in order to add microsegmentation to their networking.

- [What is "Datacenter Firewall"/Network Security Groups](https://learn.microsoft.com/azure-stack/hci/concepts/datacenter-firewall-overview)
- How to create and manage Network Security Group security rules with [Windows Admin Center](https://learn.microsoft.com/azure-stack/hci/manage/use-datacenter-firewall-windows-admin-center) or [PowerShell](https://learn.microsoft.com/azure-stack/hci/manage/use-datacenter-firewall-powershell)
- [Using Tags with Network Security Groups](https://learn.microsoft.com/azure-stack/hci/manage/configure-network-security-groups-with-tags)

### Service Provider Models

When implementing SDN in support of a service provider model, one of the primary decision points is whether the Virtual Networks you deploy will need access to be accessible to the rest of your network, or if you plan for them to be primarily isolated. If networks will be fairly isolated, you may only need the Software Load Balancer role and not the Gateway role, assuming providing ingress and egress through load balancers is sufficient. If, however, you want any VM inside a Virtual Network to be accessible from the rest of your network, without the need to create load balancers, you will likely need a Gateway with a Layer 3 connection. 

#### Limitations

- Today, granting scoped permissions to a tenant's Virtual Network (and Virtual Machines) is not possible with Windows Admin Center or other native tooling. In the past, System Center Virtual Machine Manager provided this functionality, but it is expected to drop support for Azure Stack HCI with the 23H2 release. At this time, customers will need to develop their own tooling to enable self-service management, but this is expected to change as Portal and Resource Bridge capabilities mature. 

#### Resources

- [Gateway service overview and L3 forwarding setup diagram](https://learn.microsoft.com/azure-stack/hci/concepts/gateway-overview)
- Although each L3 connection requires a dedicated VLAN, it is possible to implement a hub-and-spoke Virtual Network infrastruture, where the L3 connection is just to the hub Virtual Network, and you can add and peer spoke Virtual Networks as needed.

### Isolated Networking

By default, a Virtual Network provides no ingress or egress--enabling complete isolation and flexibility on IP addressing. Ingress and egress are only enabled once Software Load Balancing or Gateways are added and you can continue to use arbitrary IP addresses within a Virtual Network with either, unless you add a Gateway and need to route to the Virtual Network address space from the rest of your network--in which case, the Virtual Network address space will need to not overlap with your existing address spaces.

In scenarios where you want to provide DNS to isolated Virtual Networks, the [SDN iDNS service](https://learn.microsoft.com/windows-server/networking/sdn/technologies/idns-for-sdn) enables you to relay queries from within the Virtual Network to an external DNS server. 

### Kubernetes

Integrating an Azure Kubernetes Services (AKS) deployment with SDN is a great way to provide IP addresses for AKS, which can frequently require large blocks of addresses. Further, integration with SDN enables AKS to automatically create the load balancers it needs to provide ingress and egress, decreasing the burden on the networking team and keeping the AKS deployment agile.

1. Deploy SDN with the Network Controller and Software Load Balancer roles
1. Create or use an existing VIP address pool in the PublicVIP Logical Network. This is the range of IPs which will be assigned to the load balancer front ends during AKS deployment and as you add pods. The host where you execute the AKS deployment will need to be able to access the addresses in this address pool during deployment. 
1. Deploy AKS using PowerShell, specifying parameters pointing the deployment to use your SDN NC endpoint and the VIP pool addresses from step 2.

See [Deploying AKS with SDN integration](https://learn.microsoft.com/azure/aks/hybrid/software-defined-networking) for more details.

## SDN Frequently-asked Questions


