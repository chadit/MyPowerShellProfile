# update this location to point to the path of PowerShellProfile.ps1

$possibleProfileLocations = @("\Projects\WindowsPowerShell\MyPowerShellProfile\Commands\PowerShellProfile.ps1","$homedir\MyPowerShellProfile\Commands\PowerShellProfile.ps1", "\Users\$env:username\Dropbox\Documents\WindowsPowerShell\MyPowerShellProfile\Commands\PowerShellProfile.ps1", "\Cloud\Dropbox\Documents\WindowsPowerShell\MyPowerShellProfile\Commands\PowerShellProfile.ps1")
foreach ($profileLocation in $possibleProfileLocations){
if (Test-Path "$profileLocation"){
write-host "profileLocation $profileLocation"
. "$profileLocation"
break
}

if (Test-Path "C:$profileLocation"){
write-host "profileLocation $profileLocation"
. C:"$profileLocation"
break
}

if (Test-Path "D:$profileLocation"){
write-host "profileLocation $profileLocation"
. D:"$profileLocation"
break
}
}
