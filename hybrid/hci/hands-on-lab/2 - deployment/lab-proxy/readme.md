# This Lab Should Demonstratate The Setup Of AzStack HCI With A Proxy Between Internet And HCI Nodes  

>Note: This lab is under construction and only contains rough notes.

## The general setup steps for AzStack (23H2 current) with a Proxy are:
- A. Enable Internet (proxy server) on your (lab) environment (**additional** step)
- B. Import Wininet PS module on every HCI node (**additional** step)
- C. Do the proxy settings (**additional** step)
1. (same as before)[Prepare Active Directory](https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deployment-prep-active-directory)
2. (same as before)[Download the software](https://learn.microsoft.com/en-us/azure-stack/hci/deploy/download-azure-stack-hci-23h2-software)
3. (same as before)[Install the OS](https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deployment-install-os)
4. (**4a is different** see below)[Register with Arc and set up permissions](https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deployment-arc-register-server-permissions?tabs=powershell)
5. (same as before)[Deploy (Azure Portal | ARM template)](https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deploy-via-portal)
 

### A. Enable Internet on Your Lab (in our case DC)
Windows Logo -> type 'Internet Options' -> Connections -> Lan Settings ->
- de-select use *automatically detect settings*
- select *Use a proxy server...*
Address: 192.168.0.254 Port 3128

>You should see the connection logo at the lower right corner tell you that you have 'Internet access'  
>Your proxy server is reachable https://192.168.0.254 -> user: admin Password: ask instructor

### B. Import Wininet PS module on every HCI node  
You may verify that you don't have internet connection using e.g.  
```PowerShell
Invoke-WebRequest -Uri www.microsoft.com -UseBasicParsing
```
this should time out as there is either no name resolution nor a proxy.

```PowerShell
Import-Module c:\temp\wininetproxy.psm1
```  
>Note: Make sure to use your copy of this module by [getting WinInetProxy from PowerShell Gallery](https://www.powershellgallery.com/packages/WinInetProxy/0.1.0) first. Then bring the file onto the HCI nodes.

### C. Do the proxy settings  
This needs to be done on every HCI node using similar code lines - make sure you adjust this to your environment - here is a sample code:  

```PowerShell
# https://learn.microsoft.com/en-us/azure-stack/hci/manage/configure-proxy-settings-23h2
$proxyServer = "192.168.0.254:3128" #e.g. proxy.contoso.com:8080

$BypassList = "localhost,127.0.0.1,*.svc,P00-HCI-1,P00-HCI-2,myhci00clus,192.168.0.2,192.168.0.3,*.myHCI00.org,192.168.0.*"    
# ip each node, netbios node & cluster, ARB IP
# IP address of each cluster member server.
# Netbios name of each server.
# Netbios cluster name.
# *.contoso.com.
# Second IP address of the infrastructure pool. (ARB IP) -> 192.168.0.11  (e.g. when specifying 192.168.0.10 - 192.168.0.30) -> .10 (= cluster), .11 (= ARB IP)

#WinInet
Set-WinInetProxy -ProxySettingsPerUser 0 -ProxyServer $proxyServer -ProxyBypass $BypassList     #  use '*' for domains and whole subnets

#Environment variables
[Environment]::SetEnvironmentVariable("HTTPS_PROXY", "http://$proxyServer", "Machine")  #must be http! (no 's' !!!)
$env:HTTPS_PROXY = [System.Environment]::GetEnvironmentVariable("HTTPS_PROXY", "Machine")

[Environment]::SetEnvironmentVariable("HTTP_PROXY", "http://$proxyServer", "Machine")   
$env:HTTP_PROXY = [System.Environment]::GetEnvironmentVariable("HTTP_PROXY", "Machine")

$no_proxy_bypassList = "localhost,127.0.0.1,.svc,192.168.0.0/24,.myHCI00.org,P00-HCI-1,P00-HCI-2,myhci00clus"  # no * for domains and use CIDR for subnets
[Environment]::SetEnvironmentVariable("NO_PROXY", $no_proxy_bypassList, "Machine")
$env:NO_PROXY = [System.Environment]::GetEnvironmentVariable("NO_PROXY", "Machine")

#WinHTTP
netsh winhttp set proxy $proxyServer bypass-list=$BypassList        #  use '*' for domains and whole subnets
```

The output should be similar to:
```bash
Start proxy Configuration
Proxy is machine wide
AutoDetect is 0
PACUrl is
ProxyServer is 192.168.0.254:3128
ProxyBypass is localhost,127.0.0.1,*.svc,00-HCI-1,00-HCI-2,myhci00clus,192.168.0.2,192.168.0.3,*.myHCI00.org,192.168.0.*
Entered WriteProxySettingsHelper
Entered WriteProxySettingsHelper

Successfully set proxy
Current WinHTTP proxy settings:

    Proxy Server(s) :  192.168.0.254:3128
    Bypass List     :  localhost,127.0.0.1,*.svc,00-HCI-1,00-HCI-2,myhci00clus,192.168.0.2,192.168.0.3,*.myHCI00.org,192.168.0.*

```
Now if you initiate a web request again it should return some html e.g.:  
```bash
PS C:\temp> Invoke-WebRequest -Uri www.microsoft.com -UseBasicParsing


StatusCode        : 200
StatusDescription : OK
Content           :
                    <!DOCTYPE html><html xmlns:mscom="http://schemas.microsoft.com/CMSvNext"
                            xmlns:md="http://schemas.microsoft.com/mscom-data" lang="en-us"
                            xmlns="http://www.w3.org/1999/xhtml"><head>...
RawContent        : HTTP/1.1 200 OK
                    Cache-Status: localhost;detail=no-cache
                    Connection: keep-alive
                    Accept-Ranges: bytes
                    Content-Length: 201253
                    Content-Type: text/html
```

### Perform the steps 1 -> **3 (only)** - as ARC registration requires the proxy to be specified:  
do [steps 1 - **3**](../readme.md) and then come back here to proceed

### 4.a Register with Arc **through proxy**
Onboard your AzStack HCI hosts to Azure using e.g.  
[do this on every HCI node]
```PowerShell
$verbosePreference = "Continue"
$subscription = "a2ba2.........7e6f"    # your subscription ID
$tenantID = "47f4...........aab0"       # your Entra ID 
$rg = "rg-myHCI...."    # an existing RG.
$region = "westeurope"  #or eastus???
$proxyServer = 'http://192.168.0.254:3128'  #new with 1.2408.0.3025 (current version) of AzSHCI.ARCInstaller
$proxyBypass = "localhost;127.0.0.1;*.svc;P00-HCI-1;P00-HCI-2;myhci00clus;192.168.0.2;192.168.0.3;*.myHCI00.org;192.168.0.*"    #new with 1.2408.0.3025 (current version) of AzSHCI.ARCInstaller

Connect-AzAccount -TenantId $tenantID -Subscription $subscription -UseDeviceAuthentication
$armAccessToken = (Get-AzAccessToken).Token
$id = (Get-AzContext).Account.Id
Start-Sleep -Seconds 3
Invoke-AzStackHciArcInitialization -subscription $subscription -ResourceGroup $rg -TenantID $tenantID -Region $region -Cloud 'AzureCloud' -ArmAccesstoken $armAccessToken -AccountID $id -proxy $proxyServer -ProxyBypass $proxyBypass -verbose
```

### Troubleshooting
In case you are running into issues. Consult the HIMDS log of the Azure Connected Machine Agent.
```bash
cd C:\Program Files\AzureConnectedMachineAgent

.\azcmagent.exe show
```
make sure you are using an https proxy: e.g.:  
Using HTTPS Proxy                       : http://192.168.0.254:3128

The Arc agent log should be under: *C:\ProgramData\AzureConnectedMachineAgent\Log\himds.log*


### Setup Azure Resource Group Permissions and Install HCI using the Portal
see [steps 4b - 5](../readme.md)
