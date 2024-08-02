---
title: What is AKS enabled by Azure Arc?
description: Learn about AKS enabled by Azure Arc and available deployment options.
ms.topic: overview
ms.date: 08/02/2024
author: belginceran     
ms.author: belginceran 
ms.reviewer: victorsantana
ms.lastreviewed: 08/02/2024
parent link : https://learn.microsoft.com/en-us/azure/aks/hybrid/aks-overview

---

# What is AKS enabled by Azure Arc?

Azure Kubernetes Service (AKS) enabled by Azure Arc is a managed Kubernetes service that you can use to deploy and manage containerized applications on-premises, in datacenters, or at edge locations such as retail stores or manufacturing plants. You need minimal Kubernetes expertise to get started with AKS. AKS reduces the complexity and operational overhead of managing Kubernetes by offloading much of that responsibility to Azure. AKS is an ideal platform for deploying and managing containerized applications that require high availability, scalability, and portability. It's also ideal for deploying applications to multiple locations, using open-source tools, and integrating with existing DevOps tools.

## When to use AKS enabled by Azure Arc

The following list describes some of the common use cases for AKS, but is not an exhaustive list:

- **Hybrid cloud deployments**: Ideal for organizations looking to run applications across multiple environments, including on-premises and Azure, while maintaining a consistent management layer.
- **Edge computing**: Useful for deploying applications at the edge, where low latency and local processing are critical, such as in retail stores, manufacturing floors, or remote locations.
- **Regulatory and compliance**: Helps to meet specific regulatory and compliance requirements by enabling localized deployment and management of Kubernetes clusters.

## AKS enabled by Azure Arc deployment options

Azure provides you differernt options to install AKS enabled by Azure Arc Clusters. The below are the differrent environments that you can use : 

- **[AKS on Azure Stack HCI 23H2](https://learn.microsoft.com/en-us/azure/aks/hybrid/aks-whats-new-23h2)**: AKS on Azure Stack HCI 23H2 uses Azure Arc to create new Kubernetes clusters on Azure Stack HCI directly from Azure. It enables you to use familiar tools like the Azure portal and Azure Resource Manager templates to create and manage your Kubernetes clusters running on Azure Stack HCI.
- **[AKS Edge Essentials](https://learn.microsoft.com/en-us/azure/aks/hybrid/aks-edge-overview)**: AKS Edge Essentials includes a lightweight Kubernetes distribution with a small footprint and simple installation experience, making it easy for you to deploy Kubernetes on PC-class or "light" edge hardware.
- **[AKS on Windows Server](https://learn.microsoft.com/en-us/azure/aks/hybrid/overview)**: Azure Kubernetes Service on Windows Server (and on Azure Stack HCI 22H2) is an on-premises Kubernetes implementation of AKS that automates running containerized applications at scale, using Windows PowerShell and Windows Admin Center. It simplifies deployment and management of AKS on Windows Server 2019/2022 Datacenter and Azure Stack HCI 22H2.
- **[AKS on VMWare (preview)](https://learn.microsoft.com/en-us/azure/aks/hybrid/aks-vmware-overview)**: AKS on VMware (preview) enables you to use Azure Arc to create new Kubernetes clusters on VMware vSphere. With AKS on VMware, you can manage your AKS clusters running on VMware vSphere using familiar tools like Azure CLI.

# AKS on Azure Stack HCI 23H2 architecture

AKS clusters on Azure Stack HCI use Arc Resource Bridge (also known as Arc appliance) to provide the core orchestration mechanism and interface for deploying and managing one or more AKS clusters. Containerized applications are deployed into AKS clusters.

![AKS on HCI Cluster Architecture](AKSonHCIClusterArch.png)

### Arc Resource Bridge

The Arc Resource Bridge connects a private cloud (for example, Azure Stack HCI, VMWare/vSphere, or SCVMM) to Azure and enables on-premises resource management from Azure. Azure Arc Resource Bridge provides the line of sight to private clouds required to manage resources such as Kubernetes clusters on-premises through Azure. Arc Resource Bridge includes the following core AKS Arc components:

- **AKS Arc cluster extensions**: A cluster extension is the on-premises equivalent of an Azure Resource Manager resource provider. Just as the **Microsoft.ContainerService** resource provider manages AKS clusters in Azure, the AKS Arc cluster extension, once added to your Arc Resource Bridge, helps manage Kubernetes clusters via Azure.
- **Custom location**: A custom location is the on-premises equivalent of an Azure region and is an extension of the Azure location construct. Custom locations provide a way for tenant administrators to use their data center with the right extensions installed, as target locations for deploying Azure service instances.

### AKS clusters

AKS clusters are a high availability deployment of Kubernetes using Linux VMs for running Kubernetes control plane components and Linux node pools. You can deploy additional Windows Server Core-based node pools for running Windows containers. There can be one or more AKS clusters managed by Arc Resource Bridge.

An AKS cluster has 2 major components, as described in the following sections.

#### Control plane nodes

Kubernetes uses control plane nodes to ensure every component in the Kubernetes cluster is kept in the desired state. The control plane also manages and maintains the worker node pools that hold the containerized applications. AKS enabled by Arc deploys the KubeVIP load balancer to ensure that the API server IP address of the Kubernetes control plane is available at all times. Microsoft does not charge you for control plane nodes, since control plane nodes do not host customer applications.

Control plane nodes run the following major components (not an exhaustive list):

- **API server**: Enables interaction with the Kubernetes API. This component provides the interaction for management tools, such as Azure CLI, the Azure portal, or kubectl.
- **Etcd**: A distributed key-value store that stores data required for lifecycle management of the cluster. It stores the control plane state.

#### Linux/Windows node pools

In Kubernetes, a node pool is a group of nodes within a cluster that share the same configuration. Node pools allow you to create and manage sets of nodes that have specific roles, capabilities, or hardware configurations, enabling more granular control over the infrastructure of your AKS cluster. You can deploy Linux or Windows node pools in your AKS cluster. However, you need to have at least 1 Linux nodepool to host the Arc agents to maintain connectivity with Azure.