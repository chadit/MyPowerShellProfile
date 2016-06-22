$secpasswd = ConvertTo-SecureString "ky1ttk#1" -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("chadit", $secpasswd)

$url = "http://build.digitalfleet.net/httpAuth/app/rest/builds/?locator=pinned:true"
$builds = (invoke-RestMethod -Credential $cred -Uri $url).builds
Write-Host "`n Build-Count : " $builds.count
$buildFile = $null;

Foreach ($build in $builds.build) {
#find the first Pinned item and deploys that to production
if($build.buildTypeId -eq "DigitalFleet_Api"){
Write-Host "`nBuild Pin Found"
if($buildFile -eq $null){
$buildFile = $build
break;
}
}
}


Write-Host $buildFileId " : " $buildFile.number
$test = 1234;


#$build = (Invoke-RestMethod -Credential $cred -Uri "http://build.digitalfleet.net/httpAuth/app/rest/builds/id:259").build;
#  $dateValue = [DateTime]::ParseExact($build.startdate.split("T")[0],'yyyyMMdd', $null) 
#  Write-Host $dateValue
#  $test = $dateValue