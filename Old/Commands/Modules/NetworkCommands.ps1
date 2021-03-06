# Restart Services Remotely using PowerShell

$service = 'osearch'
$computers = 'emoss1','emoss2','emoss3','emoss4'

foreach ($computer in $computers) {
if (test-connection $computer –count 1)
{
    Restart-Service -InputObject $(Get-Service -ComputerName $computer -Name $service) -Verbose
}
else
{
    write-host "$computer is not accessible" -foregroundcolor red}
}

# -------------------------------------------------------------------------------


function ReinstallService ($serviceName, $binaryPath, $description, $login, $password, $startUpType)
{
    Write-Host "Trying to create service: $serviceName"

    #Check Parameters
    if ((Test-Path $binaryPath)-eq $false)
    {
        Write-Host "BinaryPath to service not found: $binaryPath"
        Write-Host "Service was NOT installed."
        return
    }

    if (("Automatic", "Manual", "Disabled") -notcontains $startUpType)
    {
        Write-Host "Value for startUpType parameter should be (Automatic or Manual or Disabled) and it was $startUpType"
        Write-Host "Service was NOT installed."
        return
    }

    # Verify if the service already exists, and if yes remove it first
    if (Get-Service $serviceName -ErrorAction SilentlyContinue)
    {
        # using WMI to remove Windows service because PowerShell does not have CmdLet for this
        $serviceToRemove = Get-WmiObject -Class Win32_Service -Filter "name='$serviceName'"

        $serviceToRemove.delete()
        Write-Host "Service removed: $serviceName"
    }

    # if password is empty, create a dummy one to allow have credentias for system accounts: 
    #NT AUTHORITY\LOCAL SERVICE
    #NT AUTHORITY\NETWORK SERVICE
    if ($password -eq "") 
    {
        $password = "dummy"
    }
    $secpasswd = ConvertTo-SecureString $password -AsPlainText -Force
    $mycreds = New-Object System.Management.Automation.PSCredential ($login, $secpasswd)

    # Creating Windows Service using all provided parameters
    Write-Host "Installing service: $serviceName"
    New-Service -name $serviceName -binaryPathName $binaryPath -Description $description -displayName $serviceName -startupType $startUpType -credential $mycreds

    Write-Host "Installation completed: $serviceName"

    # Trying to start new service
    Write-Host "Trying to start new service: $serviceName"
    $serviceToStart = Get-WmiObject -Class Win32_Service -Filter "name='$serviceName'"
    $serviceToStart.startservice()
    Write-Host "Service started: $serviceName"

    #SmokeTest
    Write-Host "Waiting 5 seconds to give time service to start..."
    Start-Sleep -s 5
    $SmokeTestService = Get-Service -Name $serviceName
    if ($SmokeTestService.Status -ne "Running")
    {
        Write-Host "Smoke test: FAILED. (SERVICE FAILED TO START)"
        Throw "Smoke test: FAILED. (SERVICE FAILED TO START)"
    }
    else
    {
        Write-Host "Smoke test: OK."
    }

}

public install-Service(){
    $serviceName = "WorkManagerDemoService" 
    $serviceDisplayName = "WorkManager Demo Service" 
    $serviceDescription = "WorkManager Demo Service" 
    $serviceExecutable = "WindowsService1.exe"

# verify if the service already exists, and if yes remove it first 
if (Get-Service $serviceName -ErrorAction SilentlyContinue) 
{ 
    "service already installed, stopping…" 
    # using WMI to remove Windows service because PowerShell does not have CmdLet for this 
    $serviceToRemove = Get-WmiObject -Class Win32_Service -Filter "name=’$serviceName’" 
    $serviceToRemove | Stop-Service 
    $serviceToRemove.delete() 
    "service removed" 
    } 
    else 
    { 
        # just do nothing 
        "service does not exist" 
    }

    "installing service…"

    # detect current execution directory 
    $directoryPath = Split-Path $MyInvocation.MyCommand.Path

    # creating credentials which can be used to run my windows service 
    #$secpasswd = ConvertTo-SecureString "MyPa$$word" -AsPlainText -Force 
    #$mycreds = New-Object System.Management.Automation.PSCredential (".\MyUserName", $secpasswd) 
    # OR 
    #$myCredentials = Get-Credential

    $binaryPath = $directoryPath + "\" + $serviceExecutable

    # creating widnows service using all provided parameters, -displayName $serviceName, -credential $myCredentials 
    New-Service -name $serviceName -displayName $serviceDisplayName -binaryPathName $binaryPath -startupType Automatic -Description $serviceDescription

    Start-Service -Name $serviceName

    Get-Service $serviceName

    "installation completed"

    Pause
}