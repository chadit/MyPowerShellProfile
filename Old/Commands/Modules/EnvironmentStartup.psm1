#DriveSizeFormat G for GigaByte, M for Megabyte

$global:ByteToGigabyte = 1073741824

function Get-MongoSettings(){
	$mongosettings = @{
		DigitalFleetWorkPath = "\Projects\DigitalFleet\Digital.Api"
		MongoVolumeLabel = "mongo"
		MongoPath = "D:\Mongo"
		MongMaxSize = 5
		MongoDriveLetter = "P:\"
		MongoDriveSizeFormat = "G"
	}
	return $mongosettings
}

function Get-FolderSize([String] $path, [Int32] $conversionAmount ){
	$sum = (Get-DirectorySize $path).Sum 
	if($conversionAmount -ge 0){
		return $sum / $conversionAmount
	}
	return $sum
}

function Get-VirtualSize([Double] $folderSize, [Int32] $maxSize, [String]$driveSizeFormat){
	$size = [math]::ceiling($folderSize * 2)
	if($size -ge $maxSize){
		$size = $maxSize
	}
	return "$size" + $driveSizeFormat
}

function Invoke-MountVirtualDisk([String] $driveSize, [String] $volumeLabel, [String] $driveLetter ){
	imdisk -a -s $driveSize -m $driveLetter -p "/fs:ntfs /q /y /v:$volumeLabel"
	Write-Host "drive $driveLetter mounted with label $volumeLabel and size $driveSize "
	
	Start-Sleep -m 1000
}

function Invoke-UnMountVirtualDisk([String] $driveLetter ){
	imdisk -d -m $driveLetter
}



function Invoke-SyncFolders([string] $source, [string]$destination){
	$count = 0
	do{
	
	Write-Host "syncing files from $source  to $destination "
	Set-Location $destination
	$syncError = $false	
	if([string]::IsNullOrWhiteSpace($source)) {            
    	Write-Host "source is null or empty : $source" -ForegroundColor Red
		$syncError = $true
	}  
	
	if(-not (Test-Path($source))){          
    	Write-Host "could not find : $source" -ForegroundColor Red
		$syncError = $true
	}  
	
	if([string]::IsNullOrWhiteSpace($destination)) {            
    	Write-Host "destination is null or empty : $destination" -ForegroundColor Red
		$syncError = $true
	}  
	
	if(Test-Path($destination)){          
    	
	}else{
		Write-Host "could not find : $destination ::::" -ForegroundColor Red
		$syncError = $true
	}		
		
	$count ++
	
	if($syncError -eq $true){ 
		Start-Sleep -m 1000
	}
	
	} Until (($syncError -eq $false) -or ($count -gt 3 )  )
		
	if($syncError -eq $true){ 
		return $false
	}	
	
 	$captureoutput = robocopy $source $destination /mir /NFL /NDL /NJH /NJS
	if($captureoutput -match "ERROR"){
		Write-Host "Error syncing"
		return $false
	}
	return $true
}

function Invoke-MountMongoVirtualDisk([String] $MongoPath , [Int32] $MongMaxSize , [String] $MongoDriveSizeFormat , [String] $MongoVolumeLabel ,[String] $MongoDriveLetter ){
	if(-not (Test-Path($MongoPath))){
		Write-Host "could not find mongo at $MongoPath" -ForegroundColor Red
	}else{
		$sum = Get-FolderSize $MongoPath $global:ByteToGigabyte
		$vSum = Get-VirtualSize $sum $MongMaxSize $MongoDriveSizeFormat
				
		if($vSum -gt 0 ){
			Invoke-MountVirtualDisk $vSum $MongoVolumeLabel $MongoDriveLetter
			Set-Location $MongoDriveLetter 	
			Invoke-SyncFolders $MongoPath $MongoDriveLetter
		}else{
			Write-Host "sum is zero"
		}
	}
}

function Start-WorkDF() {
	$mongosettings = Get-MongoSettings
	$projectLocation = Find-PathLocation $mongosettings.DigitalFleetWorkPath
	
	if([string]::IsNullOrWhiteSpace($projectLocation)) {            
    	Write-Host "DF project could not be found : $projectLocation" -ForegroundColor Red		
	}else{  
		Invoke-MountMongoVirtualDisk $mongosettings.MongoPath $mongosettings.MongMaxSize $mongosettings.MongoDriveSizeFormat $mongosettings.MongoVolumeLabel $mongosettings.MongoDriveLetter
		Set-Location $projectLocation
	}
}

function Stop-WorkDF() {
	$mongosettings = Get-MongoSettings
	$getError = Get-Item $mongosettings.MongoPath -Force
	$getError.Attributes ="Normal"
	$sync = ""
	$sum = Get-FolderSize $mongosettings.MongoDriveLetter $global:ByteToGigabyte
	if($sum -gt 0 ){
		$sync = Invoke-SyncFolders $mongosettings.MongoDriveLetter $mongosettings.MongoPath
	}	
	
	$getError = Get-Item $mongosettings.MongoPath -Force
	$getError.Attributes ="Normal"
	
	if($sync -eq $true ) {     
		Invoke-UnMountVirtualDisk $mongosettings.MongoDriveLetter		
	}else{
		Write-Host "sync error" -ForegroundColor Red
	}
}

function Sync-WorkDFVirtualToDisk(){
	$getError = Get-Item $mongosettings.MongoPath -Force
	$getError.Attributes ="Normal"
	$sync = ""
	$sum = Get-FolderSize $mongosettings.MongoDriveLetter $global:ByteToGigabyte
	if($sum -gt 0 ){
		$sync = Invoke-SyncFolders $mongosettings.MongoDriveLetter $mongosettings.MongoPath
	}
}

function Sync-WorkDFDiskToVirtual(){
	$mongosettings = Get-MongoSettings
	Invoke-SyncFolders $mongosettings.MongoPath $mongosettings.MongoDriveLetter	
}

