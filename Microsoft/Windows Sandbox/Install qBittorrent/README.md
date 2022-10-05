This is a custom Windows Sandbox configuration file which deploys the sandbox environment and installs [qBittorrent](https://github.com/qbittorrent/qBittorrent) at logon.

Install-qBittorrent.ps1 should be mapped inside a directory on the host machine to the sandbox environment. By default, the source directory to map is C:\Data\Sandbox. The source directory can be changed by modifying the HostFolder configuration inside SandboxInstall-qBittorrent.wsb

Updated versions of the installer need to be manually updated in Install-qBittorrent.ps1 using the $uri variable.

The configuration can be launched by running SandboxInstall-qBittorrent.wsb
