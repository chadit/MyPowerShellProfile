# update this location to point to the path of PowerShellProfile.ps1
$profileLocation = "\Users\$env:username\Dropbox\Documents\WindowsPowerShell\MyPowerShellProfile\Commands\PowerShellProfile.ps1"

if (Test-Path "C:$profileLocation"){
	. "C:$profileLocation"
}
elseif(Test-Path "D:$profileLocation")
{
	. "D:$profileLocation"
}
# SIG # Begin signature block
# MIIEMwYJKoZIhvcNAQcCoIIEJDCCBCACAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUMTp3dK8F8O2vDMcLHpV+RaSo
# O0qgggI9MIICOTCCAaagAwIBAgIQgNbg3JLrb6VI9kLIUCQthzAJBgUrDgMCHQUA
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
# FHpkMgxTiT+G4r3qwoEge5OKUQr1MA0GCSqGSIb3DQEBAQUABIGAnHudTuvJH3u6
# bKk9W/3PiAYCpHGaUbOY+GLno0gyMLtshHiDTWuGU/chzFHDOdlca1qoIhISApyv
# 3hGBCaHaCD/dyvCIHz0mIG3wTbIunrRtY7zaKgHyJ2b2hhp17Jx61qMMfUFMk7E0
# jU2hFgFh2hPRnv9vvXafkNhWsEgAfoo=
# SIG # End signature block
