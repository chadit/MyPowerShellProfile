# Set-Alias gits "git status"
# Set-Alias gita 'git add '
# Set-Alias gitb 'git branch '
# Set-Alias gitc 'git commit'
# Set-Alias gitca 'git commit -a'
# Set-Alias gitd 'git diff'
# Set-Alias gito 'git checkout '
# Set-Alias gitk 'gitk --all&'
# Set-Alias gitx 'gitx --all'
# Set-Alias gitp 'git pull'
# Set-Alias gitpush 'git push'
# Set-Alias gitr 'git rebase '
# Set-Alias gitm 'git merge '

function tbase-gitallworkrepo{
	#get from vs tfs 
	#apvx
	$currentLocation = Get-Location
	Write-Host "Refreshing all work Git-tfs repos"
	# APVX Main App
	neo-apvx 
	gitBranchSwitch
	# APVX Web Services
	neo-apvxservice
	gitBranchSwitch
	# APVX Share Library
	neo-apvxshare
	gitBranchSwitch
	# APVX database
	neo-apvx_db
	gitBranchSwitch
	# APVX Label app services
	neo-barcodeservices
	gitBranchSwitch
	# APVX label main app
	neo-neolabels
	gitBranchSwitch
	# APVX label share library
	neo-neolabelscommon
	gitBranchSwitch
	Set-Location $currentLocation
}

function gitBranchSwitch(){
	 $test = git rev-parse --abbrev-ref HEAD
	 if($test -ne "master"){
		 git checkout master
	 }
	 git tpull
	 if($test -ne "master"){
		 git checkout $test
		 git merge master --no-ff
	 }
}