#
# Profile.ps1 - main powershell profile script
# 
# Applies to all hosts, so only put things here that are global
#

# Helper functions for all interfaces
function Test-LocationFromPath{
	param ($path)
	# test if on C or D drive, can be expanded
	if (Test-Path "D:$path"){
		return "D:$path"
	}
	elseif(Test-Path "C:$path")
	{
		return "C:$path"
	}
}

function Set-LocationFromPath{
	param ($location)
	Write-Host "Setting Path to $location"  -foregroundcolor Cyan 
	
	# test if on C or D drive, can be expanded
	if (Test-Path "D:$location"){
		Set-Location "D:$location"
	}
	elseif(Test-Path "C:$location")
	{
		Set-Location "C:$location"
	}
}

# Setup the $home directory correctly
$global:dropbox = Test-LocationFromPath("\Users\$env:username\Dropbox")
$global:skydrive = Test-LocationFromPath("\Users\$env:username\SkyDrive")
$global:homedir = "$dropbox\Documents\WindowsPowerShell"

# Check for and load profile.
$location = "$homedir\MyPowerShellProfile\Commands\profile.ps1"

if (Test-Path $location){
	. $location
}



# SIG # Begin signature block
# MIIEMwYJKoZIhvcNAQcCoIIEJDCCBCACAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUruVN7NlfCoXSnWQttBG1Lq/Q
# ibKgggI9MIICOTCCAaagAwIBAgIQgNbg3JLrb6VI9kLIUCQthzAJBgUrDgMCHQUA
# MCwxKjAoBgNVBAMTIVBvd2VyU2hlbGwgTG9jYWwgQ2VydGlmaWNhdGUgUm9vdDAe
# Fw0xMjA4MDUyMjU2MzNaFw0zOTEyMzEyMzU5NTlaMBoxGDAWBgNVBAMTD1Bvd2Vy
# U2hlbGwgVXNlcjCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEA4ecHHYNzGmwM
# VoBYLMpPIVxVeb9u4jDZv8cZm1DaGVe5bIgUvKPxaP/MHYxUo6cLuX/JIfiauHSx
# dZO1HU97BBvAQFi8Rlt5lrYedvHhgysi39Edo+nPSsoqIyGBgRc/b1LDxOWjAc+F
# Vfv0S7hLJRj3NDKkge6bVAdED7yhYusCAwEAAaN2MHQwEwYDVR0lBAwwCgYIKwYB
# BQUHAwMwXQYDVR0BBFYwVIAQuxE/5fpoBvIaWJ9lAUxEdqEuMCwxKjAoBgNVBAMT
# IVBvd2VyU2hlbGwgTG9jYWwgQ2VydGlmaWNhdGUgUm9vdIIQWdH9AgK9n4ZBrGVl
# v5Z58zAJBgUrDgMCHQUAA4GBAJlhwOWbaTJMbJpmVIvzho4COoN++vbplczwhpqL
# 8wI/NNaKoqSrMHZWWftYGleEvv7Q1aRFKzaHtpTMtVDFWTnblSc8jXxVurHVFT3s
# S4F0PeDgZB8mIztOPwUy6+yfJcxEcar4wHW4YnHUi3zcJlsw74PmQdtNJYCwna6w
# UB1wMYIBYDCCAVwCAQEwQDAsMSowKAYDVQQDEyFQb3dlclNoZWxsIExvY2FsIENl
# cnRpZmljYXRlIFJvb3QCEIDW4NyS62+lSPZCyFAkLYcwCQYFKw4DAhoFAKB4MBgG
# CisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcC
# AQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYE
# FJnivegwV2cHyQH8x64C4XEmF31nMA0GCSqGSIb3DQEBAQUABIGAjTvEjxx9b8sA
# S0V6pNpYmzT6MV7z8m2rvRZMiNSZ3NF4VrtB+uvAv8JtPodSwPX8gtN6oZbv2d7F
# E+pWNwET5JGqHGJoaaxegqbEvKMstfrgZQNwn6+OSxwsREK96VlanmS5kl+YpmQs
# yqUlCTFwceUQFASHcRir828gjjTLkIs=
# SIG # End signature block
