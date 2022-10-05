<#
.SYNOPSIS
    Fujitsu Lifebook A3510 BIOS Configuration
    Author: Kyle Chadwick
    Date: 9 June 2022
    Version: 1.0

.DESCRIPTION
    This script was created to configure the BIOS on Fujitsu Lifebook A3510 Laptops managed by Endpoint Manager. The script will:

    - Disable Boot menu
    - Set BIOS Password

    If required, this script can also be pushed out to update existing BIOS passwords, details described in comment section.

    This is the uninstall script.

.EXAMPLE
    ??

.NOTES
    https://www.fujitsu.com/emeia/imagesgig5/Fujitsu_DeskView_BIOS_Management_Overview_Tutorial.pdf
    https://support.ts.fujitsu.com/IndexDownload.asp?lng=en
    
.FUNCTIONALITY
    Created on Powershell v5.0+
    Fujitsu Instant Desk View BIOS Management
#>

$BitLocker = Get-BitlockerVolume
$biospwd = "PASSWORD GOES HERE"

if ($BitLocker.ProtectionStatus -eq 'On')
{
    Suspend-BitLocker -MountPoint "C:"
    .\amd64\BiosSet.exe /PWD=$biospwd /BM=ON /Q
    .\amd64\BiosSet.exe /PWD=$biospwd /NEWPWD=$null /Q
    Resume-BitLocker -MountPoint "C:"
    Remove-ItemProperty -Path "HKLM:\Software\WOW6432Node\Fujitsu" -Name BIOSConfigured
}

if ($BitLocker.ProtectionStatus -eq 'Off')
{
    .\amd64\BiosSet.exe /PWD=$biospwd /BM=ON /Q
    .\amd64\BiosSet.exe /PWD=$biospwd /NEWPWD=$null /Q
    Remove-ItemProperty -Path "HKLM:\Software\WOW6432Node\Fujitsu" -Name BIOSConfigured
}
