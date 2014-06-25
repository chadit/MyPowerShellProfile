#This will load functions into the powershell console
#See bottom if you want to add an alias to the list

# work related locations
function Set-CM_Service{
	$location = "\Projects\CallMiner\git\ServiceFramework"
	Set-LocationFromPath ($location)
}

function Set-WorkProject{
	$location = "\Projects\CallMiner\git"
	Set-LocationFromPath ($location)
}

function Set-CM_API{
	$location = "\Projects\CallMiner\git\CallMinerApi"
	Set-LocationFromPath($location)
}

# home related locations
function Set-ChlodnyWebApi{
	$location = "\Users\$env:username\Dropbox\Source\Examples\ChlodnyWebApi"
	Set-LocationFromPath ($location)
}

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

function Set-Source{
	$location = "$dropbox\Source"
	Set-LocationFromPath($location)
}
