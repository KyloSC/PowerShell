if exist %appdata%\resetoutlookprofile.txt exit
    reg delete HKCU\Software\Microsoft\Office\16.0\Outlook\Profiles /f 
    reg add HKCU\Software\Microsoft\Office\16.0\Outlook\Profiles
    reg add "HKCU\Software\Microsoft\Office\16.0\Outlook\Profiles\Outlook"
    echo 1 > %appdata%\resetoutlookprofile.txt
