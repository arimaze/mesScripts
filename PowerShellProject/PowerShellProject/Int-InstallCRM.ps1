#
# InstallCRM.ps1
#
New-SPContentDatabase "BB2013_Int_CRM_Content" -DatabaseServer "MRSSPI01\SPI" -WebApplication https://intranet-int.bourbon-online.com -MaxSiteCount 5000 -WarningSiteCount 2000
New-SPManagedPath "crm" -WebApplication "https://intranet-int.bourbon-online.com" -Explicit

$url = "https://intranet-int.bourbon-online.com/crm"
$ContentDatabase = "BB2013_Int_CRM_Content"
$WebsiteName = "CRM"
$WebsiteDesc = "CRM site"
$Template = "BourbonSite#2"
$PrimaryLogin = "bbint\svc.wssadmin-int"

New-SPSite -Url $url –ContentDatabase $ContentDatabase -Name $WebsiteName –Description $WebsiteDesc  -Template $Template -OwnerAlias $PrimaryLogin