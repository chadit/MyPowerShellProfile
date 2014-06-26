$continueProcess = "True" #Loop control to keep the main options open
$policyLevel = Get-ExecutionPolicy
$global:originalSecurityLevel = $policyLevel

function Test-Administrator{  
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)  
}

function InstallBase{
	
	$appCheck = isAppLatest("filezilla") 
	if($appCheck -ne "True"){
		$result = Read-Host "Install FileZilla client (FTP) [Y]"
		if ($_.KeyCode -eq "Enter" -or $result.ToUpper() -eq "Y"){
			cinst filezilla #FileZilla client (FTP)
			Write-Host "File Zilla client has been installed"
		}
	}
	
	$appCheck = isAppLatest("notepadplusplus") 
	if($appCheck -ne "True"){
		cinst notepadplusplus #Notepad++
		Write-Host "Notepad++ has been installed"
	}
	
	$appCheck = isAppLatest("fiddler") 
	if($appCheck -ne "True"){
		cinst fiddler #Fiddler
		Write-Host "Fiddler has been installed"
	}
	
	$appCheck = isAppLatest("vlc") 
	if($appCheck -ne "True"){
		cinst vlc #VLC Player
		Write-Host "VLC Player has been installed"
	}
	
	$appCheck = isAppLatest("ChocolateyGUI") 
	if($appCheck -ne "True"){
		cinst ChocolateyGUI #GUI for Chocolatey
		Write-Host "GUI for Chocolatey has been installed"
	}
	
	$appCheck = isAppLatest("paint.net") 
	if($appCheck -ne "True"){
		cinst paint.net #paint.net
		Write-Host "Paint.net has been installed"
	}
	
	$appCheck = isAppLatest("skype") 
	if($appCheck -ne "True"){
		cinst skype #Skype
		Write-Host "Skype has been installed"
	}
	
	$appCheck = isAppLatest("dropbox") 
	if($appCheck -ne "True"){
		cinst dropbox #DropBox
		Write-Host "DropBox has been installed"
	}
	
	$appCheck = isAppLatest("GoogleChrome") 
	if($appCheck -ne "True"){
		cinst GoogleChrome #Chrome
		Write-Host "Chrome has been installed"
	}
	
	$appCheck = isAppLatest("ilspy") 
	if($appCheck -ne "True"){
		cinst ilspy #IL Spy
		Write-Host "IL Spy has been installed"
	}
	
	$appCheck = isAppLatest("PowerGUI") 
	if($appCheck -ne "True"){
		cinst PowerGUI #PowerGUI
		Write-Host "PowerGUI has been installed"
	}
	
	$appCheck = isAppLatest("evernote") 
	if($appCheck -ne "True"){
		cinst evernote #Evernote
		Write-Host "Evernote has been installed"
	}
	
	$appCheck = isAppLatest("winrar") 
	if($appCheck -ne "True"){
		cinst winrar #WinRAR
		Write-Host "WinRAR has been installed"
	}
}

function InstallVisualStudioAddOns{
	# VS needs to be installed first
	
	$appCheck = isAppLatest("resharper") 
	if($appCheck -ne "True"){
		cinst resharper #Resharper
		Write-Host "Resharper has been installed"
	}
	
	$appCheck = isAppLatest("stylecop") 
	if($appCheck -ne "True"){
		cinst stylecop #StyleCop
		Write-Host "StyleCop has been installed"
	}
	
	$appCheck = isAppLatest("PostSharp") 
	if($appCheck -ne "True"){
		cinst PostSharp #PostSharp
		Write-Host "PostSharp has been installed"
	}
}

function InstallGit{
	#Git setups
	$appCheck = isAppLatest("gitextensions") 
	if($appCheck -ne "True"){
		cinst gitextensions #Git Extentions for VS
		Write-Host "Git Extentions for VS has been installed"
	}
	
	$appCheck = isAppLatest("kdiff3") 
	if($appCheck -ne "True"){
		cinst kdiff3 #kdiff
		Write-Host "kdiff for VS has been installed"
	}
	
	$appCheck = isAppLatest("gittfs") 
	if($appCheck -ne "True"){
		cinst gittfs #Git for TFS
		Write-Host "Git for TFS has been installed"
	}
	
	$appCheck = isAppLatest("poshgit") 
	if($appCheck -ne "True"){
		cinst poshgit #Git for PowerShell
		Write-Host "Git for PowerShell has been installed"
	}
	
#	$appCheck = isAppLatest("gitpad") 
#	if($appCheck -ne "True"){
#		cinst gitpad #Notepad for Git
#		Write-Host "Notepad for Git has been installed"
#	}
}

function InstallGitRepos{

}

function InstallServerBase{
	#Server Setup
	
	$appCheck = isAppLatest("filezilla.server") 
	if($appCheck -ne "True"){
		cinst filezilla.server #FileZilla Server application
		Write-Host "FileZilla Server application has been installed"
	}
}

function SetupChocolatey{
	#cls
	Write-Host "checking if Chocolatey is installed"
	$isChocolatelyUpdated = IsChocolateyInstalled
	#cls
	if($isChocolatelyUpdated -ne "True"){
	
		Write-Host "Chocolatey is either not installed or not the latest"
		Write-Host "Checking security policy"
		$policyLevel = Get-ExecutionPolicy
		
		if($policyLevel -ne "Unrestricted"){
			$continueCheck = "True"
			while($continueCheck -eq "True"){
			
				Write-Host "Your current security policy is set to $policyLevel"
				Write-Host "In order to setup Chocolatey the security policy "
				Write-Host "needs to temporarily be set to unrestricted."
				$response = Read-Host "Would you like to do this? (Y/N)"
				
				if($response.ToUpper() -eq "Y")
				{
					$continueCheck = "False"
					Set-ExecutionPolicy Unrestricted
					$policyLevel = Get-ExecutionPolicy
				
					if($policyLevel -ne "Unrestricted")
					{
						Write-Host "A problem occured while setting execution policy"
						Read-Host "Press any key to continue"
					}
					else
					{
						Write-Host " PowserShell security Policy has been updated"
						Read-Host "Press any key to continue with installation of Chocolatey"
						
						InstallChocolatey
					}
				}
				elseif ($response.ToUpper() -eq "N")
				{
					$continueCheck = "False"
				}
				else
				{
					$continueCheck = "True"
				}
			}
		}
	}
	else
	{
		Write-Host "Chocolatey is installed and up to date"
		Read-Host "Press any key to continue"
		continue
	}
}

function InstallChocolatey{
	iex ((new-object net.webclient).DownloadString('http://bit.ly/psChocInstall'))
	$result = IsChocolateyInstalled
	
	if($isChocolatelyUpdated -eq "True"){
		write-host "`n Chocolatey is installed and up to date `n"
		write-host "`n Please reboot the powershell instance to continue `n"
	}
	else{
		write-host " Chocolatey did not install correctly"
	}
}

function IsChocolateyInstalled{
	$test = cver
	if($test[0].Contains("You have the latest version")){
		return $true
	}
		return $false
}

function SetExecutionPolicy{
	$continueCheck = "True"
	while($continueCheck -eq "True"){
		#cls
		$currentpolicyLevel = Get-ExecutionPolicy		
		Write-Host "Your current security policy is set to $currentpolicyLevel"
		Write-Host "Please select the new security policy level."
		if($policyLevel -ne "RemoteSigned")
		{
			Write-Host "1: RemoteSigned"
		}
		if($policyLevel -ne "AllSigned")
		{
			Write-Host "2: AllSigned"
		}
		if($policyLevel -ne "Unrestricted")
		{
			Write-Host "3: Unrestricted (Never recommended)"
		}
		if($policyLevel -ne "Restricted")
		{
			Write-Host "4: Restricted (Never recommended)"
		}
		Write-Host "`n`nC: Continue"
		Write-Host "Q: Exit Application"
		
		$response = Read-Host "Select Level of security"
		if($response -eq 1){
			Set-ExecutionPolicy RemoteSigned
			$newpolicyLevel = Get-ExecutionPolicy
			if($newpolicyLevel -eq "RemoteSigned"){
				Write-Host "Security policy has been updated to $newpolicyLevel"
				Read-Host "Press any key to continue"
				continue
			}
		}
		if($response -eq 2){
			Set-ExecutionPolicy AllSigned
			$newpolicyLevel = Get-ExecutionPolicy
			if($newpolicyLevel -eq "AllSigned"){
				Write-Host "Security policy has been updated to $newpolicyLevel"
				Read-Host "Press any key to continue"
				continue
			}
		}
		if($response -eq 3){
			Set-ExecutionPolicy Unrestricted
			$newpolicyLevel = Get-ExecutionPolicy
			if($newpolicyLevel -eq "Unrestricted"){
				Write-Host "Security policy has been updated to $newpolicyLevel"
				Read-Host "Press any key to continue"
				continue
			}
		}
		if($response -eq 4){
			Set-ExecutionPolicy Restricted
			$newpolicyLevel = Get-ExecutionPolicy
			if($newpolicyLevel -eq "Restricted"){
				Write-Host "Security policy has been updated to $newpolicyLevel"
				Read-Host "Press any key to continue"
				continue
			}
		}
		if($response.ToUpper() -eq "C")
		{
            $continueCheck = "False"
			continue

		}
		if($response.ToUpper() -eq "Q")
		{
            $continueCheck = "False"
			ExitScript
		}
		
		$isNumber = isNumeric($response)
		if($isNumber -ne "True"){
			Write-Host "Please select a number or Q to quit"
		}
	}
}

function isNumeric ($x) {
    try {
        0 + $x | Out-Null
        return $true
    } catch {
        return $false
    }
}

function isAppLatest ($x){
	$test = cver $x
	if($test[0].Contains("You have the latest version")){
		return $true
	}	
	return $false
}

function ExitScript{
	Write-Host "Exiting Script"
	exit
}

function DisplayInformation{
	#cls
	Write-Host "This script was created to utilize the chocolatey repository."
	Write-Host "`n Chocolatey is a NuGet style installer similar to how NuGet works in"
	Write-Host "Visual Studio for extentions or apt-get/yast for linux"
	Write-Host "`n The current templates are setup how I install new systems/VMs"
	Write-Host "Please feel free to modify/edit/remove/add new templates as you wish`n`n"
	Read-Host "Press any key to continue"
}


Write-Host "Initializing Please wait..."
$isChocolatelyUpdated = IsChocolateyInstalled
while ($continueProcess -eq "True"){
	$userTest = Test-Administrator
	
	if($isChocolatelyUpdated -eq "True"){
	$message = " Chocolatey is installed and up to date"
	}
	else{
	$message = " Chocolatey is either not installed or out of date,`n please run Setup (C)hocolatey"
	}
	
	#cls
	if ($userTest -eq "True"){	
		#cls
				Write-Host "`n`n"
		Write-Host " Welcome to http://chocolatey.org/ Setup Powershell Script"
		Write-Host "`n`n"
		Write-Host " Your Execution Policy is set to $policyLevel"
		Write-Host $message
		Write-Host "`n`n"
		Write-Host " `tSelect a Package to deploy"
		Write-Host "-----------------------------------------------------------------------"
		Write-Host " B: Install/Update (B)ase applications"
		Write-Host " V: Install/Update (V)isualStudio AddOns"
		Write-Host " G: Install/Update (G)it and Git AddOns"
		write-host " S: Install/Update (S)erver Base applications"
		Write-Host "-----------------------------------------------------------------------"
		Write-Host "`n`n C: Setup (C)hocolatey"
		Write-Host " P: Set (P)owerShell Execution Policy"
		Write-Host " I: (I)nfo on what this is for"
		Write-Host " Q: (Q)uit Application"
		$response = Read-Host "Select an option"
			
		if($response.ToUpper() -eq "I"){
			DisplayInformation
		}
			
		if($response.ToUpper() -eq "Q"){
			$continueProcess = "False"
			ExitScript
		}
		
		if($response.ToUpper() -eq "P")
		{
			SetExecutionPolicy
		}
		
		if($response.ToUpper() -eq "C")
		{
			SetupChocolatey	
		}
		
		if($response.ToUpper() -eq "B")
		{
			InstallBase
		}
		
		if($response.ToUpper() -eq "V")
		{
			InstallVisualStudioAddOns
		}
		
		if($response.ToUpper() -eq "G")
		{
			InstallGit
		}
		
		if($response.ToUpper() -eq "S")
		{
			InstallServerBase
		}
	}
	else
	{
		Write-Host "Please run this script as admin"
		Read-Host "Press any key to exit"
		exit
	}

}


