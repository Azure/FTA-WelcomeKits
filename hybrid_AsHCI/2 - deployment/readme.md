[23h2]:./cluster/Deployment-23h2.md
[stretch]:./cluster/Stretch_Cluster_build.md
[22h2]:./cluster/Standard_Cluster_build.md
[sdn]:./sdn/readme.md

# Azure Hybrid Welcome Kit - Cluster Deployment

Depending on the cluster architecture selected then the deployment options which are available, and currently which version of Azure Stack HCI will be deployed, either 22H2 or 23H2.  The deployment options are:

- The recommended option is to deploy [Azure Stack HCI 23H2][23h2] as this will provide cloud deployment, Azure Resource Bridge, AKS, AVD etc.  Deployment from the portal allows up to 3 intents created at deployment, does not support custom IP addresses for storage.  If these option required is not possible then ARM or BICEP templates can be used
- If [stretch cluster][stretch] is required then, currently, 22H2 needs to be deployed.
- If there is a requirement to deploy [Azure Stack HCI 22H2][22H2] then this is still supported and an upgrade for this to 23H2 is expected in coming months
- SDN is an optional (at the moment) post-deployment setup - relevant information can be found here [SDN][sdn].

[◀ 1 - planning](../1%20-%20planning/readme.md) | [🔼 hybrid_AsHCI](../readme.md) | [3 - governance ▶](../3%20-%20governance/readme.md)