function InitializeAllDependancies{
	ImportModules
	CheckRepoSettings
	SyncDependancies

	InitPscx
	InitPoshGit
	InitPostNpm
	InitPoshHg	
}

#----------------------------------------------------------------------#
#          				CheckUpdateDependancies				   		   #
#----------------------------------------------------------------------#
function SyncDependancies{
	$a = Get-Date
	$currentDate = $a.ToUniversalTime()
	$currentDay = $currentDate.DayofYear
	$lastUpdate = $global:profileSettings.LastUpdate.DayofYear
	$aa = $lastUpdate - $currentDay
	write-host $aa
	if($aa -lt 0){
		write-host "Refreshing dependancies"
		SyncPscx
		SyncPoshGit
		SyncPoshNpm
		SyncPoshHg
		$global:profileSettings.LastUpdate = $currentDate
		CreateUpdateSettings
	}
}

function SyncPscx{
	$pscx = "C:\Program Files (x86)\PowerShell Community Extensions\Pscx3\Pscx"
	if(-not(Test-Path $pscx)){
		write-host "Missing Pscx dependancies - Installing PSCX modules"
		Invoke-Expression "choco install pscx"
	}
}

function SyncPoshGit{
	$poshgitProfile = "$projectdir\Dependancies\posh-git\profile.example.ps1"
	if(-not(Test-Path $poshgitProfile)){
		write-host "Missing post-git dependancies - Installing"
		Set-LocationFromPath ($dependancies)
		Invoke-Expression "git clone git@github.com:dahlbyk/posh-git.git"
	}else{
		Set-LocationFromPath ("$dependancies\posh-git")
		Invoke-Expression "git pull"
	}
}

function SyncPoshNpm{
	$poshnpmProfile = "$projectdir\Dependancies\posh-npm\profile.example.ps1"
	if(-not(Test-Path $poshnpmProfile)){
		write-host "Missing post-npm dependancies"
		Set-LocationFromPath ($dependancies)
		Invoke-Expression "git clone git@github.com:MSOpenTech/posh-npm.git"
	}else{
		Set-LocationFromPath ("$dependancies\posh-npm")
		Invoke-Expression "git pull"		
	}
}

function SyncPoshHg{
	$poshProfile = "$projectdir\Dependancies\posh-hg\profile.example.ps1"
	if(-not(Test-Path $poshProfile)){
		write-host "Missing post-hg dependancies"
		Set-LocationFromPath ($dependancies)
		Invoke-Expression "git clone git@github.com:JeremySkinner/posh-hg.git"
	}else{
		Set-LocationFromPath ("$dependancies\posh-hg")
		Invoke-Expression "git pull"
	}
}

#----------------------------------------------------------------------#
#                  				PSCX 3								   #
#----------------------------------------------------------------------#
function InitPscx{
	$pscx = "C:\Program Files (x86)\PowerShell Community Extensions\Pscx3\Pscx"
	if(Test-Path $pscx){
		$scripts = resolve-path "$projectdir\WindowsPowerShell\MyPowerShellProfile\"
		$pscxUserPreference = $pscx	
		# Modules are stored here
		$env:PSModulePath = join-path $pscx modules
	}else{
		Write-Host "failed to find pscx folder"
		Break
	}
}

#----------------------------------------------------------------------#
#                  				Posh-git							   #
#----------------------------------------------------------------------#
function InitPoshGit{
	$poshgitProfile = "$projectdir\Dependancies\posh-git\profile.example.ps1"
	
	if (Test-Path $poshgitProfile)
	{
		write-host "Loading Posh-git" -foregroundcolor Cyan 
		Import-Module $poshgitProfile	
	}
	else
	{
		write-host "failed to find Posh-git folder"
		Break
	}
}

#----------------------------------------------------------------------#
#                  				Posh-npm							   #
#----------------------------------------------------------------------#
function InitPostNpm{
	$poshnpmProfile = "$projectdir\Dependancies\posh-npm\profile.example.ps1"
	
	if (Test-Path $poshnpmProfile)
	{
		write-host "Loading Posh-npm" -foregroundcolor Cyan 
		Import-Module $poshnpmProfile 	
	}
	else
	{
		write-host "could not find Posh-npm folder"
		Break
	}
}

#----------------------------------------------------------------------#
#                  				Posh-hg								   #
#----------------------------------------------------------------------#
function InitPoshHg{
	$poshProfile = "$projectdir\Dependancies\posh-hg\profile.example.ps1"
	
	if (Test-Path $poshProfile)
	{		
		write-host "Loading Posh-hg" -foregroundcolor Cyan 
		Import-Module $poshProfile 	
	}
	else
	{
		write-host "could not find Posh-hg folder"
		Break
	}
}

#----------------------------------------------------------------------#
#                  				Import Modeules						   #
#----------------------------------------------------------------------#
function ImportModules{
	$commandsFolder = "$homedir\MyPowerShellProfile\Commands\Modules"
	if (Test-Path $commandsFolder)
	{	
		write-host "Loading Modules"
		Import-Module $commandsFolder\CleanUpDocuments
		Import-Module $commandsFolder\MyCommands
		Import-Module $commandsFolder\MyCommandsGit
		Import-Module $commandsFolder\MyCommandsTfs
		Import-Module $commandsFolder\path
		Import-Module $commandsFolder\setLocations
		Import-Module $commandsFolder\startApplication
		Import-Module $commandsFolder\ChocolateyInstalls
		#Import-Module "$homedir\MyPowerShellProfile\Commands\Modules\MongoCommands.ps1"
		Import-Module $commandsFolder\\Backup.psm1
	}
	else
	{
		write-host "could not find command folder"
		Break
	}
}


#----------------------------------------------------------------------#
#                  			Validate								   #
#----------------------------------------------------------------------#
function CheckRepoSettings{
	if([string]::IsNullOrEmpty($global:profileSettings.Email)){
		$global:profileSettings.Email = Read-Host "Email address: "
	}

	if([string]::IsNullOrEmpty($global:profileSettings.Name)){
		$global:profileSettings.Name = Read-Host "Name: "
	}



	CreateUpdateSettings
}