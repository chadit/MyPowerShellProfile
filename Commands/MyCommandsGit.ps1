function tbase-gitallworkrepo([string]$debug){
	if($debug -ne ""){
		$isDebugMode = $debug
	}
	
	cls #clear console
	
	if($isDebugMode -eq "true"){
		Write-DebugMessage "Debug On"
	}
	
	$currentLocation = Get-Location
	Write-Host "************************************************************ `n `tRefreshing all work Git-tfs repos `n************************************************************"
	$gitArrayWork = ("neo-apvx","neo-apvxservice","neo-apvxshare","neo-apvx_db","neo-barcodeservices","neo-neolabels","neo-neolabelscommon", "Neo-DocumentMgmt")

	if($isDebugMode -eq "true"){
		Write-DebugMessage "Repository array collection is `n"$gitAttayWork
	}
	
	gitCheckForUpdate $gitArrayWork
	Set-Location $currentLocation
	
	$isDebugMode = "false"
}

function gitCheckForUpdate(){
	param ($gitArray)
	foreach($repo in $gitArray){
		if($isDebugMode -eq "true"){
			Write-DebugMessage "Invoking $repo"
		}
		# &$repo	#switched to invoke-expression handles things a little better
		Invoke-Expression $repo
		gitBranchSwitch
	}
}

function gitBranchSwitch(){
	$startBranch = git rev-parse --abbrev-ref HEAD
	$startBranch = parseOutStar $startBranch
	
	if($isDebugMode -eq "true"){
		Write-DebugMessage "The starting branch is $startBranch"
	}
	
	
	if($startBranch -ne "master"){
		if($isDebugMode -eq "true"){
			Write-DebugMessage "Starting Branch is not Master, switching to master"
		}
		git checkout master
	}
	
	gitpullLatestChanges
	
	if($startBranch -ne "master"){			
		gitRevertBackToStartingBranch $startBranch
	}
	
}

function gitpullLatestChanges(){
	$pullTest = git tpull
	if($pullTest -eq $null){
		write-host "************************************************************ `n `tError occured in pull request see message `n************************************************************" -Fore Red 
	}else{
		if($pullTest -match "up to date"){	
			write-host $pullTest -Fore DarkGreen
		}else{
			write-host "changes where applied" -Fore DarkGreen
		}
		
		# Only do a merge with other branches if no errors occur on master
		gitCheckForOtherBranches
	}

}

function parseOutStar([string] $stringValue){
	if($stringValue -match "\*"){
		return $stringValue.Replace('*', '').Trim()
	}else{
		return $stringValue
	}
}

function gitRevertBackToStartingBranch(){
	param ($startBranch)

	if($isDebugMode -eq "true"){
		Write-DebugMessage "Setting branch back to original branch: $startBranch"
	}
	git checkout $startBranch 
}

function gitCheckForOtherBranches(){
	$branches=$(git branch | sed 's/\(\*| \)//g')
	if($isDebugMode -eq "true"){
		Write-DebugMessage "Checking for other branches, they are $branch"
	}
	
	foreach($b in $branches){
		$b = parseOutStar $b
		if($b -notlike "master"){
			Write-Host "Switch\Merge master into $b" -foregroundcolor Yellow 	 			
						
			Invoke-Expression 'git checkout $b 2>$nothing'
			
			if($isDebugMode -eq "true"){
				Write-DebugMessage "Branch is currently set to $b"
			}
			
			gitBranchMerge
			
			if($isDebugMode -eq "true"){
				Write-DebugMessage "merge complete on $b"
			}
		}	
	}
}

function gitBranchMerge(){
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