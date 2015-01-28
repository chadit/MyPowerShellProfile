function invoke-RefreshGitAll{
	cls #clear console
	invoke-RefreshGitWork
	invoke-RefreshGitMine
}

function invoke-RefreshGitWork{	
	$currentLocation = Get-Location
	Write-Host "*********************************** `n `tRefreshing all work Git repos `n***********************************"
	$gitArrayWork = ("\Projects\DigitalFleet\Digital.Api", "\Projects\DigitalFleet\Digital.UI")
	invoke-gitCheckForUpdate $gitArrayWork
	Set-Location $currentLocation
}

function invoke-RefreshGitMine{
	$currentLocation = Get-Location
	Write-Host "*********************************** `n `tRefreshing all personal Git repos `n***********************************"
	$gitArrayWork = ("\Projects\Mine\AspNetIdentity", "\Projects\Mine\CacheProvider", "\Projects\Mine\LogProvider")
	invoke-gitCheckForUpdate $gitArrayWork
	Set-Location $currentLocation
}

function invoke-gitCheckForUpdate{
	param ($gitArray)
	foreach($repo in $gitArray){
		if($isDebugMode -eq "true"){
			Write-DebugMessage "Invoking $repo"
		}
		
		Set-LocationFromPath ($repo)
		#Invoke-Expression $repo
		set-gitBranchSwitch
	}
}

function set-gitBranchSwitch{
	$startBranch = git rev-parse --abbrev-ref HEAD
	$startBranch = format-parseOutStar $startBranch
	Write-DebugMessage "The starting branch is $startBranch"
	
	if($startBranch -ne "master"){
		Write-DebugMessage "Starting Branch is not Master, switching to master"
		git checkout master
	}
	
	get-pullLatestChanges
	
	if($startBranch -ne "master"){			
		set-RevertBackToStartingBranch $startBranch
	}	
}

function get-pullLatestChanges{
	$pullTest = git pull
	if($pullTest -eq $null){
		write-host "************************************************************ `n `tError occured in pull request see message `n************************************************************" -Fore Red 
	}else{
		if($pullTest -match "up to date"){	
			write-host $pullTest -Fore DarkGreen
		}else{
			write-host $pullTest -Fore White
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
	Write-DebugMessage "Setting branch back to original branch: $startBranch"
	git checkout $startBranch 
}

function Find-CheckForOtherBranches{
	$branches=$(git branch | sed 's/\(\*| \)//g')
	Write-DebugMessage "Checking for other branches, they are $branch"
	
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