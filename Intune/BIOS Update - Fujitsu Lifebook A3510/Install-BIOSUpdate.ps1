<#
.SYNOPSIS
    Fujitsu Lifebook A3510 BIOS Update
    Author: Kyle Chadwick
    Date: 22 June 2022
    Version: 1.0

.DESCRIPTION
    This script was created to update the BIOS on Fujitsu Lifebook A3510 Laptops managed by Endpoint Manager.

    This is the install script.

.EXAMPLE
    ??

.NOTES
    https://www.fujitsu.com/emeia/imagesgig5/Fujitsu_DeskView_BIOS_Management_BIOS_Update_Tutorial.pdf
    
.FUNCTIONALITY
    Created on Powershell v5.0+
    Fujitsu Instant Desk View BIOS Management
#>

$BIOS = Get-WmiObject win32_bios

if ($BIOS.SMBIOSBIOSVersion -eq 'Version 1.13')
{
    New-ItemProperty -Path "HKLM:\Software\WOW6432Node\Fujitsu" -Name BIOSUpdatev113 -Value 1
    Exit
}

$BitLocker = Get-BitlockerVolume

if ($BitLocker.ProtectionStatus -eq 'On')
{
    Suspend-BitLocker -MountPoint "C:"
    .\Windows\DskFlash.exe /UPD /WD=.\Windows /O=A3510v113.bup /NRB /S
    New-ItemProperty -Path "HKLM:\Software\WOW6432Node\Fujitsu" -Name BIOSUpdatev113 -Value 1
}

if ($BitLocker.ProtectionStatus -eq 'Off')
{
    .\Windows\DskFlash.exe /UPD /WD=.\Windows /O=A3510v113.bup /NRB /S
    New-ItemProperty -Path "HKLM:\Software\WOW6432Node\Fujitsu" -Name BIOSUpdatev113 -Value 1
}
