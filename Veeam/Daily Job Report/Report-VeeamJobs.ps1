<#
.SYNOPSIS
    Collects Veeam B&R Job Results
    Author: Kyle Chadwick
    Date: 11 January 2019
    Version: 1.0

.DESCRIPTION
    This script will connect to a Veeam server and report a list of all Veeam Backup and Replication Jobs
    ran in the last 24 hours and their corresponding result, whether it be a Success, Warning or Failure.
    This information is sent via email to your required recipient. The Warning and Failure jobs are reported
    first. The success jobs will be reported at the bottom and easily identifiable.

.EXAMPLE
    ??

.NOTES
    ??
    
.FUNCTIONALITY
    Created on Powershell v3.0+
    Veeam for Powershell Module
#>

## Add Veeam PS Snapins
Add-PSSnapin VeeamPSSnapin
Connect-VBRServer -Server localhost -ErrorAction SilentlyContinue
 
## Get backup sessions from last 24 hours
$JobStatus = Get-VBRBackupsession | Where-Object{$_.EndTime -gt ((Get-Date).AddHours(-24))} | Select-Object JobName,EndTime,Result,JobTypeString
$FailedJobs = $JobStatus | Where-Object{$_.Result -contains "failed"} | Select-Object JobName
$WarningJobs = $JobStatus | Where-Object{$_.Result -contains "Warning"} | Select-Object JobName
#$SuccessJobs = $JobStatus | Where-Object{$_.Result -contains "Success"} | Select-Object JobName

## Mail Variables
$smtpserver = "exchange.contoso.com"
$emailFrom = "sender@contoso.com"
$emailTo = "recipient@fabrikam.com"
$subject = "Veeam - Daily Job Report"
$body = @()
## End of Mail Variables

 
## Display the Failed and Warning job counts
$body += "Failed Jobs: " + $FailedJobs.JobName.Count
$body += "Warning Jobs: " + $WarningJobs.JobName.Count
$body += "================"
      
## Display the job names and their status
foreach ($n in $JobStatus) {
    if ($n.Result -eq "Failed") {
        $body += $n.JobName + " (" + $n.JobTypeString + ") - " + $n.Result + ",`n"
        
     }
  }

  foreach ($n in $JobStatus) {
    if ($n.Result -eq "Warning") {
        $body += $n.JobName + " (" + $n.JobTypeString + ") - " + $n.Result + ",`n"
        
     }
  }

  $body += "================DO NOT COPY"

  foreach ($n in $JobStatus) {
    if ($n.Result -eq "Success") {
        $body += $n.JobName + " (" + $n.JobTypeString + ") - " + $n.Result + ",`n"
        
     }
  }
 


## Send the email
$messageBody = $body | Out-String
Send-MailMessage -from $emailFrom -To $emailTo -Subject $subject -Body $messageBody -SmtpServer $smtpserver

## Cleanup
Disconnect-VBRServer
