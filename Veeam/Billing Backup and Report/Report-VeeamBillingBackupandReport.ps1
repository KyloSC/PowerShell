<#
.SYNOPSIS
    Backup & Email Veeam Billing Reports
    Author: Kyle Chadwick
    Date: 8 August 2019
    Version: 1.0

.DESCRIPTION
    This script will backup all existing Veeam Billing Reports to another network based server, it is designed to run on
    a remote server, not the Veeam Backup server. It will then send the latest report via email to specified email
    recipients.

.EXAMPLE
    ??

.NOTES
    ??
    
.FUNCTIONALITY
    Created on Powershell v5.0+
#>

## Variables
$dir = 'LOCAL BACKUP DIRECTORY HERE'
$veeam = 'UNC PATH TO VEEAM SERVER BILLING FILES HERE'

$latest = Get-ChildItem -Path $dir | Sort-Object LastWriteTime -Descending | Select-Object -First 1
$latest.Fullname
## End of Variables

Remove-Item $dir + '\*' -Recurse

robocopy $veeam $dir *.pdf /E /Z /R:5 /W:5 /TBD /NP /V /MT:16

## Mail Variables
$smtpserver = 'exchange.contoso.com'
$emailFrom = 'sender@contoso.com'
$emailTo = 'recipient@fabrikam.com'
$emailBcc = 'recipient2@fabrikam.com'
$subject = 'Monthly Veeam Billing Report'
$attachment = $latest.Fullname
$body =
    'Attached you will find the latest Veeam Billing Report'
## End of Mail Variables

Send-MailMessage -To $emailTo -From $emailFrom -Bcc $emailBcc -Subject $subject -Body $body -Attachments $attachment -SmtpServer $smtpserver
