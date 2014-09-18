# update this location to point to the path of PowerShellProfile.ps1
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
