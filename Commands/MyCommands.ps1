function ShutDownRemote{
	param ($ComputerName)
	Stop-Computer -ComputerName $ComputerName -Force
}

function TFS-Checkin{
	Neo-NeoRootTFS
	tf get /recursive
	tf checkin
}

function TBASE-Work{
	#Get from VS TFS
	#APvX
	Write-Host "Refreshing Git repos"
	Neo-APvX 
	git tf pull
	Neo-APvXService
	git tf pull
	Neo-APvXShare
	git tf pull
	Neo-APvX_Db
	git tf pull
	Neo-BarcodeServices
	git tf pull
	Neo-NeoLabels
	git tf pull
	Neo-NeoLabelsCommon 
	git tf pull
	Write-Host "Refreshing TFS repos"
	Neo-NeoRootTFS
	tf get /recursive
	Neo-BarcodeRootTFS
	tf get /recursive
}

# function TBASE-AllWork{
	# #Get from VS TFS
	# #APvX
	# Neo-APvX 
	# git tpull
	# Neo-APvXService
	# git tpull
	# Neo-APvXShare
	# git tpull
	# Neo-APvX_Db
	# git tpull
	# Neo-BarcodeServices
	# git tf pull
	# Neo-NeoLabels
	# git tf pull
	# Neo-NeoLabelsCommon 
	# git tf pull
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