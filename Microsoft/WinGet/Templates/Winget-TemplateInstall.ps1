<#
.SYNOPSIS
    WinGet Template Installer
    Author: Kyle Chadwick
    Date: 25 June 2021
    Version: 1.0
.DESCRIPTION
    Using WinGet, install multiple programs from a specified template. Templates available are:
	- Personal
	- Corporate
	- VM
.EXAMPLE
    ??
.NOTES
    https://github.com/MicrosoftDocs/windows-uwp/blob/docs/hub/package-manager/winget/index.md
.FUNCTIONALITY
    Created on Powershell v5.0+
    WinGet Package Manager
#>

$corporate = "https://raw.githubusercontent.com/KyloSC/PowerShell/master/Microsoft/WinGet/Templates/winget-corporate.csv"
$personal = "https://raw.githubusercontent.com/KyloSC/PowerShell/master/Microsoft/WinGet/Templates/winget-personal.csv"
$vmtest = "https://raw.githubusercontent.com/KyloSC/PowerShell/master/Microsoft/WinGet/Templates/winget-vm.csv"
$temp = "C:\Windows\Temp\"
$template = Read-Host -Prompt "Please select a template. C = Corporate, P = Personal, V = Virtual Test Machine"

If ($template -eq "C")
{
    Write-Host "Applying Corporate template." -ForegroundColor Green
    Invoke-RestMethod $corporate -OutFile $temp"corporate.csv"
    $apps = Import-Csv $temp"corporate.csv"
    foreach ($app in $apps)
    {
        winget install $app.App -h
    }
    Remove-Item $temp"corporate.csv"
}

If ($template -eq "P")
{
    Write-Host "Applying Personal template." -ForegroundColor Green
    Invoke-RestMethod $personal -OutFile $temp"personal.csv"
    $apps = Import-Csv $temp"personal.csv"
    foreach ($app in $apps)
    {
        winget install $app.App -h
    }
    Remove-Item $temp"personal.csv"
}

If ($template -eq "V")
{
    Write-Host "Applying Virtual Test Machine template." -ForegroundColor Green
    Invoke-RestMethod $vmtest -OutFile $temp"vmtest.csv"
    $apps = Import-Csv $temp"vmtest.csv"
    foreach ($app in $apps)
    {
        winget install $app.App -h
    }
    Remove-Item $temp"vmtest.csv"
}
