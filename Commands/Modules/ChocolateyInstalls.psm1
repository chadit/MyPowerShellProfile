function Invoke-ChocolateyUpgradeCheck{
	Invoke-Expression cinst
}

function Invoke-ChocolateyGit{
	Invoke-Expression cinst git.install
	Invoke-Expression cinst gitextensions
	Invoke-Expression cinst git-credential-winstore
	Invoke-Expression cinst cinst poshgit
	Invoke-Expression cinst gittfs
	Invoke-Expression cinst gittf
	Invoke-Expression cinst git-flow-dependencies
}

function Invoke-Ruby{
	Invoke-Expression cinst ruby
	


}

function Invoke-Node{
	Invoke-Expression cinst node
}

