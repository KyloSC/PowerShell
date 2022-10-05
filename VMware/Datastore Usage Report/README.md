This script will use the VMware.VimAutomation.Core Powershell Snapin to connect to a VMware vCenter server, pull an overview of your datastores and then email a report to a specified email recipient. The numbers reported back in the overview are rounded using math to display in Gigabyte capacity rather than Megabyte.

The [VMware CLI PowerShell module](https://developer.vmware.com/web/tool/6.7/vsphere-cli) is required.
