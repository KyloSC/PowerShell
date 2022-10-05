<#
.SYNOPSIS
    Check Sophos Update Manager for latest AV Update Time
    Author: Kyle Chadwick & Nathan Carroll
    Date: 10 January 2019
    Version: 1.0

.DESCRIPTION
    This script will query the latest repository update times on a Sophos Enterprise Console server. This 
    information is then sent via email with an attached log file.

.EXAMPLE
    ??

.NOTES
    ??
    
.FUNCTIONALITY
    Created on Powershell v3.0+
#>

## Script Variables
$logdate = Get-Date -format ddMMyyyy
$logdir = "C:\ProgramData\Sophos\Update Manager\Logs\"
$searchterm = "*The synchronise operation was successful*"
$outputlog = "C:\Data\SophosUpdateLog - "+$logdate+".csv"
## End of Script Variables

## Mail Variables
$smtpserver = "exchange.contoso.com"
$emailFrom = "sender@contoso.com"
$emailTo = "recipient@fabrikam.com"
$subject = "Sophos - Repository Update Time"
$body =
    "Attached you will find the latest Sophos Update log."
## End of Mail Variables

$latest = Get-ChildItem -Path $logdir -Filter "SUMTrace*" | Sort-Object LastAccessTime -Descending | Select-Object -First 1
$latestlog = $latest.name
$log = get-content -path "$logdir\$latestlog"
Write-Host ""
Write-Host "Latest Log File name is: $Latest.name"
Write-Host ""
foreach ($line in $log) { 
   if ($line -like ($searchterm)) {
$line | out-file -FilePath $outputlog -Append
    }
}

Send-MailMessage -To $emailTo -From $emailFrom -Subject $subject -Body $body -Attachments $outputlog -SmtpServer $smtpserver
