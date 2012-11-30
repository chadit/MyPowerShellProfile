function ShutDownRemote{
	param ($ComputerName)
	Stop-Computer -ComputerName $ComputerName -Force
}

function TFS-Checkin{
	Neo-NeoRootTFS
	tf get /recursive
	tf checkin
}

function Scan-IpAddress{
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

# function Set-WallpaperRemote{
  # param([string] $computerName = "fmmistsmith"
  
  # Const HKEY_CURRENT_USER = &H80000001
  
  # Set objReg = GetObject("winmgmts:\\" & computerName & "\root\default:StdRegProv")
  
  
# }

# Function Get-WallPaper()
# {
 # $wp=Get-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper
 # if(!$wp.WallPaper) 
   # { "Wall paper is not set" }
 # Else
  # {"Wall paper is set to $($wp.WallPaper)" }
# }

# Function Set-WallPaper($Value)
# {
 # Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $value
 # rundll32.exe user32.dll, UpdatePerUserSystemParameters
# }



#Does not work at the moment

# function TBASE-3rdParty{
# $folderLocation = "$dropbox\Source\ThirdParty\"
# Get-ChildItem $folderLocation | ? {$_.Attributes -eq "Directory"}| ForEach-Object { 
# [string]$fullFolderPath = $_.FullName
		
# $ScriptBlock = {
	# param($fullFolderPath1 )
		  
	# #$fullFolderPath2 = $fullFolderPath1.ToString()
	# $whichSourceControl = "git"


	# #Check for Git to SVN bridge
	# $folderToCheck = $fullFolderPath1 + "\.git\svn"
	# if (Test-Path $folderToCheck.Trim()){
		 # $whichSourceControl = "svn"
	# }

	# #Check for Git to TFS bridge
	# $folderToCheck = $fullFolderPath1 + "\.git\tfs"
		# if (Test-Path $folderToCheck.Trim()){
		# $whichSourceControl = "tfs"
	# }		  
		  
	# $message = "Setting location to $fullFolderPath1 \nrun git command for $whichSourceControl" 
	# write-host $message -foregroundcolor DarkYellow
	# Set-Location $fullFolderPath1
			# Start-Sleep -m 1000
			# if ($whichSourceControl -eq "tfs"){
					# git tpull
			
			# }

			# if ($whichSourceControl -eq "git"){
					# git pull
			# }

			# if ($whichSourceControl -eq "svn"){
					# git spull
			# }

			# Start-Sleep -m 10000
# }

	# # Execute the jobs in parallel

	# Start-Job $ScriptBlock -Name $_.Name -ArgumentList $fullFolderPath
# }

# # Getting the information back from the jobs

# Get-Job | Receive-Job
# }