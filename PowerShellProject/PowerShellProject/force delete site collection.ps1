#
# force_delete_site_collection.ps1
#
$site = Get-SPSite https://intranet-int.bourbon-online.com/qa

$siteId = $site.Id

$siteDatabase = $site.ContentDatabase 

$siteDatabase.ForceDeleteSite($siteId, $false, $false)

