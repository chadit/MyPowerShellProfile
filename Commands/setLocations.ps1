#This will load functions into the powershell console
#See bottom if you want to add an alias to the list

# work related locations
function Set-APvX{
	$location = "\Projects\Work\NeoGen\APvXDev\APvX"
	Set-LocationFromPath ($location)
}

function Set-APvX_Service{
	$location = "\Projects\Work\NeoGen\APvXDev\APvX_ServiceLayer"
	Set-LocationFromPath ($location)
}

function Set-APvX_Shared{
	$location = "\Projects\Work\NeoGen\APvXDev\APvX_Shared"
	Set-LocationFromPath ($location)
}

function Set-APvX_Db{
	$location = "\Projects\Work\NeoGen\APvXDev\APvX_DB"
	Set-LocationFromPath ($location)
}

function Set-BarcodeServices{
	$location = "\Projects\Work\NeoGen\NeoBarCodesDev\BarcodeServices"
	Set-LocationFromPath ($location)
}

function Set-NeoLabels{
	$location = "\Projects\Work\NeoGen\NeoBarCodesDev\NeoLabels"
	Set-LocationFromPath ($location)
}

function Set-NeoLabelsCommon{
	$location = "\Projects\Work\NeoGen\NeoBarCodesDev\LabelsCommon"
	Set-LocationFromPath ($location)
}

function Set-TfsNeoProject{
	$location = "\Projects\Work\NeoGenomics"
	Set-LocationFromPath($location)
}

function Set-NeoTfsBarcodeRoot {
	$location = "\Projects\Work\NeoGenomics\Neo Barcodes"
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
	$location = "\Users\$env:username\Dropbox"
	Set-LocationFromPath ($location)
}
function Set-SkyDrive{
	$location = "\Users\$env:username\SkyDrive"
	Set-LocationFromPath ($location)
}
