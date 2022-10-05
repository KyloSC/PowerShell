<#
.SYNOPSIS
    Removes a list of pre-deployed Windows 10 bloatware apps
    Author: Kyle Chadwick
    Date: 09 January 2019
    Version: 1.0

.DESCRIPTION
    This script will process an array of defined Windows 10 apps that are pre-installed in most editions of Windows 10 and remove them for all users.
    This means the apps will also not be installed for new users.

.EXAMPLE
    ??

.NOTES
    This script is designed to remove most Windows 10 apps that are not necessary and targets a corporate environment.
    This will not remove any apps that are deemed critical to the operation of Windows 10 so it should not cause any sysprep issues.
    #Apps list sourced from: https://docs.microsoft.com/en-us/windows/application-management/apps-in-windows-10
    This has been tested on Windows 10 1909.
.FUNCTIONALITY
    Created on Powershell v5.0+
#>

## Variables
$W10Apps = @(
    
    "96E699BA.-ECO-"
    "96E699BA.516784C40F2C7"
    "96E699BA.BatteryUtility"
    "96E699BA.FunctionManager3"
    "96E699BA.MicMuteUtility"
    "96E699BA.PointingDeviceUtility"
    "CyberLinkCorpYCM.YouCamforFujitsu"
    "Microsoft.3DBuilder"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.Messaging"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.MicrosoftStickyNotes"
    "Microsoft.MixedReality.Portal"
    "Microsoft.MSPaint"
    "Microsoft.Office.OneNote"
    "Microsoft.OneConnect"
    "Microsoft.People"
    "Microsoft.Print3D"
    "Microsoft.SkypeApp"
    "Microsoft.Wallet"
    "Microsoft.WindowsAlarms"
    "Microsoft.WindowsCamera"
    "microsoft.windowscommunicationsapps"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.WindowsMaps"
    "Microsoft.WindowsSoundRecorder"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxApp"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxGamingOverlay"
    "Microsoft.XboxIdentityProvider"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.YourPhone"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"

    )
 
## End of Variables
foreach ($W10App in $W10Apps) {
    Get-AppxProvisionedPackage -Online | Where-Object DisplayName -EQ $W10App | Remove-AppxProvisionedPackage -Online -AllUsers
    }
