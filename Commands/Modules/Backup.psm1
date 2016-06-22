function MirrorDrive{
	param([string] $source = "Y", [string]$destination = "Z")
	$source += ":\"
	$destination += ":\"

	$exclude = $destination + "System Volume Information"
	$exclude2 = $destination + "$" + "RECYCLE.BIN"

	# $RECYCLE.BIN

	write-host "copying files from $source to $destination excluding $exclude, $exclude2"

 	#/r:0 sets the retry count
	robocopy $source $destination /mir /r:3 /xd $exclude /xd $exclude2
}

function MirrorWork{
	param([string] $source = "D:\Projects", [string]$destination = "F:\shares\Projects\WorkDesktop")
	#$source += "\"
	#$destination += "\"

	$exclude = $destination + "System Volume Information"
	$exclude2 = $destination + "$" + "RECYCLE.BIN"

	# $RECYCLE.BIN

	write-host "copying files from $source to $destination excluding $exclude, $exclude2"

 	#/r:0 sets the retry count
	robocopy $source $destination /mir /r:3 /xd $exclude /xd $exclude2
}

function BackupPicturesToExternalDriveWork{
	param([string] $source = "C:\Users\chad.england\SkyDrive\Pictures", [string]$destination = "F:\shares\Photos")
	#$source += "\"
	#$destination += "\"

	$exclude = $destination + "System Volume Information"
	$exclude2 = $destination + "$" + "RECYCLE.BIN"

	# $RECYCLE.BIN

	write-host "copying files from $source to $destination excluding $exclude, $exclude2"

 	#/r:0 sets the retry count
	robocopy $source $destination /mir /r:3 /xd $exclude /xd $exclude2
}

function SyncDrives{
	param([string] $source = "F", [string]$destination = "Z")
	$source += ":\"
	$destination += ":\"

	$exclude = $destination + "System Volume Information"
	$exclude2 = $destination + "$" + "RECYCLE.BIN"

	# $RECYCLE.BIN

	#/r:0 sets the retry count
	write-host "copying files from $source to $destination excluding $exclude, $exclude2"
	robocopy $source $destination /E /XO /r:3 /xd $exclude /xd $exclude2
	write-host "copying files from $destination to $source excluding $exclude, $exclude2"
	robocopy $destination $source /E /XO /r:3 /xd $exclude /xd $exclude2
}

function CopyFiles{
	$arSourceFolders = ("D:\Users\Chad\SkyDrive\Pictures\Library");
	$arDestinationFolders = ("\\DDESK\Library");

	#if($arSourceFolders.Length -ne $arDestinationFolders.Length)
	#{
		#    Write-host -foregroundcolor 'red' "The numbers of folders have to similar";
	#}
	#else{
		#    for($i=0; $i -lt $arSourceFolders.Length; $i++)
	#    {
        	Write-host -foregroundcolor 'green' "Process " $arSourceFolders " -> " $arDestinationFolders ;
        	robocopy $arSourceFolders $arDestinationFolders /E /R:0 /xo
	#    }
	#}

	Write-host -foregroundcolor 'green' "Done :)";
}

function MoveFiles{
	$arSourceFolders = ("C:\Users\cengland\Downloads");
	$arDestinationFolders = ("D:\Users\cengland\downloads");

        Write-host -foregroundcolor 'green' "Process " $arSourceFolders " -> " $arDestinationFolders ;
        robocopy $arSourceFolders $arDestinationFolders /Z /S /MOVE
    
	Write-host -foregroundcolor 'green' "Done :)";
}