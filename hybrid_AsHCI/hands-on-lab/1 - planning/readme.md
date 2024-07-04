# 1 - planning: Infrastructure Setup and Integration

## Exercises to Right-Size Azure Stack HCI 23H2
Understanding Azure Stack HCI 23H2 Requirements
Objective: Familiarize yourself with the hardware and software requirements for Azure Stack HCI 23H2 to ensure a successful deployment.

Research to find the Answers on the following questions:
- Your Azure Stack HCI cluster (23H2) can contain ___ to ___ nodes.
- Identify the software prerequisites needed for Azure Stack HCI 23H2.


**Exercise 2:** Assessing Your Current Infrastructure
Objective: Assess your current infrastructure to determine if it meets the requirements for Azure Stack HCI 23H2.

**Tasks:**
- Inventory your current hardware and software.
- Compare your current infrastructure against the Azure Stack HCI 23H2 requirements.

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