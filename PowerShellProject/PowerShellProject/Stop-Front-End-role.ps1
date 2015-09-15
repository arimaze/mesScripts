$server = "MRSSPI03"
$service = Get-SPServiceInstance -Server $server | where-object {$_.TypeName -eq "Microsoft SharePoint Foundation Web Application"}
$service | Stop-SPServiceInstance -confirm:$false > $null
while(-not ($service.Status -eq "Disabled")){
    write-host -ForegroundColor Yellow $service.Status; sleep 5;
    $service = Get-SPServiceInstance -Server $server | where-object {$_.TypeName -eq "Microsoft SharePoint Foundation Web Application"}
}


$server = "MRSSPI03"
$service = Get-SPServiceInstance -Server $server | where-object {$_.TypeName -eq "Microsoft SharePoint Foundation Web Application"}
while(-not ($service.Status -eq "Disabled")){
    write-host -ForegroundColor Yellow $service.Status; sleep 5;
    $service = Get-SPServiceInstance -Server $server | where-object {$_.TypeName -eq "Microsoft SharePoint Foundation Web Application"}
}








$server = "MRSSPI03"
Get-SPServiceInstance -Server $server | where-object {$_.TypeName -eq "Microsoft SharePoint Foundation Web Application"} | Start-SPServiceInstance -confirm:$false > $null