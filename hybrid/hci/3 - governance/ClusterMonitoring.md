[hciinsightssingle]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/monitor-hci-single?tabs=22h2-and-later
[hciinsightsmultiple]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/monitor-hci-multi
[arcenabledservers]:https://learn.microsoft.com/en-us/azure/azure-arc/servers/overview
[connectedmachineagent]:https://learn.microsoft.com/en-us/azure/azure-arc/servers/agent-overview
[ama]:https://learn.microsoft.com/en-us/azure/azure-monitor/agents/agents-overview
[dcr]:https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/data-collection-rule-overview
[eventlogcollection]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/monitor-hci-multi#viewing-and-changing-the-dump-cache-interval
[servereventid]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/monitor-hci-multi#server-event-3000-rendereddescription-column-value
[driveeventid]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/monitor-hci-multi#drive-event-3001-rendereddescription-column-value
[volumeeventid]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/monitor-hci-multi#volume-event-3002-rendereddescription-column-value
[vmeventid]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/monitor-hci-multi#virtual-machine-event-3003-rendereddescription-column-value
[clustereventid]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/monitor-hci-multi#cluster-event-3004-rendereddescription-column-value
[sentinel]:https://learn.microsoft.com/en-us/azure/sentinel/overview
[alerts]:https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-overview
[actiongroups]:https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/action-groups
[createalerts]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/setup-hci-system-alerts
[alertsfrominsights]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/setup-hci-system-alerts#set-up-alerts-using-insights
[kusto]:https://learn.microsoft.com/en-us/azure/data-explorer/kusto/query/
[kustolivelearn]:https://www.youtube.com/watch?v=9NZDQDcdNVI
[azureworkbooks]:https://learn.microsoft.com/en-us/azure/azure-monitor/visualize/workbooks-create-workbook
[insightsvideo]:https://youtu.be/mcgmAsNricw
[azuremonitorworkbooks]:https://www.youtube.com/watch?v=Z5xRyy3HB8U
[azuremonitorworkbooktabs]:https://www.youtube.com/watch?v=3XY3lYgrRvA
[azuremonitorworkbookparamters]:https://www.youtube.com/watch?v=EC7n1Oo6D-o&t=142s
[azuremonitorworkbookvisualizations]:https://learn.microsoft.com/en-us/azure/azure-monitor/visualize/workbooks-visualizations
[wacdeploymentoptions]:https://learn.microsoft.com/en-us/windows-server/manage/windows-admin-center/plan/installation-options
[wacaddcluster]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/monitor-cluster#add-and-connect-to-an-azure-stack-hci-cluster
[wacviewcluster]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/monitor-cluster#monitor-using-windows-admin-center-dashboard
[wacviewvms]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/monitor-cluster#monitor-virtual-machines
[wacviewnodes]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/monitor-cluster#monitor-servers
[wacviewvolumes]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/monitor-cluster#monitor-volumes
[wacviewdrives]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/monitor-cluster#monitor-drives
[wacviewvmswitches]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/monitor-cluster#virtual-switches
[wacworkspaces]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/monitor-cluster#add-counters-with-the-performance-monitor-tool
[hypervbottleneck]:https://learn.microsoft.com/en-us/windows-server/administration/performance-tuning/role/hyper-v-server/detecting-virtualized-environment-bottlenecks
[cluserperformancehealth]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/health-service-cluster-performance-history
[healthservicefaults]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/health-service-faults
[healthserviceactions]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/health-service-actions
[healthservicesettings]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/health-service-settings
[storagejobsoverview]:https://learn.microsoft.com/en-us/azure-stack/hci/concepts/understand-storage-resync#about-storage-resync
[storagejobsmonitor]:https://learn.microsoft.com/en-us/azure-stack/hci/concepts/understand-storage-resync#how-to-monitor-storage-resync
[getstoragejob]:https://learn.microsoft.com/en-us/azure-stack/hci/concepts/understand-storage-resync#how-to-monitor-storage-resync-in-windows-server-2016
[getvirtaldisk]:https://learn.microsoft.com/en-us/powershell/module/storage/get-virtualdisk?view=windowsserver2022-ps


# Welcome Kit - Azure Stack HCI - Monitoring - Draft


Welcome to the "Azure Stack HCI - Monitoring Welcome Kit." This comprehensive guide is designed to provide you with essential insights into the areas of focus and consideration when planning and designing your Azure Stack HCI Monitoring. As part of your preparation before engaging with Microsoft engineers, this resource aims to demystify these technologies, offering clear explanations and answers to frequently asked questions. Whether you're new to these concepts or seeking to deepen your understanding, this Welcome Kit is your stepping stone to navigating the world of modern cloud-native solutions. 

## Azure Stack HCI Insights

There are some predefined Azure Insights for Azure Stack HCI and these are a predefined set of data to be collected and visualization.  These can be enabled for a [single cluster][hciinsightssingle] or [multiple clusters][hciinsightsmultiple] to allow for a single pain of glass to see the status of your Azure Stack HCI Estate.  This process then automates the installation of the agent and the association of the Data Collection Rule

### Azure Arc Enabled Servers

As part of the registration of Azure Stack HCI each of the nodes in the cluster as Arc [Enabled][arcenabledservers].  This is performed at a cluster level so that any additional nodes which are added to the cluster are automatically Arc Enabled.  The benefits of this is that yiu can the use Azure to Govern, Protect, Configure and Monitor the servers.  This is performed by installing the [Connected Machine Agent][connectedmachineagent] onto the node so that the each of the nodes is represented as a resource within the Azure Portal, under Azure Arc. 

For this topic we will concentrate on the Monitoring aspect which is performed with the deployment of the [Azure Monitor Agent (AMA)][ama] and the association of a predefined [Data Collection Rule (DCR)][dcr].  These are enabled at a cluster level which again allows for the deployment of these to any new nodes added to the cluster without any user intervention required.

### Data collection

As mentioned above the DCR is associated with the agent installed onto the node and has 2 part od configuration.  The first is the Log Analytics Workspace and the second are is the definition of the data which is collected in this case there are 5 performance counters and 2 Event Log Channels.

#### Performance Counters

The performance counters are collected from each of the nodes and by default are at 60 seconds increments.  The performance counters which are collected are:

 - Memory()\Available Bytes
 - Network Interface()\Bytes Total/sec
 - Processor(_Total)\% Processor Time
 - RDMA Activity()\RDMA Inbound Bytes/sec
 - RDMA Activity()\RDMA Outbound Bytes/sec

These are collected at an individual node level, and to change the collection interval for these is change within the DCR.

#### Event Log Channel

There are 2 specific Event Log Channels which are gathered and they are

- microsoft-windows-health/operational
- microsoft-windows-sddc-management/operational

**microsoft-windows-health/operational**

The Event Log Channel microsoft-windows-health/operational is any faults of cluster, nodes or volumes. 


**microsoft-windows-sddc-management/operational**

The Event Log Channel microsoft-windows-sddc-management/operational is a collection of data which is gathered periodically about the cluster.  By default these are gathered every one hour but these can be [changed using PowerShell][eventlogcollection] (these commands should be ran on one of the Azure Stack HCI Nodes).

The data within the microsoft-windows-sddc-management/operational event log channel creates a separate event ID for 5 different components:

- [Server][servereventid] is event ID 3000 and gathers data such as memory (total and used), CPU usage, up time, build and any alerts of each of the nodes
- [Drive][driveeventid] is event ID 3001 and gathers data such model, capacity (total and used) and any alerts of each of the physical disks 
- [Volume][volumeeventid] is event ID 3002 and gathers data such name, size (total and used), IOPS, Latency, Throughput and any alerts of each of the volumes
- [VM][vmeventid] is event ID 3003 and gathers data such status of and any alerts of VM's on the cluster
- [Cluster][clustereventid] is event ID 3004 and gathers data such as memory (total and used), CPU usage, volume (total, used, Latency, IOPS and Throughput) and any alerts across the cluster as a whole

The data is gathered and presented in an XML format, this means that when using the data this does need to be parsed to be consumed.

**Additional Data**

It is possible to gather other performance counters and Event Log Channels. This could either be by modifying the DCR which is created or, as the AMA is using, it is possible to add multiple DCR's to a single resource, for example you there is a standard DCR which gathers security events and sends these to a log analytics workspace used by [Azure Sentinel][sentinel] then this can be associated with the nodes.

### Using the Data

Once all of this data is gathered, there are 2 main uses of the data and these are Alerting and Visualization

#### Alerting

With the use of [Azure Monitor Alerts][alerts] this data can be used to trigger alerts which can then execute [Action Groups][actiongroups] to email, send SMS or invoke webhooks to perform remedial actions.  Also these can be linked into your ITSM Tool for tracking.

The creation of the alerts can be within the [Azure Stack HCI Insights][alertsfrominsights] or [manually][createalerts].  This does require the use of the Kusto Query Language (KQL) and some of the resources below can help with this:

- [Kusto Overview][kusto]
- [Kusto Live Learn Session][kustolivelearn]


#### Visualization  

With the Azure Stack Insights there is an [out of the box dashboard][insightsvideo] which provides the visualization of the data but there is the option to display that data that is important to you.  This can be complete using [Azure Monitor workbooks][azureworkbooks].  As with this the actual data is surfaced using KQL so the above links will be useful, also also the following are regarding he creation of the actual workbook:

- [Workbooks][azuremonitorworkbooks]
- [Using Tabs][azuremonitorworkbooktabs]
- [Using Parameters][azuremonitorworkbookparamters]
- [Using Visualizations][azuremonitorworkbookvisualizations]

## Windows Admin Center

Azure Stack HCI Insights allow for more of a historical view of the data and alerting but does not provide the "live" data which might be needed when trying to pinpoint an issue.  Also it can provide the ability monitor the cluster in the event of a "internet outage" when the recent data would not be available as part of the Azure Stack Insights.

### Windows Admin Center Deployment Options

Windows Admin Center (WAC) is a application which can be installed on a Desktop or Server operating system and provides a graphical user interface for common tasks and action but also the ability to see performance data about the clusters and servers it managers.  The most common deployment locations we see for WAC is either on a separate server or workstation on the same site as the cluster, or in a central location, such as Azure, which had line of sight to the clusters it needs to manage using with VPN's or Express Route.

When [deploying WAC][wacdeploymentoptions] there are options to either have this as a standalone instance or make this highly available.

### Monitoring

With Windows Admin Center you can take [add a cluster][wacaddcluster], which also has the option to then add the nodes individually also to allow there direct monitoring.  When the cluster is added this will then provide the following visualization of the cluster:

- [Cluster Overview][wacviewcluster]
- [VM Overview][wacviewvms]
- [Node Overview][wacviewnodes]
- [Volume Overview][wacviewvolumes]
- [Physical Drive Overview][wacviewdrives]
- [VMSwitch Overview][wacviewvmswitches]

As well as seeing these overviews it is also to [create and save Workspaces][wacworkspaces] which can be use pull the realtime performance counters for single or multiple nodes.  There are come common counters which can help [detecting bottlenecks in a virtualized environment][hypervbottleneck].

## Health Service 

Health Service reduces the work required to get live performance and capacity information from your Storage Spaces Direct cluster.

### Cluster Performance Health

When creating the cluster and enabling S2D it enables [cluster performance history][clusterperformancehealth].  With this data you can the view storage related performance data by volume or storage node.

### Health Service Faults

The Health Service constantly monitors your Storage Spaces Direct cluster to detect problems and generate "faults", these are then displayed within WAC and also will be shown in Azure Stack HCI Insights if it is enabled.  These can also be [viewed directly from the cluster][healthservicefaults]

### Health Service Actions

There are a number of faults which will self remediate, such as failing disks and the volume will repair, it is then possible to view any [remediation actions][healthserviceactions].

### Health Service Settings

It is possible to [customize some of these settings][healthservicesettings] such as actions when new disks are added, and also thresholds for some of the alerts.

## Virtual Disk Storage Jobs

When any changes are made to the physical storage, be it a disk failing or being replaced or a node being in maintenance node for a period, [the volumes need to rebuild][storagejobsoverview] to ensure that the copies of the data which is written to the disks affect is updated.  This can [monitored][storagejobsmonitor] and these need to be complete before performing any additional maintenance work.  They can also be seen using [get-storagejob][getstoragejob] and this will show any optimization jobs which periodically run to ensure that storage is data is optimally located, like when adding additional disks or nodes to the storage pool.

Additionally, the status if the virtual disks can be viewed using [get-virtualdisk][getvirtaldisk].