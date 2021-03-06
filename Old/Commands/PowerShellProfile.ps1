# Profile setup for the console host shell
# Will not be loaded by other hosts (e.g. VS11 Package Manager)
#
#$Shell = $Host.UI.RawUI
$Shell = (get-host).ui.rawui
$Shell.CursorSize = "100"
$Shell.BackgroundColor="Black"
$Shell.ForegroundColor="Green"
#$Shell.Options.FontName = 'Lucida Sans Console' 
#$Shell.Options.FontSize = 14

$size = $Shell.BufferSize
$size.width=140
$size.height=5000
#$Shell.BufferSize = $size
$size = $Shell.WindowSize
$size.width=140
$size.height=40

$Shell.WindowSize = $size
#cls
#Get if OS is 32 or 64 bit
$os=Get-WMIObject win32_operatingsystem

#setup the location of the users my document folder
$global:documentPath = [environment]::GetFolderPath([environment+SpecialFolder]::MyDocuments)

# Helper functions for user/computer session management
function Invoke-Shutdown { &"$env:SystemRoot\System32\shutdown.exe" -s -t 1}
function Invoke-Reboot { &"$env:SystemRoot\System32\shutdown.exe" -r -t 1}
function Invoke-Logoff { &"$env:SystemRoot\System32\shutdown.exe" -l }
function Invoke-Standby { &"$env:SystemRoot\System32\rundll32.exe" powrprof.dll,SetSuspendState Standby }
function Invoke-Hibernate { &"$env:SystemRoot\System32\rundll32.exe" powrprof.dll,SetSuspendState Hibernate }
function invoke-terminalLock { &"$env:SystemRoot\System32\rundll32.exe" User32.dll,LockWorkStation }

function Test-Administrator{
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)	
}

function Set-TitleBar{
	$userTest = Test-Administrator

	if ($userTest -eq "True"){
		$Admin = " -- Administrator"
	}else{
		$Admin = ""
	}
	$Shell.WindowTitle="$env:username 's Profile : PowerShell Version : " + $PSVersionTable.PSVersion + $Admin + " : " + $os.OSArchitecture
}
#cls

#Set the windows title
Set-TitleBar

Import-Module "$projectdir\WindowsPowerShell\MyPowerShellProfile\Commands\ProfileInitialization.ps1"
Import-Module "$projectdir\WindowsPowerShell\MyPowerShellProfile\Commands\setAlias.ps1"
Import-Module "$projectdir\WindowsPowerShell\MyPowerShellProfile\Commands\Test-Port.ps1"
Import-Module "$projectdir\WindowsPowerShell\MyPowerShellProfile\Commands\Modules\npmnodes.ps1"

#Import-Module "$projectdir\WindowsPowerShell\MyPowerShellProfile\Commands\Modules\MyCommands.psm1"



InitializeAllDependancies
Set-LocationFromPath ($homedir)