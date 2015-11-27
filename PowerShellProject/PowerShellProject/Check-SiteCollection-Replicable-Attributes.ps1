#
# Check_SiteCollection_Replicable_Attributes.ps1
#
$site = Get-SPSite https://hub.bourbon-online.com/workspaces
$user = $site.RootWeb.SiteUsers | ?{$_.UserLogin -match "ngregot"}
$user | fl *


$user = Get-SPUser -Identity "i:0#.w|bourbon\ngregot" -Web https://hub.bourbon-online.com
$user | fl *