param(
[String]$targetServer, [String]$command
)

$securePath = "C:\Builds\Scripts\secure.text"
$username = "builduser"
$key = (3,4,2,3,56,34,254,222,1,1,2,23,42,54,33,233,1,34,2,7,6,5,35,43)

function GetCred{
if(!(Test-Path $securePath)){
Write-Output "secure file did not exist for build user"
$SecureString = Read-Host -AsSecureString
ConvertFrom-SecureString -SecureString $SecureString -Key $key | out-file $securePath

#read-host -assecurestring | convertfrom-securestring -key $key | out-file $securePath
}
$secret = Get-Content $securePath
$password = $secret | convertto-securestring -key $key
Write-Host "Getting Credentials"
return New-Object System.Management.Automation.PSCredential $username, $password
}

function StopIIS{
Write-Host "start stop $targetServer IIS"
Invoke-Command -ComputerName $targetServer -Credential (GetCred) -ScriptBlock {iisreset /STOP}
Write-Host "end stop $targetServer IIS"
}

function StartIIS{
Write-Host "start start $targetServer IIS"
Invoke-Command -ComputerName $targetServer -Credential (GetCred) -ScriptBlock {iisreset /START}
Write-Host "end start $targetServer IIS"
}

function ReStartIIS{
Write-Host "start restart $targetServer IIS"
Invoke-Command -ComputerName $targetServer -Credential (GetCred) -ScriptBlock {iisreset /RESTART}
Write-Host "end restart $targetServer IIS"
}



switch($command.ToLower()){
stop{StopIIS}
start{StartIIS}
restart{ReStartIIS}

default{
Write-Output "unknown command"
exit(1)
}
}

