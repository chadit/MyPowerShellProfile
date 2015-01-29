# update this location to point to the path of PowerShellProfile.ps1
$profileLocation = "$homedir\MyPowerShellProfile\Commands\PowerShellProfile.ps1"
write-host "profileLocation $profileLocation"
if (Test-Path "$profileLocation"){
	. "$profileLocation"
}else{
	write-host "could not find profile at default locations, trying legacy locations"
	$profileLocation = "\Users\$env:username\Dropbox\Documents\WindowsPowerShell\MyPowerShellProfile\Commands\PowerShellProfile.ps1"

	if (Test-Path "C:$profileLocation"){
		. "C:$profileLocation"
	}else{
		if(Test-Path "D:$profileLocation"){
			. "D:$profileLocation"
		}else{
			$profileLocation = "\Cloud\Dropbox\Documents\WindowsPowerShell\MyPowerShellProfile\Commands\PowerShellProfile.ps1"
			if (Test-Path "C:$profileLocation"){
				. "C:$profileLocation"
			}else{
				if(Test-Path "D:$profileLocation")
				{
					. "D:$profileLocation"
				}
			}
		}
	}
}