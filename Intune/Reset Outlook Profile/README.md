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
