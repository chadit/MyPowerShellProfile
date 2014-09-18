function Invoke-ChocolateyUpgradeCheck{
	Invoke-Expression "choco"
	Invoke-Expression "choco chocolatey"
}

# write a function that stops ssh agent before this will work
function Invoke-GitTools{
	Invoke-Expression "choco install git"
	#Invoke-Expression "choco git.install"
	Invoke-Expression "choco install gitextensions"
	Invoke-Expression "choco install git-credential-winstore"
	Invoke-Expression "choco install poshgit"
	Invoke-Expression "choco install gittfs"
	Invoke-Expression "choco install Git-TF"
	Invoke-Expression "choco install git-flow-dependencies"
	Invoke-Expression "choco install kdiff3"
	#Invoke-Expression "regsvr32 /u 'C:\Program Files (x86)\Git\git-cheetah\git_shell_ext64.dll'"
}

function Invoke-TFSTools{
	Invoke-Expression "choco install tfs2013powertools"
}

function Invoke-RubyTools{
	Invoke-Expression "choco install ruby"
	Invoke-Expression "choco install ruby.devkit"
}

function Invoke-NodeTools{
	Invoke-Expression "choco install nodejs"
}

function Invoke-MongodbTools{
	Invoke-Expression "choco install mongodb"
	Invoke-Expression "choco install MongoVUE"
}

function Invoke-GeneralTools{
	Invoke-Expression "choco install notepadplusplus.install"
	Invoke-Expression "choco install 7zip.install"
	Invoke-Expression "choco install vlc"
	Invoke-Expression "choco install paint.net"
	#Invoke-Expression "choco install ChocolateyGUI"
}

function Invoke-DevelopmentTools{
	Invoke-Expression "choco install fiddler"
	Invoke-Expression "choco install wixtoolset"
}

function Invoke-Browsers{
	Invoke-Expression "choco install GoogleChrome"
	Invoke-Expression "choco install Firefox"
}

function Invoke-Perl{
	Invoke-Expression "choco install StrawberryPerl"
}

function Invoke-PowerShell{
	Invoke-Expression "choco install pscx"
	Invoke-Expression "choco install PowerGUI"
}