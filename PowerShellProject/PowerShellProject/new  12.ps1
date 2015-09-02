Get-SPServiceInstance | Where {$_.TypeName.StartsWith("Claims")} | ForEach-Object {$_.Service.ProcessIdentity.CurrentIdentityType = 0; $_.Service.ProcessIdentity.Update(); $_.Service.ProcessIdentity.Deploy()}
Get-SPServiceInstance -server $env:COMPUTERNAME | Where {$_.TypeName.StartsWith("Claims")} | Stop-SPServiceInstance -confirm:$false > $null
Get-SPServiceInstance -server $env:COMPUTERNAME | Where {$_.TypeName.StartsWith("Claims")} | Start-SPServiceInstance -confirm:$false > $null



$tj = Get-SPTimerJob -Identity "job-service-instance-0fa94cce-c1b7-4f94-ae80-f49e8fdeef31"


PS C:\Users\svc.wssadmin-dev> Get-SPServiceInstance -server $env:COMPUTERNAME |
Where {$_.TypeName.StartsWith("Claims")} | Stop-SPServiceInstance -confirm:$fals
e > $null
PS C:\Users\svc.wssadmin-dev> $s=Get-SPServiceInstance -server $env:COMPUTERNAME
 | Where {$_.TypeName.StartsWith("Claims")}
PS C:\Users\svc.wssadmin-dev> $s.Unprovision()
$s=Get-SPServiceInstance -server $env:COMPUTERNAME | Where {$_.TypeName.StartsWith("Claims")}
PS C:\Users\svc.wssadmin-dev> $s.Unprovision()
PS C:\Users\svc.wssadmin-dev>




$w = Get-SPWebApplication -identity http://mybourbon-pre.bbdev.priv
$w.GrantAccessToProcessIdentity("bbdev\svc.bidfront")

$w = Get-SPWebApplication -identity http://mysite-pre.bbdev.priv
$w.GrantAccessToProcessIdentity("bbdev\svc.bidfront")

$w = Get-SPWebApplication -identity http://intranet-pre.bbdev.priv
$w.GrantAccessToProcessIdentity("bbdev\svc.bidfront")




get-spcontentdatabase | add-spshelladmin bbdev\svc.bidfront

























