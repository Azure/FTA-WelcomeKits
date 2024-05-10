[securitybaseline]:https://learn.microsoft.com/en-us/azure-stack/hci/concepts/secure-baseline
[securitybaselinetemplates]:https://github.com/Azure-Samples/azure-stack-edge-deploy-vms/tree/master/Templates
[securitybaselinesettings]:https://learn.microsoft.com/en-us/azure-stack/hci/concepts/secure-baseline#configure-security-during-deployment
[scuritybaselinemodifications]:https://learn.microsoft.com/en-us/azure-stack/hci/concepts/secure-baseline#modify-security-after-deployment
[hvci]:https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/device-guard-and-credential-guard
[bsma]:https://learn.microsoft.com/en-us/windows/security/hardware-security/kernel-dma-protection-for-thunderbolt
[systemguard]:https://learn.microsoft.com/en-us/windows/security/hardware-security/how-hardware-based-root-of-trust-helps-protect-windows
[secureboot]:https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-secure-boot
[vbs]:https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-vbs
[tpm]:https://support.microsoft.com/en-us/topic/what-is-tpm-705f241d-025d-4470-80c5-4feeb24fa1ee
[bitlockervolume]:https://learn.microsoft.com/en-us/azure-stack/hci/manage/volume-encryption-deduplication
[bitlockeroverhead]:https://learn.microsoft.com/en-us/windows/security/operating-system-security/data-protection/bitlocker/faq#is-there-a-noticeable-performance-impact-when-bitlocker-is-enabled-on-a-computer
[smbencryption]:https://learn.microsoft.com/en-us/windows-server/storage/file-server/smb-security
[clustertrafficencrption]:https://techcommunity.microsoft.com/t5/failover-clustering/security-settings-for-failover-clustering/ba-p/2544690
[laps]:https://learn.microsoft.com/en-us/archive/blogs/secguide/remote-use-of-local-accounts-laps-changes-everything
[ata]:https://learn.microsoft.com/en-us/advanced-threat-analytics/what-is-ata
[remotecredguard]:https://learn.microsoft.com/en-us/windows/security/identity-protection/credential-guard/credential-guard-manage
[defenderforidenity]:https://learn.microsoft.com/en-us/defender-for-identity/what-is
[pim]:https://learn.microsoft.com/en-us/entra/id-governance/privileged-identity-management/pim-configure
[credssp]:https://learn.microsoft.com/en-us/windows-server/manage/windows-admin-center/understand/faq#does-windows-admin-center-use-credssp-

# Welcome Kit - Azure Stack HCI - Management - Draft


Welcome to the "Azure Stack HCI - Security Welcome Kit." This comprehensive guide is designed to provide you with essential insights into the areas of focus and consideration when managing your Azure Stack HCI Security. As part of your preparation before engaging with Microsoft engineers, this resource aims to demystify these technologies, offering clear explanations and answers to frequently asked questions. Whether you're new to these concepts or seeking to deepen your understanding, this Welcome Kit is your stepping stone to navigating the world of modern cloud-native solutions. 

## Secure by Design

With the use of the core edition of the operating system and the removal of a large amount of roles and features which would not be need as the operating system of an hypervisor Azure Stack HCI as a much reduce attack surface.  Additionally, there are over 200 security settings which are implemented immediately as part the installation.  

## Security baseline settings for Azure Stack HCI (preview)

The [Security baseline settings for Azure Stack HCI (preview)][securitybaseline] is part of the supplemental pack which can be used for the deployment and and this will then introduce and maintain:

- A Security Baseline
- Secure-Core Core Enablement

To help maintain this baseline then it is recommended to create a new OU which each of the computer objects will be placed and also to disable any GPO inheritence to stop any conflicts with existing policies and the security baseline. 

### Security Baseline

The security baseline is a list of settings which are held in a [template][securitybaselinetemplates] and applied to each of the nodes.  Any changes to the security baseline, which support drift control, should only be modified with the PowerShell module as drift is checked every 90 minutes and the settings will be reverted back to the baseline.  There are a setting which can be applied [during deployment of the cluster][securitybaselinesettings] and then if they are [modified post deployment][securitybaseline] then a reboot may be required.

### Secure Core

Secure core is a set of security capabilities which are built into the hardware, firmware, drivers and Operating System protecting the system during both boot and running stages of the operating system.  The security features which are available, but dependent on the hard not all of these will be available:

- [Hypervisor Enforced Code Integrity (HVCI)][hvci]
- [Boot DMA Protection][bsma]
- [System Guard][systemguard]
- [Secure Boot][secureboot]
- [Virtualisation-based Security(VBS)][vbs]
- [Trusted Platform Module 2.0 (TPM 2.0)][tpm]

### Protecting your data

The protection of your data is key and this needs to be considered not only in transit but also at rest.  While the data is in transit then [SMB Encryption][smbencryption] can be enable to protect the date.  There is an overhead to ending this as the traffic need to be encrypted and then decrypted as it is sent over the network.  By default the traffic is sent as plain text with the option to enable signing or encryption  At rest then [BitLocker for Storage Spaces][bitlockervolume] can be enabled on particular volumes, as with SMB Encryption there is a [overhead][bitlockeroverhead].  the amount of overhead is relational to the throughput occurring on the storage

### ProtectingManagement Traffic 

The [encryption of the management traffic][clustertrafficencrption] can also to key.  By default all cluster traffic is signed but if this traffic is leaves confines of the rack or even locations then there is the option to encrypt the traffic.

### Protecting Identity

Protecting the accounts which are used to access and manages Azure Stack HCI is also important, these include both the local Active Directory and also the Azure Active Directory Accounts.  Some considerations of ways to protect these are:

- [Local Administrator Password Solution (LAPS)][laps] - to allow for the automatic rotation of local account passwords which are then stored securely with Active Directory
- [Microsoft Advanced Threat Analytics (ATA)][ata] - a on-prem solution to help identify any attempts to compromise on-prem accounts
- [Windows Defender Remote Credential Guard][remotecredguard] - allows the kerberos authentication to complete of the device initiating then connection to another (remote) device, meaning if the credentials are never exposed to the remote device incase it has been compromised.
- [Microsoft Defender for Identities][defenderforidenity] - a cloud solution to help identify any attempts to compromise cloud accounts

Each of the solutions are not exclusive to Azure Stack HCI and can be leverage across the whole organization.

Having tightly controlled RBAC permissions and ensure the rules of least privilege are followed.  In certain circumstances, if [rivileged Identity Management][pim] is enabled then these accounts may not be able to be used for certain parts of deployments and management.  In these cases then check within the documentation to see if a service principle can be used as an alternative.

In some organization then CredSSP is blocked due to potential security issues.  If using Windows Admin Centre for the management of the cluster then it is [required that CredSSP is enabled for communication][credssp].