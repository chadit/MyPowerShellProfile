#clear Host Window
cls
$startApp = "False"
$gitSolution = ""
$gitUrl = ""
$gitRepository = ""
$gitFetch = ""


function Start-GitTfsConverterApplication{
cls
	while ($startApp -ne "False") {
		$script:gitSolution = Read-Host "Enter the path to the project folder (Folder that holds .git)"
		Write-Host "1) Dual Mode -- Add Git-Tf to existing Git-Tfs solutoin"
		Write-Host "2) Convert Git-Tfs to Git-Tf deleting existing connection"
		Write-Host "3) Dual Mode -- Add Git-Tfs to existing Git-Tf solutoin"
		Write-Host "4) Convert Git-Tf to Git-Tfs deleting existing connection"
		Write-Host "0) Exit"
		$whichConvertOption = Read-Host "Enter the option number"
		
		if ($whichConvertOption -eq "1") {
    		Set-GitTfDualMode
  		}
		
		if ($whichConvertOption -eq "2") {
    		Set-GitTfConvertMode
  		}
		
		if ($whichConvertOption -eq "3") {
    		Set-GitTfsDualMode
  		}
		
		if ($whichConvertOption -eq "4") {
    		Set-GitTfsConvertMode
  		}
		
		if ($whichConvertOption -eq "0") {
    		exit
  		}

	}
}

function Set-GitTfDualMode{
$path = $gitSolution + "\.git"
$pathGitConfig = $gitSolution + "\.git\config"
$gitConfig = Get-Content $pathGitConfig
$count = 0
foreach ($line in $gitConfig)
{
	if($count -ge 1){
		if($line -like "*url =*"){
    		$gitUrl = $line.Substring(5)
		}
		if($line -like "*repository =*"){
    		$gitRepository = $line.Substring(12)
		}
		if($line -like "*fetch =*"){
    		$gitFetch = $line.Substring(7)
			$count = 0
		}
	}	
	
	if($line -contains "[tfs-remote `"default`"]"){
    	$count = 1	
	}	
}

$repoToAdd = "`n[git-tf `"server`"] `n collection $gitUrl `n serverpath $gitRepository"
Add-Content $pathGitConfig $repoToAdd

Write-Host $path

}

function Set-GitTfConvertMode{
$path = $script:gitSolution + "\.git"

}

function Set-GitTfsDualMode{
$path = $script:gitSolution + "\.git"

}

function Set-GitTfsConvertMode{
$path = $script:gitSolution + "\.git"

}


Write-Host "`n`n`n"
Write-Host " Git TF converter" -foregroundColor Blue  
Write-Host "`n`n"
Write-Host " This applicaton will allow you to convert"
Write-Host " Git-TFS to Git-Tf and back again"
Write-Host " You will have the option to Convert (delete the previous)"
Write-Host " Or append and run dual mode (recommended)"
Write-Host "`n`n`n"
Write-Host " Provided by Chad England @chadit"
Write-Host " DO BACKUPS before running, if you do not"
Write-Host " and something goes wrong it is on you."

$response = Read-Host "Would you like to continue? (Y/[N])"

if($response -eq "Y"){
	$startApp = "True"
	Start-GitTfsConverterApplication
}else{
exit
}