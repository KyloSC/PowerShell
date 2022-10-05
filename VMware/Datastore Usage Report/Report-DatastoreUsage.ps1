<#
.SYNOPSIS
    Collects an overview of VMware Datastores and email the report in HTML format.
    Author: Kyle Chadwick
    Date: 16 January 2019
    Version: 1.0

.DESCRIPTION
    This script will use the VMware.VimAutomation.Core Powershell Snapin to connect to a 
    VMware vCenter server, pull an overview of your datastores and then email a report to a specified
    email recipient. The numbers reported back in the overview are rounded using math to display
    in Gigabyte capacity rather than Megabyte.

.EXAMPLE
    ??

.NOTES
    Run the below command first, entering your vSphere credentials which are then stored on the vCenter Server
    Add-PSSnapin "VMware.VimAutomation.Core"
    New-VICredentialStoreItem -Host [HOSTNAME] -User [USERNAME] -Password [PASSWORD]
    
.FUNCTIONALITY
    Created on Powershell v5.0+
    VMware CLI Powershell Module
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
$subject = "VMware vCenter - Datastore Usage Overview"
## End of Mail Variables

## vCenter Variables
$vCenter = "vcenterserver.contoso.com"

Add-PSSnapin "VMware.VimAutomation.Core"

Connect-VIServer $vCenter

$body = Get-Datastore | Select-Object name,@{ Label = "FreespaceGB"; Expression = { [Math]::Round($_.FreeSpaceMB * 1MB / 1GB, 2) }}, @{ Label = "CapacityGB"; Expression = { [Math]::Round($_.CapacityMB * 1MB / 1GB, 2) }} | Select-Object Name,FreespaceGB,CapacityGB | ConvertTo-Html -Head $style

$messageBody = $body | Out-String
Send-MailMessage -from $emailFrom -To $emailTo -Subject $subject -BodyAsHtml $messageBody -SmtpServer $smtpserver
