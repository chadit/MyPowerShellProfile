#Set Alias

#Reference from https://github.com/PProvost/dotfiles/blob/master/powershell/Aliases.ps1
# Global command aliases
# Because of how powershell works, some of thes are actually functions. :)

set-alias count measure-object
set-alias lsd get-childcontainers
set-alias lsf get-childfiles
set-alias rmd remove-allChildItems
if (test-path alias:\set) { remove-item alias:\set -force }
set-alias set set-variableEx -force
set-alias sudo Invoke-Elevated
set-alias unset remove-variable
set-alias whence get-commandInfoEx

set-alias logout Invoke-Logoff
set-alias shutdown Invoke-Shutdown
set-alias restart Invoke-Reboot
if (test-path alias:\sleep) { remove-item alias:\sleep -force }
set-alias sleep Invoke-Hibernate -force
set-alias lock invoke-terminalLock

Set-Alias home Set-HomeLocation