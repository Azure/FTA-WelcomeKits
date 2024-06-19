# Update Management with Azure Arc

After the Azure Connected Machine Agent has been deployed to your machines, you are ready to use Azure Update Manager--no additional monitoring agent or workspace required. Instead, Update Manager operations are handled by Arc Extension operations, so that each time you request an assessment or installation, the Update Manager extension is used to execute you request on your Arc Machine.

Unlike the previous version of Azure Update Manager, which relied on Automation Accounts and Log Analytics, the current version stores all data in the Azure Resource Graph.

## What does Update Manager cost?

There are several scenarios for Update Manager, which can make understanding cost confusing. Refer to the Azure Pricing Calculator and [Update Manager FAQs](https://learn.microsoft.com/azure/update-manager/update-manager-faq) for the most up-to-date guidance, but as of this writing use of Update Manager is free for VMs in Azure and for Arc VMs on Azure Stack HCI, but otherwise costs $5/month.

For Arc Machines not in Azure Stack HCI, this means that any time you run an assessment or update operation or have your Arc Machine associated with a  [maintenance schedule](https://learn.microsoft.com/azure/virtual-machines/maintenance-configurations), you will be charged. The only way around this cost is to be already paying for Extended Support Updates or Defender for Servers Plan 2.
