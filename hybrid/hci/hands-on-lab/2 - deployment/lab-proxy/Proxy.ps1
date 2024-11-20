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

#test
Invoke-WebRequest -Uri www.microsoft.com -UseBasicParsing

#make sure that you have a time server working....
w32tm /config /manualpeerlist:hu.pool.ntp.org /syncfromflags:manual /reliable:yes /update
w32tm /resync /force
w32tm /query /status

#Test-NTPServer
