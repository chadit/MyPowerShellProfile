#This will load functions into the powershell console
#See bottom if you want to add an alias to the list

# work related locations

# home related locations
function Set-PowerShellProject{
	$location = "\Users\$env:username\Dropbox\Documents\WindowsPowerShell\MyPowerShellProfile"
	Set-LocationFromPath ($location)
}

function Set-Dropbox{
	$location = "\Cloud\Dropbox"
	Set-LocationFromPath ($location)
}
function Set-SkyDrive{
	$location = "\Users\$env:username\SkyDrive"
	Set-LocationFromPath ($location)
}