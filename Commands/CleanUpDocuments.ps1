function Clean-VsSln {    
	param ([string]$path)
	write-host "Cleaning bin from: $path"
	get-childitem $path -include bin, *.tmp, _UpgradeReport_Files -recurse | remove-item -Force -Recurse
	write-host "Cleaning obj from: $path"
	get-childitem $path -include obj -recurse | remove-item -Force -Recurse
}