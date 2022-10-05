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

    This is the install script.

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
$newpwd = "PASSWORD GOES HERE"

if ($BitLocker.ProtectionStatus -eq 'On')
{
    Suspend-BitLocker -MountPoint "C:"
    .\amd64\BiosSet.exe /NEWPWD=$newpwd /Q
    .\amd64\BiosSet.exe /PWD=$newpwd /BM=OFF /Q
    Resume-BitLocker -MountPoint "C:"
    New-ItemProperty -Path "HKLM:\Software\WOW6432Node\Fujitsu" -Name BIOSConfigured -Value 1
}

if ($BitLocker.ProtectionStatus -eq 'Off')
{
    .\amd64\BiosSet.exe /NEWPWD=$newpwd /Q
    .\amd64\BiosSet.exe /PWD=$newpwd /BM=OFF /Q
    New-ItemProperty -Path "HKLM:\Software\WOW6432Node\Fujitsu" -Name BIOSConfigured -Value 1
}

<# The below section is an example of how the script might look if there is a requirement to update an existing BIOS password.

$BitLocker = Get-BitlockerVolume
$oldpwd = "Password1"
$newpwd = "Password2"

if ($BitLocker.ProtectionStatus -eq 'On')
{
    Suspend-BitLocker -MountPoint "C:"
    .\amd64\BiosSet.exe /PWD=$oldpwd /NEWPWD=$newpwd /Q
    Resume-BitLocker -MountPoint "C:"
    New-ItemProperty -Path "HKLM:\Software\WOW6432Node\Fujitsu" -Name BIOSConfigured -Value 1
}

if ($BitLocker.ProtectionStatus -eq 'Off')
{
    .\amd64\BiosSet.exe /PWD=$oldpwd /NEWPWD=$newpwd /Q
    New-ItemProperty -Path "HKLM:\Software\WOW6432Node\Fujitsu" -Name BIOSConfigured -Value 1
}
#>
