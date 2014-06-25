function GET-CleanVsSln {    
	param ([string]$path)
	write-host "Cleaning bin from: $path"
	get-childitem $path -include bin, *.tmp, _UpgradeReport_Files -recurse | remove-item -Force -Recurse
	write-host "Cleaning obj from: $path"
	get-childitem $path -include obj -recurse | remove-item -Force -Recurse
	write-host "cleaning up Temp Test folders from $path"
	get-childitem $path -include TestResults -recurse | remove-item -Force -Recurse
}

