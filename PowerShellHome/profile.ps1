#
# Profile.ps1 - main powershell profile script
# 
# Applies to all hosts, so only put things here that are global
#
write-host "starting powershell"
# Helper functions for all interfaces
function Test-LocationFromPath{
	param ($path)
	if (Test-Path $path) {
	    return $path
	}else{
		# test if on C or D drive, can be expanded
		if (Test-Path "D:$path"){
			return "D:$path"
		}else{
			if(Test-Path "C:$path")
			{
				return "C:$path"
			}
		}
	}
}

function Set-LocationFromPath{
	param ($location)
	Write-Host "Setting Path to $location"  -foregroundcolor Cyan 
	if(Test-Path $location){
		Set-Location $location
	}else{
		# test if on C or D drive, can be expanded
		if (Test-Path "D:$location"){
			Set-Location "D:$location"
		}
		elseif(Test-Path "C:$location")
		{
			Set-Location "C:$location"
		}
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


function FindSetProjectDirectory{
	$findHome = "\Projects"
  
	if (Test-Path "\\psf\Home$findHome") {
		$findHome = "\\psf\Home$findHome"
	    write-host "setting project home to $findHome"
	    $global:projectdir = "$findHome"
	    FindSetCreateDependancyDirectory
	}else{
		if (Test-Path "C:$findHome") {
		 	write-host "setting project home to $findHome"
		    $global:projectdir = "C:$findHome"
		    FindSetCreateDependancyDirectory
		}else{
			if (Test-Path "D:$findHome") {
				write-host "setting home to $findHome"
				$global:projectdir = "D:$findHome"
				FindSetCreateDependancyDirectory
			}else{
				write-host "project folder not found, setup before the script will continue`n" -foregroundcolor red
				Break
			}
		}
	}
}

function FindSetHomeDirectory{
	$findHome = "$global:projectdir\WindowsPowerShell"
  	if (Test-Path $findHome) {
   		$global:homedir = $findHome
	}else{
		Write-Host "home could not be found"
	}
	
	# Check for and load profile.
	$location = "$global:homedir\MyPowerShellProfile\Commands\profile.ps1"

	if (Test-Path $location){
		. $location
	}else{
		Write-Host "could not find profile.ps1 -- $location"
	}
}

function FindSetCreateDependancyDirectory{
	if(-not(Test-Path "$projectdir\Dependancies")){
		write-host "create directory $projectdir\Dependancies"
		[system.io.directory]::CreateDirectory("$projectdir\Dependancies")
	}
	$global:dependancies = "$projectdir\Dependancies"
}

function GetSettings{
	if(Test-Path "$homedir\settings.json"){
		$config = (Get-Content $homedir\settings.json) -join "`n" | ConvertFrom-Json

		if($config.Name){
			$global:profileSettings.Name = $config.Name
		}

		if($config.Email){
			$global:profileSettings.Email = $config.Email
		}

		if($config.LastUpdate){
			$global:profileSettings.LastUpdate = $config.LastUpdate
		}

		if($config.LastSync){
			$global:profileSettings.LastSync = $config.LastSync
		}
	}else{
		write-host "settings does not exist, creating"
		CreateUpdateSettings
	}
}

function CreateUpdateSettings{
	$a = Get-Date
	$global:profileSettings.LastSync = $a.ToUniversalTime()
	$global:profileSettings | ConvertTo-Json | Set-Content $homedir\settings.json -Encoding Unicode
}

$a = Get-Date

$global:profileSettings = @{
	Name = "NotSet";
	Email = "NotSet";
	LastUpdate = $a.ToUniversalTime().AddDays(-2);
	LastSync = $a.ToUniversalTime().AddDays(-2);
}

FindSetProjectDirectory
FindSetHomeDirectory
GetSettings

CreateUpdateSettings