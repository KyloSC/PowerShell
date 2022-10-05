<#
.SYNOPSIS
    Check Recent Citrix NetScaler Logon Times
    Author: Kyle Chadwick
    Date: 14 January 2019
    Version: 1.0

.DESCRIPTION
    This script will connect to the local Citrix Delivery Controller and report on the most recent logon times
    to the NetScaler. This will allow you to confirm that successful logons are being performed. This information
    is then sent via email.

.EXAMPLE
    ??

.NOTES
    ??
    
.FUNCTIONALITY
    Created on Powershell v3.0+
    Citrix Powershell Module
#>

Add-PSSnapin *Citrix*
$recentlogon = Get-BrokerDesktop | Select-Object USERNAME,LastConnectionTime

## Mail Variables
$smtpserver = "exchange.contoso.com"
$emailFrom = "sender@contoso.com"
$emailTo = "recipient@fabrikam.com"
$subject = "Citrix - Recent Logon Sessions"
$body = $recentlogon
## End of Mail Variables

$messageBody = $body | Out-String
Send-MailMessage -Port 25 -from $emailFrom -To $emailTo -Subject $subject -Body $messageBody -SmtpServer $smtpserver
