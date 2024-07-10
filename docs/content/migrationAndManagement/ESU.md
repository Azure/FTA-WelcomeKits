---
title: Extended Security Updates (ESU) for Windows Server
geekdocNav: true
geekdocAlign: left
geekdocAnchor: true
---

# Extended Security Updates (ESU) for Windows Server

Extended Security Updates (ESU) for Windows Server include security updates and bulletins rated critical and important. Before using ESU, you should read Extended Security Updates for Windows Server Overview to understand what ESUs are, how long they're available for, and what your options are.

How you get ESUs depends on where your server is hosted. You can get access to ESUs through the following options.

- **Azure virtual machines**  - Applicable virtual machines (VMs) hosted in Azure are automatically enabled for ESUs and these updates are provided free of charge, there's no need to deploy a MAK key or take any other action. See [Extended Security Updates on Azure](https://learn.microsoft.com/en-us/windows-server/get-started/extended-security-updates-deploy#extended-security-updates-on-azure) to learn more.
- **Azure Arc-enabled servers**  - If your servers are on-premises or in a hosted environment, you can enroll your Windows Server 2012 and 2012 R2 or SQL Server 2012 machines for Extended Security Updates via the Azure portal, connect through Azure Arc, and you'll be billed monthly via your Azure subscription. See [Extended Security Updates enabled by Azure Arc](https://learn.microsoft.com/en-us/windows-server/get-started/extended-security-updates-deploy#extended-security-updates-enabled-by-azure-arc) to learn more. 1
- **Non-Azure physical and virtual machines**  - If you can't connect using Azure Arc, use Extended Security Updates on non-Azure VMs, by using a Multiple Activation Key (MAK) and applying it to the relevant servers. This MAK key lets the Windows Update servers know that you can continue to receive security updates. See [Access your Multiple Activation Key from the Microsoft 365 Admin Center](https://learn.microsoft.com/en-us/windows-server/get-started/extended-security-updates-deploy#access-your-multiple-activation-key-from-the-microsoft-365-admin-center) to learn more.

To learn more about Extended Security Update, we recommend visiting following Microsoft Guide.

[How to get Extended Security Updates (ESU) for Windows Server 2008, 2008 R2, 2012, and 2012 R2 | Microsoft Learn](https://learn.microsoft.com/en-us/windows-server/get-started/extended-security-updates-deploy)

To gain more insides into Extended Security Updates in general, we also recommend watching the following video.

[Extended Security Updates ESU for Windows Server with Azure Arc (youtube.com)](https://www.youtube.com/watch?v=rXvTzdwbK2Y)
