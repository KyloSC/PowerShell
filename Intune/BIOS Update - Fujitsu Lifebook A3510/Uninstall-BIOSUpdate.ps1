<#
.SYNOPSIS
    Fujitsu Lifebook A3510 BIOS Update
    Author: Kyle Chadwick
    Date: 22 June 2022
    Version: 1.0

.DESCRIPTION
    This script was created to update the BIOS on Fujitsu Lifebook A3510 Laptops managed by Endpoint Manager.

    This is the uninstall script.

.EXAMPLE
    ??

.NOTES
    https://www.fujitsu.com/emeia/imagesgig5/Fujitsu_DeskView_BIOS_Management_BIOS_Update_Tutorial.pdf
    
.FUNCTIONALITY
    Created on Powershell v5.0+
    Fujitsu Instant Desk View BIOS Management
#>

Remove-Item -Path "HKLM:\Software\WOW6432Node\Fujitsu" -Name BIOSUpdatev113
