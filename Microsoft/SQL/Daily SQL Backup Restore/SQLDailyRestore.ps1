<#
.SYNOPSIS
    Restore SQL .bak file via FTP to SQL Database
    Author: Kyle Chadwick
    Date: 11 September 2019
    Version: 1.0

.DESCRIPTION
    This script will download a 7Zip file via FTP, extract the archive and restore the .bak file within to a SQL database.

.EXAMPLE
    ??

.NOTES
    Ensure that the WinSCPNet.dll is unlocked when you right click and view Properties and that the file is located in the
    same directory as WinSCP.exe.
    This script invokes a SQLCMD script based off the GUI using your preferred restore settings
.FUNCTIONALITY
    Created on Powershell v5.0+
    SQLServer Module
    7Zip4Powershell Module
    Download WinSCP .NET Assembly/COM Assembly Here - https://winscp.net/eng/downloads.php#additional
#>

## Variables
$instance = "SQL SERVER NAME HERE"
$db = "SQL DB NAME HERE"
$sftpsource = "/*.7z"
$sftpdestination = "C:\SQLScripts\Backup\*"
$7ZipFile = "C:\SQLScripts\Backup\" + $DB +".7z"
$7ZipPwd = "7ZIP PASSWORD HERE"
$7ZipPath = "C:\SQLScripts\Backup\"
$sqlcmd = "C:\SQLScripts\SQLCMDRestore.sql"
$smtpserver = "exchange.contoso.com"
$emailFrom = "sender@contoso.com"
$emailTo = "recipient@fabrikam.com"
$subject = "[JobResult] Daily SQL Database Restore"
$body = @()
## End of Variables

## Delete pre-existing files in directory
Remove-Item $sftpdestination -Recurse

## Downloads the file via FTP

## Load WinSCP .NET assembly
Add-Type -Path "WinSCPnet.dll"

## Set up session options
$sessionOptions = New-Object WinSCP.SessionOptions -Property @{
    Protocol = [WinSCP.Protocol]::Ftp
    HostName = "FTP SERVER NAME HERE"
    UserName = "FTP USERNAME HERE"
    Password = "FTP PASSWORD HERE"
    FtpSecure = [WinSCP.FtpSecure]::Implicit
}

$session = New-Object WinSCP.Session

        ## Connect
        $session.Open($sessionOptions)
 
        ## Download files
        $transferOptions = New-Object WinSCP.TransferOptions
        $transferOptions.TransferMode = [WinSCP.TransferMode]::Binary
 
        $transferResult =
            $session.GetFiles($sftpsource, $sftpdestination, $False, $transferOptions)
 
        ## Throw on any error
        $transferResult.Check()
 
        ## Print results
        foreach ($transfer in $transferResult.Transfers)
        {
            $body += "FTP Download of $($transfer.FileName) succeeded"
        }
    
Expand-7Zip -ArchiveFileName $7ZipFile -Password $7ZipPwd -TargetPath $7ZipPath

#Restore-SqlDatabase -ServerInstance $instance -Database $db -BackupFile $restoredbak -ReplaceDatabase

Invoke-Sqlcmd -ServerInstance $instance -InputFile $sqlcmd

$body += "
SQL Restore of $db succeeded"

$messagebody = $body | Out-String

Send-MailMessage -from $emailFrom -To $emailTo -Subject $subject -Body $messagebody -SmtpServer $smtpserver
