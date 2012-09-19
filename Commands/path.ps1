function check-path{
	$path = $env:path
	$pathcheck = $path.split(";")
	$count = 0
	$reapplyPath = ""

	# Check path for these locations
	$gitHomeLocation = "C:\Program Files (x86)\Git"
	$gitExtensionsLocation  = "C:\Program Files (x86)\GitExtensions"
	$gittfsLocation = "D:\Users\cengland\Dropbox\Source\ThirdParty\git-tfs\GitTfs.Vs11\bin\Debug"
	$gittfLocation = "D:\Users\cengland\Dropbox\Source\ThirdParty\git-tf"
	$notepadPlusLocation = "C:\Program Files (x86)\Notepad++"
	$visualStudioLocation = "C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE"

	foreach ($line in $pathcheck)
	{
		if($line -like "*\Microsoft Visual Studio 11.0\Common7\*"){
			if($line -ne "$visualStudioLocation"){
				# Only add path if files exist
				if (Test-Path "$visualStudioLocation"){
					$count++
					$reapplyPath += "$visualStudioLocation"
					continue;
				}
			}
		}
		if($line -like "*\git-tf"){
			if($line -ne "$gittfLocation"){
				# Only add path if files exist
				if (Test-Path "$gittfLocation"){
					$count++
					$reapplyPath += "$gittfLocation"
					continue;
				}
			}
		}

		if($line -like "*\Notepad++*"){
			if($line -ne "$notepadPlusLocation"){
				# Only add path if files exist
				if (Test-Path "$notepadPlusLocation"){
					$count++
					$reapplyPath += "$notepadPlusLocation"
					continue;
				}
			}
		}

		if($line -like "*\Git\cmd*"){
			if($line -ne "$gitHomeLocation\cmd"){
				# Only add path if files exist
				if (Test-Path "$gitHomeLocation\cmd"){
					$count++
					$reapplyPath += "$gitHomeLocation\cmd"
					continue;
				}
			}
		}
		
		if($line -like "*\Git\bin*"){
			if($line -ne "$gitHomeLocation\bin"){
				# Only add path if files exist
				if (Test-Path "$gitHomeLocation\bin"){
					$count++
					$reapplyPath += "$gitHomeLocation\bin"
					continue;
				}
			}
		}
		
		if($line -like "*\GitExtensions*"){
			if($line -ne "$gitExtensionsLocation"){
				# Only add path if files exist
				if (Test-Path "$gitExtensionsLocation"){
					$count++
					$reapplyPath += "$gitExtensionsLocation"
					continue;
				}
			}
		}
		
		if($line -like "*\git-tfs\*"){
			if($line -ne "$gittfsLocation"){
				# Only add path if files exist
				if (Test-Path "$gittfsLocation"){
					$count++
					$reapplyPath += "$gittfsLocation"
					continue;
				}
			}
		}
		
		$reapplyPath += ";$line"
	}

	if($reapplyPath -notlike $gitHomeLocation){
		$count++
		$reapplyPath += ";$gitHomeLocation"
	}

	if($reapplyPath -notlike $gitExtensionsLocation){
		$count++
		$reapplyPath += ";$gitExtensionsLocation"
	}

	if($reapplyPath -notlike $gittfsLocation){
		$count++
		$reapplyPath += ";$gittfsLocation"
	}

	if($reapplyPath -notlike $gittfLocation){
		$count++
		$reapplyPath += ";$gittfLocation"
	}

	if($reapplyPath -notlike $notepadPlusLocation){
		$count++
		$reapplyPath += ";$notepadPlusLocation"
	}

	if($reapplyPath -notlike $visualStudioLocation){
		$count++
		$reapplyPath += ";$visualStudioLocation"
	}

	if($count > 0){
		$env:path = $reapplyPath
	}
}