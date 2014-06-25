function Invoke-ChocolateyUpgradeCheck{
	Invoke-Expression "cinst"
}

function Invoke-GitTools{
	Invoke-Expression "cinst git.install"
	Invoke-Expression "cinst gitextensions"
	Invoke-Expression "cinst git-credential-winstore"
	#Invoke-Expression "cinst poshgit"
	Invoke-Expression "cinst gittfs"
	Invoke-Expression "cinst Git-TF"
	Invoke-Expression "cinst git-flow-dependencies"
	Invoke-Expression "cinst kdiff3"
	Invoke-Expression "regsvr32 /u 'C:\Program Files (x86)\Git\git-cheetah\git_shell_ext64.dll'"
}

function Invoke-TFSTools{
	Invoke-Expression "cinst tfpt"
}

function Invoke-RubyTools{
	Invoke-Expression "cinst ruby"
	Invoke-Expression "cinst ruby.devkit"
}

function Invoke-NodeTools{
	Invoke-Expression "cinst nodejs.install"
}

function Invoke-MongodbTools{
	Invoke-Expression "cinst mongodb"
	Invoke-Expression "cinst MongoVUE"
}

function Invoke-GeneralTools{
	Invoke-Expression "cinst notepadplusplus.install"
	Invoke-Expression "cinst 7zip.install"
	Invoke-Expression "cinst vlc"
	Invoke-Expression "cinst paint.net"
	Invoke-Expression "cinst ChocolateyGUI"
}

function Invoke-DevelopmentTools{
	Invoke-Expression "cinst fiddler"
	Invoke-Expression "cinst wixtoolset"
}

function Invoke-Browsers{
	Invoke-Expression "cinst GoogleChrome"
	Invoke-Expression "cinst Firefox"
}

function Invoke-Perl{
	Invoke-Expression "cinst StrawberryPerl"
}

function Invoke-PowerShell{
	Invoke-Expression "cinst pscx"
	Invoke-Expression "cinst PowerGUI"
}