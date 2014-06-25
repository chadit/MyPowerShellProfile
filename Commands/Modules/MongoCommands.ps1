#Mongo Powershell commands
function New-MongoService{
	$mongoDbPath = "D:\MongoDB" 
	$mongoDbConfigPath = "$mongoDbPath\mongod.cfg"
	$url = "http://downloads.mongodb.org/win32/mongodb-win32-x86_64-2008plus-2.4.5.zip" 
	$zipFile = "$mongoDbPath\mongo.zip" 
	$unzippedFolderContent ="D:\mongodownload"
 
	if ((Test-Path -path $mongoDbPath) -eq $True) 
	{ 
  		write-host "Seems you already installed MongoDB"
		exit 
	}
 
	md $mongoDbPath 
	md "$mongoDbPath\log" 
	md "$mongoDbPath\data" 
	md "$mongoDbPath\data\db"
 
	[System.IO.File]::AppendAllText("$mongoDbConfigPath", "dbpath=D:\MongoDB\data\db`r`n")
	[System.IO.File]::AppendAllText("$mongoDbConfigPath", "logpath=D:\MongoDB\log\mongo.log`r`n")
	[System.IO.File]::AppendAllText("$mongoDbConfigPath", "smallfiles=true`r`n")
	[System.IO.File]::AppendAllText("$mongoDbConfigPath", "noprealloc=true`r`n")
 
	$webClient = New-Object System.Net.WebClient 
	$webClient.DownloadFile($url,$zipFile)
 
	$shellApp = New-Object -com shell.application 
	$destination = $shellApp.namespace($mongoDbPath) 
	$destination.Copyhere($shellApp.namespace($zipFile).items())
 
	#Copy-Item "$unzippedFolderContent\*" $mongoDbPath -recurse
 
	Remove-Item $unzippedFolderContent -recurse -force 
	Remove-Item $zipFile -recurse -force
 
	& $mongoDBPath\bin\mongod.exe --config $mongoDbConfigPath --install
 
	& net start mongodb
}