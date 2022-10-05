This Intune app will deploy a BIOS update for Fujitsu Lifebook A3510 Laptops. This particular version updates to BIOS v1.13. New BIOS updates can be downloaded from [Fujitsu](https://support.ts.fujitsu.com/IndexDownload.asp?lng=en)

To deploy as an Intune app, all files must be prepped using the [Microsoft Win32 Content Prep Tool](https://github.com/Microsoft/Microsoft-Win32-Content-Prep-Tool).

<ins>**Example Intune Deployment Settings**<ins>

**Install Command:** PowerShell -ExecutionPolicy Bypass -File Install-BIOSUpdate.ps1

**Uninstall Command:** PowerShell -ExecutionPolicy Bypass -File Uninstall-BIOSUpdate.ps1

**Install behaviour:** SYSTEM

**Detection Rule:**

**Rule type:** Registry

**Key Path:** HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Fujitsu

**Value Name:** BIOSUpdatev113

**Detection method:** Value exists

**Associated with a 32-bit app on 64-bit clients:** Yes
