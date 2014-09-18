#
# Profile.ps1 - main powershell profile script
# 
# Applies to all hosts, so only put things here that are global
#

# Helper functions for all interfaces
function Test-LocationFromPath{
	param ($path)
	# test if on C or D drive, can be expanded
	if (Test-Path "D:$path"){
		return "D:$path"
	}
	elseif(Test-Path "C:$path")
	{
		return "C:$path"
	}
}

function Set-LocationFromPath{
	param ($location)
	Write-Host "Setting Path to $location"  -foregroundcolor Cyan 
	
	# test if on C or D drive, can be expanded
	if (Test-Path "D:$location"){
		Set-Location "D:$location"
	}
	elseif(Test-Path "C:$location")
	{
		Set-Location "C:$location"
	}
}

# Setup the $home directory correctly
if(Test-LocationFromPath("\Users\$env:username\Dropbox")){
	$global:dropbox = Test-LocationFromPath("\Users\$env:username\Dropbox")
}
elseif(Test-LocationFromPath("\Cloud\Dropbox")){
	$global:dropbox = Test-LocationFromPath("\Cloud\Dropbox")
}

if(Test-LocationFromPath("\Users\$env:username\SkyDrive")){
	$global:skydrive = Test-LocationFromPath("\Users\$env:username\SkyDrive")
}
elseif(Test-LocationFromPath("\Cloud\SkyDrive")){
	$global:skydrive = Test-LocationFromPath("\Cloud\SkyDrive")
}



$global:homedir = "$dropbox\Documents\WindowsPowerShell"

# Check for and load profile.
$location = "$homedir\MyPowerShellProfile\Commands\profile.ps1"

if (Test-Path $location){
	. $location
}



