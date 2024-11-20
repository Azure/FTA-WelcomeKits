[23h2]:./cluster/Deployment-23h2.md
[stretch]:./cluster/Stretch_Cluster_build.md
[22h2]:./cluster/Standard_Cluster_build.md
[sdn]:./sdn/readme.md
[networkatc]:https://learn.microsoft.com/en-us/azure-stack/hci/plan/cloud-deployment-network-considerations#step-3-determine-network-traffic-intents
[azstackhciquickstarttemplates]:https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.azurestackhci

# 2 - deployment: Cluster Deployment Options & Creation

Depending on the cluster architecture selected then the deployment options which are available, and currently which version of Azure Stack HCI will be deployed, either 22H2 or 23H2.  The deployment options are:

- The recommended option is to deploy [Azure Stack HCI 23H2][23h2] as this will:
  - provide cloud based deployment, Azure Resource Bridge (i.e. VM management from Azure), AKS onprem, AVD onprem etc.
  - Deployment from the portal allows up to 3 network intents (see [Network ATC][networkatc]) created at deployment time.
  - If special deployment options are required (e.g. custom IP addresses for storage.) then customized ARM templates must be used.
    - see [Azure Stack HCI Quickstart Templates][azstackhciquickstarttemplates]
- If [stretch cluster][stretch] is required then, currently, 22H2 needs to be deployed.
- If there is a requirement to deploy [Azure Stack HCI 22H2][22H2] then this is still supported and an upgrade for this to 23H2 is expected in coming months
- SDN is an optional (at the moment) post-deployment setup - relevant information can be found here [SDN][sdn].

[◀ 1 - planning](../1%20-%20planning/readme.md) | [🔼 HCI](../../readme.md) | [3 - governance ▶](../3%20-%20governance/readme.md)