[JumpstartHCIBox]:https://azurearcjumpstart.io/azure_jumpstart_hcibox

# 2 - deployment: Cluster Deployment

## Introduction
This lab content is designed to guide you through the deployment of Azure Stack HCI (23H2).  
Azure Stack HCI is a hyper-converged infrastructure (HCI) solution that combines industry-standard hardware with Azure services to provide an integrated system with hybrid capabilities.

## Prerequisites
- Compatible hardware as per Microsoft's requirements.
- An active Azure subscription.

## HCI Lab Options
>Note: There are several possibilites you have to setup a lab environment. You could use:  
1) ...your HCI validated hardware (i.e. on real physics)
2) ...older server HW with Hyper-V installed and setup a virtualized (nested) AzStack HCI
3) ...the [Jumpstart HCIBox](JumpstartHCIBox) when you have no HW and want to simulate it in Azure instead.
4) ...
>Important note: For the following labs the assumption is that you are using option 2) - So if you are chosing any other option some steps - screenshots may differ a little.

SECTION: DEPLOY AND INSTALL
AD Prep
Downloading HCI....
Installing HCI
ARC Registration
Portal Deployment (Validation)
Portal Deployment (Deployment)
Update from Portal (Azure Update Manager)
Collect Logs


## Setting Up the Environment
1. Ensure your hardware meets the necessary requirements.
2. Install Windows Server on all nodes that will be part of your HCI cluster.
3. Configure basic networking to ensure all nodes can communicate.

## Deploying Azure Stack HCI
1. Download the Azure Stack HCI OS from the Microsoft website.
2. Create a bootable USB drive with the Azure Stack HCI OS.
3. Install Azure Stack HCI on each node.

## Lab Exercises
- **Exercise 1:** Installing and Configuring Azure Stack HCI.
- **Exercise 2:** Integrating Azure Stack HCI with Azure Services.
- **Exercise 3:** Managing and Monitoring Azure Stack HCI.

## Conclusion
This lab provides a comprehensive guide to deploying and managing Azure Stack HCI, integrating it with Azure, and ensuring its ongoing maintenance and monitoring.

## Appendix
- Troubleshooting common issues.
- Frequently asked questions (FAQ).  

[◀ 1 - planning](../1%20-%20planning/readme.md) | [🔼 hands-on-lab](../readme.md) | [3 - governance ▶](../3%20-%20governance/readme.md)