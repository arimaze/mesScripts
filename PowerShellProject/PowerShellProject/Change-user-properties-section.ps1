#
# Change user properties section
#
$MySite = Get-SPSite "https://perso-intranet.bourbon-online.com"
$context = Get-SPServiceContext $MySite
$profileManager = New-Object Microsoft.Office.Server.UserProfiles.UserProfileManager($context)
$profilemanager.properties | ft name,displayorder


$profileManager.Properties.SetDisplayOrderByPropertyName("organization",5503)

