$mongodata = "C:\mongo\data\db"
if(Test-Path $mongodata){
	Write-Host "Mongo folder exist deleting it"
	Remove-Item -force $mongodata 
}