This Intune app will push out a scheduled task to silently remove all existing Outlook Profiles and create a new blank profile. Useful for migration projects or changes which may require new Outlook profiles.

To deploy as an Intune app, all files must be prepped using the [Microsoft Win32 Content Prep Tool](https://github.com/Microsoft/Microsoft-Win32-Content-Prep-Tool).

<ins>**Example Intune Deployment Settings**<ins>

**Install Command:** PowerShell -WindowStyle Hidden -ExecutionPolicy Bypass -File Install-ResetOutlookProfile.ps1

**Uninstall Command:** PowerShell -WindowStyle Hidden -ExecutionPolicy Bypass -File Uninstall-ResetOutlookProfile.ps1

**Install behaviour:** SYSTEM


**Detection Rule:**

**Run type:** File

**Path:** C:\Intune\

**File or Folder:** ResetOutlookProfile.bat

**Detection method:** File or Folder exists
