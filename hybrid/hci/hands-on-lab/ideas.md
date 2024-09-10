Brainstorming:
- Add-server scenario (e.g. after a rebuild)
- Do a cluster update
- Do a 23H2 proxy deployment
- Deploy a 23H2 cluster using an ARM template
- Do a cluster upgrade (22H2 -> 23H2)
- How to retrieve Bitlocker recovery (key) when required due to Update (driver/FW) in HW that does prevent all nodes to reboot.(need to enable bitlocker recovery key tools RSAT -> Features to view them on AD )
- (WDAC) add supplemental policy to run custom code ref: https://learn.microsoft.com/en-us/azure-stack/hci/manage/manage-wdac#create-a-wdac-supplemental-policy
- test a migration (Hyper-V, vmware) -> HCI

- Troubleshooting (when errors shows up, where to look for details):
  - TPM not enabled. HW validation : c:\clouddeployment\logs  
  - Typo in Wizard (e.g. domain name wrong) or ARM template. (c:\deployment\unattend.json)
  - Extension installation errors -> where are the log files (c:\packages\plugins\....\status\...status)
  - Network  failing: 
    - e.g. Network ATC RDMA not supported on compute, mgmt nics. 
    - storage VLAN not allowed on switch
    - ARB cannot communicate with mgmt network