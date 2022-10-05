<#
.SYNOPSIS
    Hyper-V VM Daily Checkpoint
    Author: Kyle Chadwick
    Date: 16 April 2020
    Version: 1.0

.DESCRIPTION
    This script will create a checkpoint on all Hyper-V VMs. As part of the process, any checkpoints older than $Days will be removed.
    If a checkpoint has already been taken in the last 12 hours, the script will initiate an exit code. This script was intended to be
    run as a scheduled task upon startup.

.EXAMPLE
    ??

.NOTES
    ??
    
.FUNCTIONALITY
    Created on Powershell v7.3.0-preview.4
#>

$VM = "VM NAME HERE"
$VMSnapshot = Get-VMSnapshot -VMName $VM | Select-Object -Last 1

if ($VMSnapshots.CreationTime -gt (Get-Date).AddHours(-12))
{
    Exit
}

$Days = 7

$VMs = Get-VM -Name $VM
foreach ($VM in $VMs)
{
    $Snapshots = Get-VMSnapshot $VM

    foreach ($Snapshot in $Snapshots)
    {

        if ($snapshot.CreationTime.AddDays($Days) -lt (Get-Date))
        {
            Remove-VMSnapshot $Snapshot
        }
    }

    Checkpoint-VM $VM
}
