#
# Create_PerformancePoint_ServiceApplication.ps1
#
$SvcAppPool = New-SPServiceApplicationPool -Name "BIPerformancePointServices" -Account (Get-SPManagedAccount bbint\svc.biifront)


Get-SPServiceApplicationPool | Select Name


$SvcAppPool = Get-SPServiceApplicationPool "BIPerformancePointServices"



$SvcApp = New-SPPerformancePointServiceApplication –ApplicationPool $SvcAppPool -Name "BI-PerformancePoint" -DatabaseName "BB2013_Int_PerformancePointService"

Get-SPServiceApplication | Select Name

$SvcApp = "BI-PerformancePoint"
$SvcAppProxy = New-SPPerformancePointServiceApplicationProxy -Name "BI-PerformancePoint Proxy" -ServiceApplication $SvcApp


Get-SPServiceApplicationProxy | Select Name
