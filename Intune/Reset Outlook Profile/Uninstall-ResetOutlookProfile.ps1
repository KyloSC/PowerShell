<#
.SYNOPSIS
    Reset Outlook Profile
    Author: Kyle Chadwick
    Date: 29 September 2022
    Version: 1.0

.DESCRIPTION
    This script was created to automate the Outlook profile reset procedure. The script deploys a scheduled task which runs at logon of any user, it should only run once.

    This is the uninstall script.

.EXAMPLE
    ??

.NOTES
    Intune Assignment Details:

    Install Command: PowerShell -WindowStyle Hidden -ExecutionPolicy Bypass -File Install-ResetOutlookProfile.ps1
    Uninstall Command: PowerShell -WindowStyle Hidden -ExecutionPolicy Bypass -File Uninstall-ResetOutlookProfile.ps1
    Install behaviour: SYSTEM

    Detection Rule:
    Run type: File
    Path: C:\Intune\
    File or folder: ResetOutlookProfile.bat
    Detection method: File or Folder exists
    
.FUNCTIONALITY
    Created on Powershell v5.0+
#>

Unregister-ScheduledTask -TaskName "Reset Outlook Profile" -Confirm:$False
Remove-Item -Path $env:APPDATA\resetoutlookprofile.txt -Force
Remove-Item -Path C:\Intune\ResetOutlookProfile.bat -Force
Remove-Item -Path C:\Intune\ResetOutlookProfile.vbs -Force
