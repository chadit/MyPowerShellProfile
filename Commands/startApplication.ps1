# Function will find the sln file in the currently directory and launch it
function Start-Solution{
	param ($VsSwitch)
	$application = Get-ChildItem $PWD\*.* -Include *.sln
	
	if ($application.length -ge 1)
	{
		if($VsSwitch -ne $null){
			Write-Host "VsSwtich set to $VsSwitch"
			if($VsSwitch -eq "2012"){
				$location = "\Microsoft Visual Studio 11.0\Common7\IDE\devenv.exe"
			}else{
				$location = "\Microsoft Visual Studio 10.0\Common7\IDE\devenv.exe"
			}
		}else{	
			if($DefaultVisualStudio -eq "2010"){
				$location = "\Microsoft Visual Studio 10.0\Common7\IDE\devenv.exe"
			}elseif($DefaultVisualStudio -eq "2012"){
				$location = "\Microsoft Visual Studio 11.0\Common7\IDE\devenv.exe"
			}
		}
		
		if (Test-Path "C:\Program Files (x86)$location"){
			write-host "starting $application"
			& "C:\Program Files (x86)$location" "$application"
		}
		elseif(Test-Path "C:\Program Files$location")
		{
			write-host "starting $application"
			& "C:\Program Files$location" "$application"
		}
		elseif(Test-Path "D:\Program Files$location")
		{
			write-host "starting $application"
			& "D:\Program Files$location" "$application"
		}
	}
}

function Start-VS{
	param ($path)
	$found = 0
	
	if($path -eq $null){
		$found = StartVisualStudio2010
		if($found -eq 0){
			$found = StartVisualStudio2012
		}
	}elseif($path -eq "2010"){
		$found = StartVisualStudio2010
	}elseif($path -eq "2012"){
		$found = StartVisualStudio2012
	}

	if($found -eq 0){
		Write-Host "Visual Studio was not found" -foregroundcolor red
	}
}

function StartVisualStudio2010{
	$locationVS = "\Microsoft Visual Studio 10.0\Common7\IDE\devenv.exe"
	$found = 0

	$VSLocation = FindApplicationInProgramFiles($locationVS)
	
	if($VSLocation -ne $null){
		& $VSLocation
		$found = 1
	}
	
	return $found
}

function StartVisualStudio2012{
	$locationVS = "\Microsoft Visual Studio 11.0\Common7\IDE\devenv.exe"
	$found = 0

	$VSLocation = FindApplicationInProgramFiles($locationVS)
	
	if($VSLocation -ne $null){
		& $VSLocation
		$found = 1
	}
	
	return $found
}

function FindApplicationInProgramFiles{
	param ($path)
	if (Test-Path "C:\Program Files (x86)$path"){
		return "C:\Program Files (x86)$path"
	}elseif(Test-Path "C:\Program Files$path"){
		return "C:\Program Files$path"
	}elseif (Test-Path "D:\Program Files$path"){
		return "D:\Program Files$path"
	}	
}	

function Start-Help{
	Write-Host "*************************************************************"
	Write-Host "Start-Solution : Start any solution for the folder you are in"
	Write-Host "Start-VS : Starts Visual Studio"
	Write-Host "*************************************************************"
	
}

function Color-Help{
Write-Host ""
Write-Host "ForeGround Colors:"
Write-Host "Black" -Fore Black
Write-Host "Blue" -Fore Blue
Write-Host "Dark Blue" -Fore DarkBlue
Write-Host "Cyan" -Fore Cyan
Write-Host "Dark Cyan" -Fore DarkCyan
Write-Host "Gray" -Fore Gray
Write-Host "Dark Gray" -Fore DarkGray
Write-Host "Green" -Fore Green
Write-Host "Dark Green" -Fore DarkGreen
Write-Host "Magenta" -Fore Magenta
Write-Host "Dark Magenta" -Fore DarkMagenta
Write-Host "Red" -Fore Red
Write-Host "Dark Red" -Fore DarkRed
Write-Host "White" -Fore White
Write-Host "Yellow" -Fore Yellow
Write-Host "Dark Yellow" -Fore DarkYellow
Write-Host ""

}