<#
.SYNOPSIS
    Gather Veeam Job Creation Time
    Author: Kyle Chadwick
    Date: 25 June 2019
    Version: 1.0

.DESCRIPTION
    This script will connect to a Veeam server and report a list of all Veeam Backup and Replication Jobs
    on the connected server. The list will contain the Job Name, Job Type, VM Count and Last Creation
    Point Time. This list is then sent via email in a HTML Report.

.EXAMPLE
    ??

.NOTES
    ??
    
.FUNCTIONALITY
    Created on Powershell v3.0+
    Veeam for Powershell Module
#>

## Style Variables
$style = "<style>BODY{font-family: Calibri; font-size: 11pt;}"
$style = $style + "TABLE{border: 1px solid black; border-collapse: collapse;}"
$style = $style + "TH{border: 1px solid black; background: #70AD47; padding: 5px; }"
$style = $style + "TD{border: 1px solid black; padding: 5px; }"
$style = $style + "</style>"
## End of Style Variables

## Mail Variables
$smtpserver = "exchange.contoso.com"
$emailFrom = "sender@contoso.com"
$emailTo = "recipient@fabrikam.com"
$subject = "Veeam - Daily Job Creation Time Report"
## End of Mail Variables

Add-PSSnapin VeeamPSSnapin
Connect-VBRServer -Server localhost -ErrorAction SilentlyContinue

$body = Get-VBRBackup | Select-Object Name,TypeToString,VMCount,LastPointCreationTime | ConvertTo-Html -Head $style

$messageBody = $body | Out-String
Send-MailMessage -from $emailFrom -To $emailTo -Subject $subject -BodyAsHtml $messageBody -SmtpServer $smtpserver

Disconnect-VBRServer
