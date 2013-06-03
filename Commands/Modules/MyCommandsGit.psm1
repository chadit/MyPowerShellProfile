function get-tbasegitallworkrepodebug{
	$isDebugMode = "true"
	get-tbasegitallworkrepo "true"
}

function get-tbasegitallworkrepo{
param ([string]$debug)

	if($debug -eq ""){
		$isDebugMode = "false"
	}else{
		$isDebugMode = "true"
	}

	cls #clear console
	
	if($isDebugMode -eq "true"){
		Write-DebugMessage "Debug On"
	}
	
	$currentLocation = Get-Location
	Write-Host "************************************************************ `n `tRefreshing all work Git-tfs repos `n************************************************************"
	$gitArrayWork = ("CallMiner_Service")

	if($isDebugMode -eq "true"){
		Write-DebugMessage "Repository array collection is `n"$gitAttayWork
	}
	
	invoke-gitCheckForUpdate $gitArrayWork
	Set-Location $currentLocation
	
	$isDebugMode = "false"
}

function invoke-gitCheckForUpdate{
	param ($gitArray)
	foreach($repo in $gitArray){
		if($isDebugMode -eq "true"){
			Write-DebugMessage "Invoking $repo"
		}
		# &$repo	
		#switched to invoke-expression handles things a little better
		#if (Test-Path $repo){
			Invoke-Expression $repo
			set-gitBranchSwitch
		#}else{
		#	Write-Host "$repo was not found"
		#}
	}
}

function set-gitBranchSwitch{
	$startBranch = git rev-parse --abbrev-ref HEAD
	$startBranch = format-parseOutStar $startBranch
	
	if($isDebugMode -eq "true"){
		Write-DebugMessage "The starting branch is $startBranch"
	}
	
	
	if($startBranch -ne "master"){
		if($isDebugMode -eq "true"){
			Write-DebugMessage "Starting Branch is not Master, switching to master"
		}
		git checkout master
	}
	
	get-pullLatestChanges
	
	if($startBranch -ne "master"){			
		set-RevertBackToStartingBranch $startBranch
	}	
}

function get-pullLatestChanges{
	$pullTest = git tpull
	if($pullTest -eq $null){
		write-host "************************************************************ `n `tError occured in pull request see message `n************************************************************" -Fore Red 
	}else{
		if($pullTest -match "up to date"){	
			write-host $pullTest -Fore DarkGreen
		}else{
			#if($isDebugMode -eq "true"){
				write-host $pullTest -Fore White
			#}#else{
			#	write-host "changes where applied" -Fore DarkGreen
			#}
		}
		
		# Only do a merge with other branches if no errors occur on master
		Find-CheckForOtherBranches
	}

}

function format-parseOutStar{
param ([string] $stringValue)
	if($stringValue -match "\*"){
		return $stringValue.Replace('*', '').Trim()
	}else{
		return $stringValue
	}
}

function set-RevertBackToStartingBranch{
	param ($startBranch)

	if($isDebugMode -eq "true"){
		Write-DebugMessage "Setting branch back to original branch: $startBranch"
	}
	git checkout $startBranch 
}

function Find-CheckForOtherBranches{
	$branches=$(git branch | sed 's/\(\*| \)//g')
	if($isDebugMode -eq "true"){
		Write-DebugMessage "Checking for other branches, they are $branch"
	}
	
	foreach($b in $branches){
		$b = format-parseOutStar $b
		if($b -notlike "master"){
			Write-Host "Switch\Merge master into $b" -foregroundcolor Yellow 	 			
						
			Invoke-Expression 'git checkout $b 2>$nothing'
			
			if($isDebugMode -eq "true"){
				Write-DebugMessage "Branch is currently set to $b"
			}
			
			Set-BranchMerge
			
			if($isDebugMode -eq "true"){
				Write-DebugMessage "merge complete on $b"
			}
		}	
	}
}

function Set-BranchMerge{
	if($isDebugMode -eq "true"){
		Write-DebugMessage "Merging current branch with master"
	}

	$mergeTest = git merge master --no-ff
	if($mergeTest -eq $null){
		write-host $mergeTest -foregroundcolor Red 
	}else{
		write-host $mergeTest -Fore DarkGreen
	}
}

function Set-GitCheckin{
	$checkinType = "A"
	$checkinType = Read-Host "type of checkin (R)esolve, (A)ssociate[default], or (N)one"
	
	
	



#
#or the information, you could associate and resolve workitems with the command line options :
#--resolve=<workitem id>
#ID of the TFS work item to resolve during check-in
#--associate=<workitem id>
#ID of the TFS work item to associate during check-in
#
}

function whichGitBridge{
	$isGit = isSourceInGit(Get-Location)

	$currentLocationGitFolder = Get-Location + "\.git\"
	$isGit = $false
	if(Test-Path $currentLocationGitFolder){
		$isGit = $true	
	}
	
	if($isGit -eq $true){
	
	
	
	$whichGitBridge = $false
	}
	


}

function isSourceInGit{
	param ($path)
	#$isGit = $false
	$currentFolder = $path + "\.git\"
	if(Test-Path $currentFolder){
		return $true	
	}
	return $false
}