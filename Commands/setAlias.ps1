#Set Alias
Set-Alias Neo-APvX Set-APvX # APVX Main App
Set-Alias Neo-APvXService Set-APvX_Service # APVX Web Services
Set-Alias Neo-APvXShare Set-APvX_Shared # APVX Share Library
Set-Alias Neo-APvX_Db Set-APvX_Db # APVX database
Set-Alias Neo-BarcodeServices Set-BarcodeServices # APVX Label app services
Set-Alias Neo-NeoLabels Set-NeoLabels # APVX label main app
Set-Alias Neo-NeoLabelsCommon Set-NeoLabelsCommon # APVX label share library
Set-Alias Neo-DocumentMgmt Set-NeoDocumentManagement # Document Locator

Set-Alias ChlodnyWebApi Set-ChlodnyWebApi
Set-Alias Dropbox Set-Dropbox
Set-Alias SkyDrive Set-SkyDrive
Set-Alias Source Set-Source

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
