This is a custom Windows Sandbox configuration file which deploys the sandbox environment and installs [qBittorrent](https://github.com/qbittorrent/qBittorrent) at logon.

Install-qBittorrent.ps1 should be mapped inside a folder on the host machine to the sandbox environment. By default, the folder to map is C:\Data\Sandbox.

Updated versions of the installer need to be manually updated in Install-qBittorrent.ps1 using the $uri variable.

The configuration can be launched by running SandboxInstall-qBittorrent.wsb
