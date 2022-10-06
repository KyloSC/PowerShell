This script will connect to the local Veeam server and report a list of all Veeam Backup and Replication Jobs ran in the last 24 hours and their corresponding result, whether it be a Success, Warning or Failure. This information is sent via email to your required recipient. The Warning and Failure jobs are reported first. The success jobs will be reported at the bottom and easily identifiable.

The [Veeam PowerShell Module](https://www.veeam.com/kb1489) is required.
