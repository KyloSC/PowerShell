This Intune app will deploy a standard BIOS configuration to Fujitsu Lifebook A3510 Laptops. By default the app will disable access to the Boot Menu and set a BIOS password.

To deploy as an Intune app, all files must be prepped using the [Microsoft Win32 Content Prep Tool](https://github.com/Microsoft/Microsoft-Win32-Content-Prep-Tool).

<ins>**Example Intune Deployment Settings**<ins>

**Install Command:** PowerShell -ExecutionPolicy Bypass -File Install-BIOSConfiguration.ps1

**Uninstall Command:** PowerShell -ExecutionPolicy Bypass -File Uninstall-BIOSConfiguration.ps1

**Install behaviour:** SYSTEM

**Detection Rule:**

**Rule type:** Registry

**Key Path:** HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Fujitsu

**Value name:** BIOSConfigured

**Detection method:** Value exists

**Associated with a 32-bit app on 64-bit clients:** Yes
