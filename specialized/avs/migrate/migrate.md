# Welcome Kit - Azure VMware Solution - Assess and Migrate - Draft
Welcome to the FastTrack for Azure AVS Welcome Kit section on migration. This comprehensive guide is designed to provide you with essential insights into the areas of focus and consideration when planning and designing your AVS migration efforts. As part of your preparation before engaging with Microsoft engineers, this resource aims to demystify these technologies, offering clear explanations and answers to frequently asked questions. Whether you're new to these concepts or seeking to deepen your understanding, this Welcome Kit is your stepping stone to navigating the world of modern cloud-native solutions.

## Assess
.....
| Title | Type | Reference |
| ----- | ---- | --------- |
| Azure VMware Solution (AVS) Migration and Capacity Planning using Azure Migrate Server Assessment | Video - YouTube | [Link](https://www.youtube.com/watch?v=NoNG-hkksrA&t=692s&pp=ygUcYXp1cmUgbWlncmF0ZSBhc3Nlc3NtZW50IGF2cw%3D%3D) |
| Plan your migration to Azure VMware solution using Azure Migrate | Azure Blogs | [Link](https://azure.microsoft.com/en-us/blog/plan-your-migration-to-azure-vmware-solution-using-azure-migrate/) |
| Create an Azure VMware Solution assessment | MS learn | [link](https://learn.microsoft.com/en-us/azure/migrate/how-to-create-azure-vmware-solution-assessment?context=/azure/azure-vmware/context/context) |

## Migrate
To migrate workloads from on-premises to AVS, a wide variety of solutions is available for use. The migration service provided by the Azure platform for migrations to Azure is called Azure Migrate. At this point in time, Azure Migrate **cannot be used** for migrations to AVS. As part of the AVS service, VMware HCX (Hybrid Cloud Interconnect) is offered to support migrations from on-premises VMware infrastructures to AVS. VMware HCX Enterprise is licensed as part of the AVS service charges. 

> **Important Note**: Please be aware that though VMware HCX is provided and licensing through the AVS services, managing the HCX lifecycle (deploy, update, delete) is the responsibility of the service consumer. VMware HCX updates are not automatically applied as part of AVS service management!

The following table provides a list of learning resources on VMware HCX:
| Title | Type | Reference |
| ----- | ---- | --------- |
| Install and activate VMware HCX in Azure VMware Solution | MS Learn | [Link](https://learn.microsoft.com/en-us/azure/azure-vmware/install-vmware-hcx) |
| Configure on-premises VMware HCX Connector | MS Learn | [Link](https://learn.microsoft.com/en-us/azure/azure-vmware/configure-vmware-hcx) |
| Firewall port requirements for VMware HCX | VMware doc | [Link](https://ports.esp.vmware.com/home/VMware-HCX) |
| Move on-premises VMware infrastructure to Azure VMWare Solution | MS Learn | [Link](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/migrate/azure-best-practices/contoso-migration-vmware-to-azure) |
| Azure VMware Solution Workload Migration with VMware HCX | VMware HoL | [Link](https://labs.hol.vmware.com/HOL/catalogs/lab/10895) |

Next to VMware HCX a wide-variety of other 3rd party solutions have been validated to work with AVS. Based on customer requirements or pre-existing experience (or licensing), it maybe be a completely valid decision to implement another migration offering than VMware HCX like Zerto, Veeam and others. When deciding to leverage another migration solution than VMware HCX, please **always make sure** to consult the software vendor's documentation on AVS support for their specific product. Specific exceptions and/or limitations in the available feature set of their product may apply when used in an AVS implementation.

For convinience we provide some references in the table below. This list is not intended to be a full list of solutions nor is this intended to express a specific vendor preference:
| Title | Type | Reference |
| ----- | ---- | --------- |
| Zerto: On-premises VMware vSphere to Azure VMware Solution | Zerto KB | [Link](https://help.zerto.com/bundle/Install.AVS.HTML/page/Zerto_AVS_Architecture.htm) |
| Veeam: Azure VMware Solution Support — Considerations and Limitations | Veeam KB | [Link](https://www.veeam.com/kb4012) |
