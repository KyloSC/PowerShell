<#
.SYNOPSIS
    Reset Outlook Profile
    Author: Kyle Chadwick
    Date: 29 September 2022
    Version: 1.0

.DESCRIPTION
    This script was created to automate the Outlook profile reset procedure. The script deploys a scheduled task which runs at logon of any user, it should only run once.

    This is the install script.

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

robocopy .\ C:\Intune\ ResetOutlookProfile.bat
robocopy .\ C:\Intune\ ResetOutlookProfile.vbs

$action = New-ScheduledTaskAction -Execute "C:\Intune\ResetOutlookProfile.vbs"
$trigger = New-ScheduledTaskTrigger -AtLogon
$settings = New-ScheduledTaskSettingsSet -Hidden
$STPrin = New-ScheduledTaskPrincipal -GroupId "BUILTIN\Users" -RunLevel Highest
Register-ScheduledTask -Action $action -Trigger $trigger -Settings $settings -TaskName "Reset Outlook Profile" -Description "Reset Outlook Profile - Modern Auth" -Principal $STPrin
