function Find-IpAddress{
	param([string] $startAddress = "172.20.204.103", $count=254)

	$lastDot = $startAddress.LastIndexOf(".")
	$subnet = $startAddress.Substring(0, $lastDot+1)
	$ip = [int] $startAddress.SubString($lastDot + 1)

	Write-Host "IP Address"
	Write-Host "----------------------------------------"
	Do { 
		$address = $subnet + $ip
		$pingStatus = Get-WmiObject -Class Win32_PingStatus -Filter "Address='$address'"
		if($pingStatus.StatusCode -eq 0) {
			"{0,0} {1,5} {2,5}" -f $pingStatus.Address, $pingStatus.StatusCode," ON NETWORK"
		} else {
			"{0,0} {1,5} {2,5}" -f $pingStatus.Address, $pingStatus.StatusCode, " xxxxxxxxx"
		}
		$ip++
	} until ($ip -eq $count)
}

function GetForSqlServer{
	$sqlInstalled = $false
	$sqlInstalled = Test-Path("C:\Program Files (x86)\Microsoft SQL Server\90\Tools\Binn")
	$sqlInstalled = Test-Path("C:\Program Files (x86)\Microsoft SQL Server\100\Tools\Binn")
	$sqlInstalled = Test-Path("C:\Program Files (x86)\Microsoft SQL Server\110\Tools\Binn")

	return $sqlInstalled
}

function Get-DirectorySize() {
  param ([string]$root = $(resolve-path .))
  gci -re $root |
    ?{ -not $_.PSIsContainer } | 
    measure-object -sum -property Length
}

function Test-DriveExist { 
    param($driveletter)  
    (New-Object System.IO.DriveInfo($driveletter)).DriveType -ne 'NoRootDirectory'   
} 

function Update-DiskDrive {
	$location = Get-Location
	1..26 | %{Set-Location $([char]($_ + 64) + ":") -ErrorAction SilentlyContinue}
	Set-Location $location
}



function MoveFilesOlderThan{
$arSourceFolders = ("D:\Users\cengland\test\downloads");
$arDestinationFolders = ("D:\Users\cengland\test\downloadsold");

Get-ChildItem -Recurse $arSourceFolders | where {$_.Creationtime -lt (Get-Date).AddDays(-16)} | ForEach-Object { robocopy $arSourceFolders $arDestinationFolders /Z /S /Move }


Write-host -foregroundcolor 'green' "Done :)";
}

function Find-PathLocation([String] $path ){	
	# test if on C or D drive, can be expanded
	if (Test-Path "D:$path"){
		return "D:$path"
	}else{
		if(Test-Path "C:$path")
		{
			return "C:$path"
		}
	}	
	return ""
}
