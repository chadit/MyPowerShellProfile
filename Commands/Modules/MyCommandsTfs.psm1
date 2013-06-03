function Set-tfclone(){
	param ($repoPath)

}

# All TF wWrkspaces commands go off the assumption that a path has been updated to map to it
# C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE  -- tf.exe resides here

# Get latest version from source code for location in TFS solution
function Get-TFLatestVersion() { 
    $location = get-location 
    tf get $location /version:T /recursive
}

function Get-TFLatestVersionForce() { 
    $location = get-location 
    tf get $location /version:T /recursive /force 
}

function Get-TFCheckin() { 
    $returnValue = Get-TFLatestVersion
	if($returnValue -eq "All files are up to date."){
		write-host $returnValue -Fore Yellow
		tf checkin
	}else{
		write-host $returnValue -Fore Cyan
		write-host "Checkin canceled, please review update before for possible conflicts" -Fore Red
	}
}

function Get-TFWorkspacesHelp(){
	tf workspaces /?
}

function Get-TFWorkspaces(){
	tf workspaces
}

function Set-TFWorkspacesComputerName([string]$oldComputerName, [string]$collectionName , [string]$loginName){
	if($oldComputerName -eq $null -or $oldComputerName -eq ''){
		$oldComputerName = Read-Host "Please enter old computer name"
	}
	
	if($collectionName -eq $null -or $collectionName -eq ''){
		$collectionName = Read-Host "Please enter collection URL"
	}
	
	if($loginName -eq $null -or $loginName -eq ''){
		tf workspaces /updateComputerName:$oldComputerName /collection:$collectionName /login:$loginName
	}else{
		tf workspaces /updateComputerName:$oldComputerName /collection:$collectionName
	}
}