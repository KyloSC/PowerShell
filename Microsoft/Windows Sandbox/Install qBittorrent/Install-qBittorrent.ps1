$uri = "https://sourceforge.net/projects/qbittorrent/files/qbittorrent-win32/qbittorrent-4.4.5/qbittorrent_4.4.5_x64_setup.exe/download"

New-Item -Path "C:\" -Name "Scripts" -ItemType "Directory"
Invoke-WebRequest -UserAgent "wget" -Uri $uri -OutFile "C:\Scripts\qBittorrent.exe"
Start-Process -FilePath "C:\Scripts\qBittorrent.exe" /S
Start-Process -FilePath "C:\Program Files\qBittorrent\qBittorrent.exe"
