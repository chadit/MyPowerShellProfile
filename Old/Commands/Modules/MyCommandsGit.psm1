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

function Set-GitConfigRebuild{
	#reset
	if(Test-LocationFromPath("\Users\$env:username\.gitconfig")){
		$config = Test-LocationFromPath("\Users\$env:username\.gitconfig")
		Remove-Item $config
	}

	Set-GitConfigInformation
	Set-GitColorTheme
	Set-GitConfigAliases
}


function Set-GitConfigInformation{
	$name = $global:profileSettings.Name
	$email = $global:profileSettings.Email

	#Identity
	Invoke-Expression "git config --global user.name `"$name`""
	Invoke-Expression "git config --global user.email $email"
	
	#Core
	Invoke-Expression "git config --global --replace-all core.editor 'c:/program files/sublime text 3/subl.exe' -w"
	Invoke-Expression "git config --global core.autocrlf false"

	#Merge
	Invoke-Expression "git config --global --replace-all merge.tool kdiff3"

	Invoke-Expression "git config --global mergetool.kdiff3.cmd '`"C:\Program Files (x86)\KDiff3\kdiff3`" $BASE $LOCAL $REMOTE -o $MERGED'"
	Invoke-Expression "git config --global mergetool.kdiff3.path `"C:\Program Files (x86)\KDiff3\kdiff3`" "
	Invoke-Expression "git config --global mergetool.trustExitCode false"
	Invoke-Expression "git config --global mergetool.keepBackup false"

	#Diff
	Invoke-Expression "git config --global --replace-all diff.tool kdiff3"
	Invoke-Expression "git config --global --replace-all difftool.kdiff3.cmd '`"C:\Program Files (x86)\KDiff3\kdiff3`" $LOCAL $REMOTE'"
	Invoke-Expression "git config --global difftool.prompt false"

	#Ignore
	Invoke-Expression "git config --global core.excludesfile ~/.gitignore_global"

	#cache credentials
	Invoke-Expression "git config --global credentials.helper cache"

	Invoke-Expression "git config --global push.default simple"
	Invoke-Expression "git config --global i18n.filesEncoding utf-8"
}

function Set-GitColorTheme{
	#All
	Invoke-Expression "git config --global color.diff auto"
	Invoke-Expression "git config --global color.status auto"
	Invoke-Expression "git config --global color.branch auto"
	Invoke-Expression "git config --global color.interactive auto"
	Invoke-Expression "git config --global color.ui auto"

	#Branch
	Invoke-Expression "git config --global color.branch.current `"yellow reverse`""
	Invoke-Expression "git config --global color.branch.local yellow"
	Invoke-Expression "git config --global color.branch.remote green"

	#Diff
	Invoke-Expression "git config --global color.diff.meta `"yellow bold`""
	Invoke-Expression "git config --global color.diff.frag magenta"
	Invoke-Expression "git config --global color.diff.plain `"white bold`""
	Invoke-Expression "git config --global color.diff.old `"red bold`""
	Invoke-Expression "git config --global color.diff.new `"green bold`""
	Invoke-Expression "git config --global color.diff.commit `"yellow bold`""
	Invoke-Expression "git config --global color.diff.func `"green dim`""

	#status
	Invoke-Expression "git config --global color.status.added `"yellow`""
	Invoke-Expression "git config --global color.status.changed `"green`""
	Invoke-Expression "git config --global color.status.untracked `"cyan`""
}

function Set-GitConfigAliases{
	#short cuts
	Invoke-Expression "git config --global alias.co checkout"
	Invoke-Expression "git config --global alias.br branch"
	Invoke-Expression "git config --global alias.ci commit"
	Invoke-Expression "git config --global alias.st status"

	#resets
	Invoke-Expression "git config --global alias.unstage 'reset HEAD --'"
	Invoke-Expression "git config --global alias.reset 'reset -- hard'"

	#logs
	Invoke-Expression "git config --global alias.last 'log -1 HEAD'" #see the last item commited

	$info = "log --pretty=format:\`"%h %ad | %s%d [%an]\`" --graph --date=short --decorate"
	$info1 = "log --pretty=format:\`"%h %ad | %s%d [%an]\`" --graph --date=short --oneline --decorate --all"

	Invoke-Expression "git config --global alias.lga '$info'" #formated log
	Invoke-Expression "git config --global alias.history '$info1'" #formated history


	#source control helpers
	Invoke-Expression "git config --global alias.tpull 'tfs fetch && git rebase tfs/default'" #gittfs command to pull latest and merge with current branch
	Invoke-Expression "git config --global alias.checkin 'tpull && git tfs checkin'" #gittfs command pull latest and then checkin get-pullLatestChanges

	Invoke-Expression "git config --global alias.spull 'svn fetch && git svn rebase'" #svn fetch and rebase


	#git maintenance
	Invoke-Expression "git config --global alias.cleanhard 'clean -f -x -d && git cleanlite'"  #hard cleanup, removes all items not committed and runes cleanlight
	Invoke-Expression "git config --global alias.cleanlite 'prune && git gc --aggressive'"  #prunes unused items and does a garbage collection
}