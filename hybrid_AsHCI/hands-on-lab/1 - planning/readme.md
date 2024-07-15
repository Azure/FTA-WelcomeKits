[NoSupportForRaidController]:https://learn.microsoft.com/en-us/azure-stack/hci/concepts/system-requirements-23h2#server-and-storage-requirements
[StorageStandard]:https://learn.microsoft.com/en-us/azure-stack/hci/concepts/host-network-requirements#rdma
[WindowsServerCatalog]:https://www.windowsservercatalog.com/

# 1 - planning: Infrastructure Setup and Integration

**Purpose:**
- Better understanding of AzStack HCI & Storage Spaces Direct (S2D)  
- Where to go to find supported hardware
- right-size the solution

### 1. Quiz
Research to find the answers on the following questions:
- Your Azure Stack HCI cluster (23H2) can contain ___ to ___ nodes.
- Imagine your HCI cluster has 8 nodes. How many can fail before everything goes down? Would the resilience of this cluster rise when adding 2 nodes?
- What resiliency type would you chose for a volume hosting high performance VM workload? 
- Can you use dual parity for a volume in a cluster with 3 nodes?
- Nested resiliency provides a way to tolerate the outage of a disk plus another node go offline in a 2 node cluster - correct or wrong?
- What network traffic classes do I have on an AzStack HCI cluster?

### 2. Exercise: Assessing Your Current Infrastructure
Objective: Assess your current infrastructure to determine if it meets the requirements for Azure Stack HCI 23H2.  
Or in other words - Can I use my current HW for AzStack HCI?
- Inventory your current hardware and software.
- Compare your current infrastructure against the Azure Stack HCI 23H2 requirements.  
Some hints:
- How is the servers local storage presented to the OS? (Raid Controller or Host Bus Adapter?) ---> [does HCI support RAID controllers?][NoSupportForRaidController]
- Do my network adapters support RDMA for high performant storage traffic? [RDMA for storage][StorageStandard] go and find your adapter on the Windows Server Catalog [WindowsServerCatalog][WindowsServerCatalog]
Switches: Support RDMA PFC,....
Disks: 


Here is how a minimal setup could look like:  


**Exercise 3:** Planning for Scalability and Performance
Objective: Plan your Azure Stack HCI 23H2 deployment for scalability and performance based on your organization's needs.

Tasks:
Estimate your organization's workload requirements by creating a table of VMs and its sizes:  

| Name | RAM (GB) | vCPU | Storage (GB) | OS | Purpose & Annotations (IOPS, Bandwith requirements, VLANID,...) | 
|--|--|--|--|--|--|
|  FS01| 16 | 8 | 128 + 500 | Win Srv 2016 | FServer user profiles 1 (60K8kIOPS, 10Gbit) |
|  VDI01| 8 | 4 | 128 | Win Srv 2012R2 | VDI-1 (10K8kIOPS, 1Gbit) |
|  VDI02| 8 | 4 | 128 | Win Srv 2012R2 | VDI-2 (10K8kIOPS, 1Gbit) |
|  FW01| 8 |6 | 96 | Ubuntu 22.04 | FWall (2x10Gbit) |
|  |  |  |  |  |

[bfrank] ToDo: Add sample Excel sheet here

Determine the optimal configuration for storage, compute, and networking to meet these requirements.
Document a scalability plan that includes potential future growth.
Exercise 4: Cost Estimation and Optimization
Objective: Estimate the cost of deploying Azure Stack HCI 23H2 and explore ways to optimize spending.

Tasks:

Use the Azure Pricing Calculator to estimate the cost of Azure Stack HCI 23H2.
Identify potential areas for cost savings, such as reserved instances or hybrid benefits.
Create a cost optimization plan that balances performance with cost-efficiency.
Exercise 5: Implementing a Proof of Concept
Objective: Implement a proof of concept (PoC) for Azure Stack HCI 23H2 to validate your planning and configurations.

Tasks:

Set up a small-scale Azure Stack HCI 23H2 environment based on your planning.
Deploy a test workload and monitor its performance.
Adjust your configuration based on the performance data and retest as necessary.
Exercise 6: Review and Documentation
Objective: Review the outcomes of your PoC, document the final configuration, and plan for deployment.

Tasks:

Document the tested and optimized configuration for Azure Stack HCI 23H2.
Outline the steps for deploying Azure Stack HCI 23H2 in your production environment.
Prepare a deployment checklist based on lessons learned during the PoC.
These exercises are designed to guide you through the process of right-sizing Azure Stack HCI 23H2 for your organization, from understanding requirements to planning, cost estimation, and implementing a proof of concept.  

[🔼 hands-on-labs](../readme.md) | [2 - deployment ▶](../2%20-%20deployment/readme.md)