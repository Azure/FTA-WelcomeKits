# AVD Deployment Guides On Azure Stack HCI  
This is a step-by-step guide on how to deploy and configure Azure Virtual Desktop (AVD) on Azure Stack HCI, ensuring an optimized user experience.  

>**Important Note**: As for now (Oct 2023) AVD on HCI (22H2) is in preview, i.e. things will change so please be prepared and consult this document for future changes.  
[Azure Virtual Desktop for Azure Stack HCI overview (preview)](https://learn.microsoft.com/en-us/azure/virtual-desktop/azure-stack-hci-overview)

## Requirements (For AVD On Azure Stack HCI)
Prior planning an installation visit [Set up Azure Virtual Desktop for Azure Stack HCI (preview)](https://learn.microsoft.com/en-us/azure/virtual-desktop/azure-stack-hci#prerequisites) to see the prerequisites for AVD on HCI.  
Most important: You need...
- a registered working Azure Stack HCI cluster 
- have an Active Directory sync'ed with your Microsoft Entra ID (formerly known as Azure Active Directory) 
- a valid Azure subscription with owner privileges.
  
## Currently There Are 2 Options Of Deploying AVD On HCI: 
Both have pros and cons and might (will) change in the future. 
1. **Option 1**: Will provide you automation via the Azure Portal (Azure Arc). I.e. you can create AVD desktop VMs hosted on your Azure Stack HCI using the portal wizard or an ARM template. For this to work you need to enable *Azure Arc VM management* by installing a feature called *Azure Resource Bridge*. This requires time, planning and maintenance. The idea will last but the process of installation will change when HCI 23H2 is released.  
***Do this** when you have time, want to learn how the final experience could look like, love Kubernetes, require automation (e.g. ARM) and are ready to redo.*

1. **Option 2**: The Manual Process will get you fast to have an AVD desktop hosted on your HCI. You will learn what it takes and have most freedom of choice / control. Creating a lot of AVD desktops can be teadious with this approach although a lot of steps can (you) be automated with scripting.  
***Do this** when you need to be fast - want to avoid friction (e.g. due to FWalls or proxies) and focus on AVD on HCI.*

## Option 1: For Automated Deployment Of AVD On HCI Via Azure Portal (Azure Arc) Using Azure Arc VM management.
### 1st: You need to enlighten your Azure Portal -> Azure Arc for AVD.  
![prerequisites for AVD on HCI met](./../images/enlightened.png)  
For this checkbox to go green you need to:  
- Set up *Arc VM management*
- Have a Windows image available on the HCI cluster to create AVD desktop VMs from.  
   
See [Arc Resource bridge overview and setup guide](https://learn.microsoft.com/en-us/azure-stack/hci/manage/azure-arc-vm-management-overview).  
Watch the following [video to see Arc VM management in action: Installing a VM from the Azure Portal on HCI](https://www.youtube.com/watch?v=s4vqz1iAgyI&t=2555s).  
Watch [Installing ...Azure Arc Resource Bridge on AzStack HCI using PowerShell (Oct 2022)](https://www.youtube.com/watch?v=s4vqz1iAgyI&t=1516s) for seeing the [Azure Arc VM management deployment workflow](https://learn.microsoft.com/en-us/azure-stack/hci/manage/azure-arc-vm-management-overview#azure-arc-vm-management-deployment-workflow) done. The installation video shows PowerShell code you can find on [github](https://github.com/bfrankMS/AzStackHCI/blob/main/AKS/AKS%2BARB.ps1)

### 2nd: You follow the steps in [Configure Azure Virtual Desktop for Azure Stack HCI via automation](https://learn.microsoft.com/en-us/azure/virtual-desktop/azure-stack-hci#configure-azure-virtual-desktop-for-azure-stack-hci-via-automation)

By the end of this section you should have a set of AVD desktops hosted on your Azure Stack HCI which should be part of an AVD Hostpool e.g.:  
![AVD desktops on HCI HostPool](./../images/hostpool.png)  
The only thing missing is to [Create an application group, a workspace, and assign users in Azure Virtual Desktop](https://learn.microsoft.com/en-us/azure/virtual-desktop/create-application-group-workspace?tabs=portal) and finally [Connect to your desktops and applications](https://learn.microsoft.com/en-us/azure/virtual-desktop/users/connect-windows?tabs=subscribe#connect-to-your-desktops-and-applications).

## Option 2: Manual Process For Deploying AVD Desktops On HCI
Here is the list of manual steps:  
- Download the VDI image from the Azure marketplace you want to use.
- (optional) Optimize image i.e. the *.vhdx* to save disk space.
- (optional - but likely) Create a VM for golden image creation: E.g. to install your language packs -> sysprep
- (optional) FSLogix: Prepare a SMB file share (provide profile share with correct ACLs)
- (optional) FSLogix: Prepare a GPO for the AD OrgUnit (OU) the VDIs will be joined to.
- Deploy a empty AVD Hostpool in Azure.
- Create a Application Group for this Hostpool and allow an AAD User Group access to it.
- Create a Workspace containing the App Group created before.
- Deploy a VDI VM on HCI using the VDI image (from vhdx obtained in a previous step)
- Deploy the AVD Agents into the VDI VM
- Deploy the Remote Desktop App for the User
- (When using Win 10|11 multisession) - Enable Azure Benefits
- (optional) when you are using proxies for the session hosts.
- (optional) Publish NotepadPlusPlus in your AVD Application Group

Lucky you!...  
...there is a video tutorial [Azure Stack HCI - Hybrid Series - Azure Virtual Desktop (AVD)](https://www.youtube.com/watch?v=pXI576Idx-c&list=PLDk1IPeq9PPeVwlvJZgo4n8Mw9Qj5gW0L&pp=gAQBiAQB) on how to do it.  
![Youtube playlist AVD on HCI](./../images/ytplaylist.png)  
...and the PowerShell scripts being used are parked here: [How To Deploy AVD On AzStack HCI](https://github.com/bfrankMS/AzStackHCI/blob/main/AVD/readme.md)