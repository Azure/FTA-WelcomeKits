# PowerShell Tips for HCI Deployment and Management

When deploying and managing an HCI cluster, customers will frequently need to delve into PowerShell. For those who are unfamiliar with it, this can present a learning curve. Below are some tips and tricks to help get you started.

## PowerShell Remoting

PowerShell remoting is a great way to manage your HCI nodes from a central location and perform one-to-many tasks. Configuring your nodes using remote PowerShell commands run in parallel against all nodes have the added benefits of ensuring nodes are consistent while improving your efficiency.

PowerShell remoting is enabled on HCI nodes by default, requiring no additional configuration. On your workstation, you may need to configure the local WinRM client with `winrm quickconfig`.

### Authentication

#### TrustedHosts

To authenticate to your HCI nodes before they are domain-joined, you'll need to configure your client system to permit sending credentials to the nodes. To do this, modify your TrustedHosts list with a command like below:

  ```powershell
  
  $nodeIPsList = '<node 1 IP>,<node 2 ip>,…'
  $existingTrustedHostsList = Get-Item WSMan:localhost\Client\TrustedHosts

  # handle existing trusted hosts list
  If ($existingTrustedHostsList) {
    $existingTrustedHostsList
    Set-Item WSMan:localhost\Client\TrustedHosts -Value "$($existingTrustedHostsList.Value),<node 1 IP>,<node 2 ip>,…"
  }
  Else {
    Set-Item WSMan:localhost\Client\TrustedHosts -Value $nodeIPsList
  }
  ```

#### CredSSP

CredSSP allows double-hop authentication with remote PowerShell. This means that you can authenticate a connection to a second system from within your PowerShell remoting session. This can be important for HCI when interacting with the cluster or running a test that connects to other systems. To enable CredSSP, you need to configure it both on your client and on the HCI system you connect to:

Client: `Enable-WSManCredSSP -Role Client -DelegateComputer <HCI Node name or IP as used in New-PSSession or Enter-PSSession>`

Server: `Enable-WSManCredSSP -Role Server`

Then, when you create the connection, add the `-Authentication CredSSP` AND provide explicit credentials with `-Credential (Get-Credential)`. The credential provided will need to be valid for both the initial HCI system you connect to and the second system(s).

### Connecting to a remote system

You can connect to a remote system by entering a PS session, from which you can run many commands, see results, etc. This is an alternative to Remote Desktop or BMC console access to the system. 

```powershell
$cred = Get-Credential
Enter-PSSession <remote system name or IP> -Credential $cred [-Authentication CredSSP]
```

### Running commands against many remote systems

Another option is to create a variable containing one or more PS sessions, and run commands against all those sessions at the same time. This works great once you know the commands you need to run and are ready to apply them to all nodes. 

```powershell
$cred = Get-Credential
$sessions = New-PSSession node1,node2,node3 -Credential $cred [-Authentication CredSSP]

icm $sessions {command to run}
```

Example Arc initialization using PS remoting, passing an ARM token as a parameter:

```powershell
$cred = Get-Credential
$sessions = New-PSSession node1,node2,node3 -Credential $cred

$t = Get-AzAccessToken | % token

icm $sessions {
    $t = $args[0]

    Install-PackageProvider -Name NuGet -confirm:$false -force
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
    Install-Module Az.Resources,AzsHCI.ARCinstaller
    Set-PSRepository -Name PSGallery -InstallationPolicy Untrusted

    invoke-AzStackHciArcInitialization -SubscriptionID <hardcode> -ResourceGroup <hardcode> -TenantID <hardcode> -Cloud AzureCloud -AccountID <hardcode> -Region <hardcode> -ArmAccessToken $t
} -session  -argument $t

```

### CIM Sessions

An alternative to PSSessions, CIM sessions are especially useful for certain commands which accept a -CIMSession parameter, such as those related to networking. In the example below, I get a list of all NICs and their driver providers, then I set a VLAN on my management NICs.

```powershell
  $cred = Get-Credential
  $cimsessions = New-CIMSession node1,node2,node3 -Credential $cred

  Get-NetAdapter -CimSesssion $cimsessions | select name,interfacedescription,driverprovider

  Set-NetAdapterAdvancedProperty -InterfaceAlias mgmt -CimSession $cimsessions -DisplayName 'VLAN ID' -DisplayValue 123
```

Another note: once my systems are domain-joined and I can access them with my domain account, I can skip pre-creating the CIM sessions and just pass an array of node names. This doesn't work before domain join because I can't pass a credential explicitly. For example:

```powershell
  Set-NetAdapterAdvancedProperty -InterfaceAlias mgmt -CimSession node1,node2,node3 -DisplayName 'VLAN ID' -DisplayValue 123
```


## Viewing log files

On Windows Core in a Remote Desktop session, log files can be opened in Notepad with the command `notepad <pathToFile>`. However, if you are using PowerShell remoting or want to watch a log for activity, you'll probably want to use `Get-Content`.

`Get-Content` is also aliased with `gc` and `cat`, so you can use those instead. 

### Get the last 150 lines of a file

`Get-Content .\my.log -Last 150`

### Get the last 150 lines of a file and keep the file open, printing new changes to the screen

`Get-Content .\my.log -Last 150 -Wait`

## Finding the source code

To find the source code where the error you are hitting is being generated, so you can view the context or reproduce it outside of the deployment, search for the PowerShell module with the script below. Note, the string you search for in the Select-String statement should be generic; instead of searching for 'network interface error on "node01"', just search for 'network interface error on' since the script will not have your node name (for example).

  ```powershell
  Get-ChildItem -Path / -Include *.psm1 -Recurse | Select-String 'command or message to find'
  ```

## Command History

PowerShell keeps a persistent history of the commands you have run for easy retries and history. To use the history:

- `Up Arrow`: Cycles through the most recent commands executed. Easy way to retry quickly. 
- `Ctrl + r`: Backward search of your command history. For example, if I wanted to re-run my Arc initialization, I could hit `ctrl + r` then start typing 'Invoke-AzureStack...'. To reuse a command, hit `Right Arrow` or to keep searching back, press `Ctrl + r` again.

## Using Template Parameter Objects for ARM/Bicep Deployments

When running an HCI deployment via ARM or Bicep, it is common to need to resubmit the template a few times as you work through issues. However, many customers want to avoid saving secret data into their parameter files, meaning they need to type or paste these parameters each time. One approach to simplify this process while remaining secure is to convert passwords to secure strings, which can be saved into a file, and then passed as an object to the deployment. 

1. Encrypt each secret with: `read-host -Prompt "enter secret value" -AsSecureString | ConvertFrom-SecureString`
2. Create a PowerShell code snippet which declares a dictionary variable with all the values we're passing to the deployment. For example, mine looks like:

```powershell
$templateParameterObject = @{
    'arbDeploymentServicePrincipalSecret' = (ConvertTo-SecureString '<redacted>' | ConvertFrom-SecureString -AsPlainText )
    'localAdminAndDeploymentUserPass'     = (ConvertTo-SecureString '<redacted>' | ConvertFrom-SecureString -AsPlainText)
    'arbDeploymentSPObjectId'             = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
    'arbDeploymentAppId'                  = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
    'hciResourceProviderObjectId'         = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
    'location'                            = 'southeastasia'
    'deploymentPrefix'                    = -join ((97..122) | Get-Random -Count 5 | ForEach-Object { [char]$_ }) 
    'resourceGroupName' = 'rg-hci'
}
```

3. Before running a deployment, in the same PowerShell window, run the variable declaration snippet you saved like above with your values.
1. This will populate a variable with the name `$templateParameterObject`
1. When running the deployment, use PowerShell splatting to pass the parameters: `New-AzResourceGroupDeployment -templateFile ./main.bicep -templateParameterFile ./hci.parameters.json @templateParameterObject`