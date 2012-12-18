function tbase-gitallworkrepo{
	cls #clear console
	$currentLocation = Get-Location
	Write-Host "************************************************************ `n `tRefreshing all work Git-tfs repos `n************************************************************"
	$gitArrayWork = ("neo-apvx","neo-apvxservice","neo-apvxshare","neo-apvx_db","neo-barcodeservices","neo-neolabels","neo-neolabelscommon", "Neo-DocumentMgmt")
	gitCheckForUpdate $gitArrayWork
	Set-Location $currentLocation
}

function gitCheckForUpdate(){
	param ($gitArray)
	foreach($repo in $gitArray){
		# &$repo	#switched to invoke-expression handles things a little better
		Invoke-Expression $repo
		gitBranchSwitch
	}
}

function gitBranchSwitch(){
	 $startBranch = git rev-parse --abbrev-ref HEAD
	 $errorCheckHandler = 0
	 if($startBranch -ne "master"){
		 git checkout master
	 }
	 $pullTest = git tpull
	 if($pullTest -eq $null)
		{
			write-host "************************************************************ `n `tError occured in pull request see message `n************************************************************" -Fore Red 
			$errorCheckHandler = 1
		}else{
			write-host $pullTest -Fore DarkGreen
			if($startBranch -ne "master"){
				gitRevertBackToStartingBranch $startBranch
			}			
		}
}

function gitRevertBackToStartingBranch(){
	param ($startBranch)

	if($startBranch -ne "develop"){
		gitCheckForDevelopBranch
	}
	
	git checkout $startBranch
	gitBranchMerge
}

function gitCheckForDevelopBranch(){
	$branches=$(git branch | sed 's/\(\*| \)//g')
	$testIfDevelopExist = $branches -match "develop"
	if($testIfDevelopExist -ne $false){
		Write-Host "develop branch exist, merging with master"	-foregroundcolor Yellow 
		git checkout develop
		gitBranchMerge
	}
}

function gitBranchMerge(){
	$mergeTest = git merge master --no-ff
	if($mergeTest -eq $null)
	{
		write-host $mergeTest -foregroundcolor Red 
	}else{
		write-host $mergeTest -Fore Cyan
	}
}