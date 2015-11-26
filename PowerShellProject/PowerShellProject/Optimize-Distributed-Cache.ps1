#
Get-SPDistributedCacheClientSetting -ContainerType DistributedLogonTokenCache
 
$DLTC = Get-SPDistributedCacheClientSetting -ContainerType DistributedLogonTokenCache
$DLTC.maxBufferPoolSize = "1073741824"
$DLTC.maxBufferSize = "33554432"
$DLTC.requestTimeout = "3000"
$DLTC.channelOpenTimeOut = "3000"
##### WARNING ! 100 will be override below to reset to 1, else you will get many error on distributed cache in ULS Logs and Memory will be too high
$DLTC.MaxConnectionsToServer = "100"
##### END WARNING
Set-SPDistributedCacheClientSetting -ContainerType DistributedLogonTokenCache $DLTC
Restart-Service -Name AppFabricCachingService


##### Change RAM affected to distributed cache
#On all server with distributed cache :
Stop-SPDistributedCacheServiceInstance -Graceful
Update-SPDistributedCacheSize –CacheSizeInMb 3000
Start-SPDistributedCacheServiceInstance
######

$sts = Get-SPSecurityTokenServiceConfig
$sts.MaxServiceTokenCacheItems = "1500"
$sts.MaxLogonTokenCacheItems = "1500"
$sts.Update()


#
$DLTC = Get-SPDistributedCacheClientSetting -ContainerType DistributedLogonTokenCache
$DLTC.MaxConnectionsToServer = 1
Set-SPDistributedCacheClientSetting -ContainerType DistributedLogonTokenCache -DistributedCacheClientSettings $DLTC

#DistributedViewStateCache
$DVSC = Get-SPDistributedCacheClientSetting -ContainerType DistributedViewStateCache
$DVSC.MaxConnectionsToServer = 1
Set-SPDistributedCacheClientSetting -ContainerType DistributedViewStateCache $DVSC

#DistributedAccessCache
$DAC = Get-SPDistributedCacheClientSetting -ContainerType DistributedAccessCache
$DAC.MaxConnectionsToServer = 1
Set-SPDistributedCacheClientSetting -ContainerType DistributedAccessCache $DAC

#DistributedAccessCache
$DAF = Get-SPDistributedCacheClientSetting -ContainerType DistributedAccessCache
$DAF.MaxConnectionsToServer = 1
Set-SPDistributedCacheClientSetting -ContainerType DistributedActivityFeedCache $DAF

#DistributedActivityFeedLMTCache
$DAFC = Get-SPDistributedCacheClientSetting -ContainerType DistributedActivityFeedLMTCache
$DAFC.MaxConnectionsToServer = 1
Set-SPDistributedCacheClientSetting -ContainerType DistributedActivityFeedLMTCache $DAFC

#DistributedBouncerCache
$DBC = Get-SPDistributedCacheClientSetting -ContainerType DistributedBouncerCache
$DBC.MaxConnectionsToServer = 1
Set-SPDistributedCacheClientSetting -ContainerType DistributedBouncerCache $DBC

#DistributedDefaultCache
$DDC = Get-SPDistributedCacheClientSetting -ContainerType DistributedDefaultCache
$DDC.MaxConnectionsToServer = 1
Set-SPDistributedCacheClientSetting -ContainerType DistributedDefaultCache $DDC

#DistributedSearchCache
$DSC = Get-SPDistributedCacheClientSetting -ContainerType DistributedSearchCache
$DSC.MaxConnectionsToServer = 1
Set-SPDistributedCacheClientSetting -ContainerType DistributedSearchCache $DSC

#DistributedSecurityTrimmingCache
$DTC = Get-SPDistributedCacheClientSetting -ContainerType DistributedSecurityTrimmingCache
$DTC.MaxConnectionsToServer = 1
Set-SPDistributedCacheClientSetting -ContainerType DistributedSecurityTrimmingCache $DTC

#DistributedServerToAppServerAccessTokenCache
$DSTAC = Get-SPDistributedCacheClientSetting -ContainerType DistributedServerToAppServerAccessTokenCache
$DSTAC.MaxConnectionsToServer = 1
Set-SPDistributedCacheClientSetting -ContainerType DistributedServerToAppServerAccessTokenCache $DSTAC


$ViewStateCache = Get-SPDistributedCacheClientSetting -ContainerType DistributedViewStateCache 
$ViewStateCache.RequestTimeout = 6000

Set-SPDistributedCacheClientSetting -ContainerType DistributedViewStateCache -DistributedCacheClientSettings $ViewStateCache 


Get-SPDistributedCacheClientSetting -ContainerType DistributedViewStateCache 


use-cachecluster
restart-cachecluster
