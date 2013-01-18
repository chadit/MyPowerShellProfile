#
# Profile.ps1 - main powershell profile script
# 
# Applies to all hosts, so only put things here that are global
#
# alot of the setup and modules from https://github.com/PProvost/dotfiles

# A couple of directory variables for convenience

$global:isDebugMode = "false"

function Write-DebugMessage([string] $message){
	write-host $message -ForegroundColor Black -BackgroundColor White
}




