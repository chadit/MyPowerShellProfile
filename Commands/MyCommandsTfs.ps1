function tfclone(){
	param ($repoPath)

}

# All TF wWrkspaces commands go off the assumption that a path has been updated to map to it
# C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE  -- tf.exe resides here

function tfWorkspaces-help(){
	tf workspaces /?
}

function get-tfWorkspaces(){
	tf workspaces
}

function set-tfWorkspacesComputerName([string]$oldComputerName, [string]$collectionName , [string]$loginName){
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