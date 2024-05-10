# VM Migration Guide for Azure Stack HCI

This guide walks you through options and approaches for migrating VMs from your source environment to your new Azure Stack HCI hardware. Depending on the source hypervisor and downtime considerations, there are several options that fall into two primariy categories:

- **Online Migrations**: With these approaches, the VM stays online during the entire migration process from the source hypervisor to Azure Stack HCI
- **Offline Migrations**: With offline migration types, the VM will be brought offline, either for a short cutover operation or longer, depending on the approach

In general, offline migrations require less pre-requisite software and configuration making them simpler for small environments. Online migrations require more work up front to set up the replication solution, but they also limit downtime and usually provide a more automated experience, beneficial to large environments.

## Migration Challenges

### Disk Conversion

A challenge for customers coming from source hypervisors other than Hyper-v is that they need to convert their VM's disks format to VHDX to be bootable on Azure Stack HCI. This is further complicated by the lack of readily available tools to make this conversion. All the "online" migration tools we have worked with will perform this conversion for you; offline migration approaches are more likely to require you to find a tool to perform this conversion.

### IP Assignment/Network Configuration

For customers who have extended their layer 2 VLANs into Azure Stack HCI, changing IP configuration during migration is usually not required. For example, if you VM was connected to VLAN 240 on your source hypervisor, and you have extended VLAN 240 to your Azure Stack HCI cluster, you can probably move your VM and retain it's IP.

However, if you are changing your network architecture, using new VLANs, or adding Software Defined Networking Virtual Networks, chances are that you will need to re-IP your VMs as part of the migration. Some third-party migration tools and Hyper-v Replica will automate this for you, but other options may require manual steps.

### Data Movement Performance

For customers with many VMs, large VMs, or both, the time it takes to move VM data between the source and Azure Stack HCI can be an issue. Online or replicate and cutover type migrations lessen the impact of lots of data by enabling you to pre-seed most of the VM's data on Azure Stack HCI beforehand, then just copy a smaller data delta when cutting over. If the source and target systems are in close proximity and connected with appropriate switches and NICs, the data migration can also take advantage of technologies like RDMA--depending on the tool performing the move.

## Online Migration Options

For online VM migrations to Azure Stack HCI, customers have the option of either Azure Migrate or a third-party solution. Both require additional components beyond what's included out of the box with Azure Stack HCI.

### Azure Migrate

Today, Azure Migrate supports moving VMs from existing Hyper-v environments to Azure Stack HCI. In late 2023, Azure Migrate will also preview the capability to migrate VMs from VMware to Azure Stack HCI.

Azure Migrate considerations:

- The solution is free and data remains on-premises
- In order to use Azure Migrate, you must also have the Arc Resource Bridge configured. This is how Azure Migrate will provision VM resources on your Azure Stack HCI cluster.
- Requires both 'Source' and a 'Target' applicance VMs to orchestrate the data transfer
- The solution includes other Azure Migrate features, such as Dependency Mapper--a tool which can help customers understand the network relationships between their VMs and plan their migrations to group related VMs together.

### Third-party Online Solutions

Third-party solutions will vary in functionality and requirements, but are typlically backup solutions. These can be especially attractive if you already have a compatible solution deployed and licensed in your environment.

Some example solutions customers have used are:

- Veeam
- Rubrix
- Commvault
- Carbonite
## Offline Migration Options

The "offline" type migration to move to Azure Stack HCI follow a couple approaches:

- **Replicate and Cutover**: With this approach, a snapshot is  taken of the VM's disks and the base VHD(X) or snapshot parent disk is copied to Azure Stack HCI. Then, during the cutover, the VM is powered down and just the snapshots--the difference between the parent VHD(X) and the disk since the snapshot was taken--are copied over to Azure Stack HCI. The copied snapshots are linked and merged to the parent disks on the Azure Stack HCI system, and a new VM is created with the same configuration. The advantage to this approach is that downtime is limit by not needing to wait for a full copy of the VM's disks to copy to Azure Stack HCI.
- **Offline Full Copy**: With this approach, you shut down your VM to be migrated, copy it's data to Azure Stack HCI, and build a new VM using the same harddrive files and configuration settings. You power on the new VM and ensure that it boots and works as expected, then clean up the source VM. This is a simple option for customers with just a few VMs and who can tolerate downtime during data movement. It may also be more feasible for customers coming from a non-Hyper-v hypervisor who need to take the additional step of converting their disk types to VHDX.

### Hyper-v Replica (orchestrated replicate and cutover from Hyper-V)

Although Live Migration from a source Hyper-v cluster to Azure Stack HCI is not possible, you can use the Hyper-v Replica feature to perform an automated replicate and cutover migration from an existing Hyper-v cluster. This is a good option for existing Hyper-v customers as it is simple to configure and can minimize downtime to a couple minutes. Hyper-v Replica will also allow you to assign a new IP address using Failover TCP/IP settings.

### Robocopy (offline full copy)

`Robocopy` is a Windows file copy utility which includes many features to optimize the performance of bulk data trasfers between Windows systems. Robocopy is typically used when performing offline migrations with large amounts of data. A script and process for using Robocopy to move to Azure Stack HCI can be found here: [Robocopy migration script](https://learn.microsoft.com/azure-stack/hci/deploy/migrate-cluster-new-hardware#run-the-migration-script).

## Source Environment Scenario Recommendations

### VMware

- Azure Migrate VMware to Azure Stack HCI preview

### Hyper-v

- Azure Migrate Hyper-v to Azure Stack HCI

### OpenStack

- Third-party solution

### Nutanix

- Third-party solution

## VM Migration Frequently-asked Questions

### Why can't I Live Migrate my VMs from my source Hyper-v cluster to Azure Stack HCI? Aren't they both Hyper-v?

Although technically feasible, there is a licensing limitation which prevents Microsoft from enabling this migration path.

### Can I use Azure Site Recovery to move my VMs?

Currently, ASR only works replicating from Azure Stack HCI to Azure and failing back, so your VMs must already be on Azure Stack HCI for it to come into play.