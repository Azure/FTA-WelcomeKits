---
title: Welcome Kit - Azure VMware Solution - Assess and Migrate
geekdocNav: true
geekdocAlign: left
geekdocAnchor: true
---


[Home](..)  
[Assess](#assess)  
[Migrate](#migrate)

Welcome to the FastTrack for Azure - Azure VMware Solution Welcome Kit section on **migration**. This comprehensive guide is designed to provide you with essential insights into the areas of focus and consideration when planning and designing your Azure VMware Solution migration efforts. As part of your preparation before engaging with Microsoft engineers, this resource aims to demystify these technologies, offering clear explanations and answers to frequently asked questions. Whether you're new to these concepts or seeking to deepen your understanding, this Welcome Kit is your stepping stone to navigating the world of modern cloud-native solutions.

## Assess

When migrating to Azure VMware Solution, it is important to gain proper insights into your current workloads. This is important to:

1. Understand which workloads can be migrated easily and which would require some additional investigation,
2. Gain insights in the potential dependencies between workloads which need to be considered carefully,
3. Gain insights how many Azure VMware Solution nodes will be required to host the workloads in scope.

Azure Migrate offers various capabilities to support this analysis either through collecting performance data online using the Azure Migrate on-premises discovery appliance or by importing the required data using a RVTools export file. With the Azure Migrate Discovery appliance, performance information can be gathered over a period of time and this is therefor considered more accurate then using an RVTools import which is a point in time snapshot of the performance data.
| Title | Type | Reference |
| ----- | ---- | --------- |
| Azure VMware Solution Migration and Capacity Planning using Azure Migrate Server Assessment | Video - YouTube | [Link](https://www.youtube.com/watch?v=NoNG-hkksrA&t=692s&pp=ygUcYXp1cmUgbWlncmF0ZSBhc3Nlc3NtZW50IGF2cw%3D%3D) |
| Plan your migration to Azure VMware solution using Azure Migrate | Azure Blogs | [Link](https://azure.microsoft.com/blog/plan-your-migration-to-azure-vmware-solution-using-azure-migrate/) |
| Create an Azure VMware Solution assessment | MS learn | [Link](https://learn.microsoft.com/azure/migrate/how-to-create-azure-vmware-solution-assessment) |
| Import servers running in a VMware environment with RVTools | MS learn | [Link](https://learn.microsoft.com/azure/migrate/tutorial-import-vmware-using-rvtools-xlsx) |

## Migrate

To migrate workloads from on-premises to Azure VMware Solution, a wide variety of solutions is available for use. The migration service provided by the Azure platform for migrations to Azure is called Azure Migrate. At this point in time, Azure Migrate **cannot be used** for migrations to Azure VMware Solution. As part of the Azure VMware Solution service, VMware HCX (Hybrid Cloud Interconnect) is offered to support migrations from on-premises VMware infrastructures to Azure VMware Solution. VMware HCX Enterprise is licensed as part of the Azure VMware Solution service charges.

> **Important Note**: Please be aware that though VMware HCX is provided and licensing through the Azure VMware Solution services, managing the HCX lifecycle (deploy, update, delete) is the responsibility of the service consumer. VMware HCX updates are not automatically applied as part of Azure VMware Solution service management!

The following table provides a list of learning resources on VMware HCX:
| Title | Type | Reference |
| ----- | ---- | --------- |
| Install and activate VMware HCX in Azure VMware Solution | MS Learn | [Link](https://learn.microsoft.com/azure/azure-vmware/install-vmware-hcx) |
| Configure on-premises VMware HCX Connector | MS Learn | [Link](https://learn.microsoft.com/azure/azure-vmware/configure-vmware-hcx) |
| Firewall port requirements for VMware HCX | VMware doc | [Link](https://ports.esp.vmware.com/home/VMware-HCX) |
| Move on-premises VMware infrastructure to Azure VMWare Solution | MS Learn | [Link](https://learn.microsoft.com/azure/cloud-adoption-framework/migrate/azure-best-practices/contoso-migration-vmware-to-azure) |
| Azure VMware Solution Workload Migration with VMware HCX | VMware HoL | [Link](https://labs.hol.vmware.com/HOL/catalogs/lab/10895) |

Next to VMware HCX a wide-variety of other 3rd party solutions have been validated to work with Azure VMware Solution. Based on customer requirements or pre-existing experience (or licensing), it maybe be a completely valid decision to implement another migration offering than VMware HCX like Zerto, Veeam and others. When deciding to leverage another migration solution than VMware HCX, please **always make sure** to consult the software vendor's documentation on Azure VMware Solution support for their specific product. Specific exceptions and/or limitations in the available feature set of their product may apply when used in an Azure VMware Solution implementation.

For convenience we provide some references in the table below. This list is not intended to be a full list of solutions nor is this intended to express a specific vendor preference:
| Title | Type | Reference |
| ----- | ---- | --------- |
| Zerto: On-premises VMware vSphere to Azure VMware Solution | Zerto KB | [Link](https://help.zerto.com/bundle/Install.AVS.HTML/page/Zerto_AVS_Architecture.htm) |
| Veeam: Azure VMware Solution Support — Considerations and Limitations | Veeam KB | [Link](https://www.veeam.com/kb4012) |
