# update this location to point to the path of PowerShellProfile.ps1
$profileLocation = "\Projects\MyPowerShellProfile\Commands\PowerShellProfile.ps1"
if (Test-Path "C:$profileLocation"){
	. "C:$profileLocation"
}
elseif(Test-Path "D:$profileLocation")
{
	. "D:$profileLocation"
}else{
	
	write-host "could not find profile at default locations, trying legacy locations"
	$profileLocation = "\Users\$env:username\Dropbox\Documents\WindowsPowerShell\MyPowerShellProfile\Commands\PowerShellProfile.ps1"

	if (Test-Path "C:$profileLocation"){
		. "C:$profileLocation"
	}
	elseif(Test-Path "D:$profileLocation")
	{
		. "D:$profileLocation"
	}
	else
	{
		$profileLocation = "\Cloud\Dropbox\Documents\WindowsPowerShell\MyPowerShellProfile\Commands\PowerShellProfile.ps1"
		if (Test-Path "C:$profileLocation"){
			. "C:$profileLocation"
		}
		elseif(Test-Path "D:$profileLocation")
		{
			. "D:$profileLocation"
		}
	}
}