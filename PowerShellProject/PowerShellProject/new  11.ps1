New-SPContentDatabase "BB2013_Int_Applications_Content" -DatabaseServer "MRSSPSSPI\SPI" -WebApplication https://intranet-int.bourbon-online.com -MaxSiteCount 5000 -WarningSiteCount 2000

New-SPManagedPath "Applications" -WebApplication "https://intranet-int.bourbon-online.com" -Explicit

$url = "https://intranet-int.bourbon-online.com/applications"
$ContentDatabase = "BB2013_Int_Applications_Content"
$WebsiteName = "Applications"
$WebsiteDesc = "Applications site"
$Template = "BourbonSite#2"
$PrimaryLogin = "bbint\svc.wssadmin-int"

New-SPSite -Url $url –ContentDatabase $ContentDatabase -Name $WebsiteName –Description $WebsiteDesc  -Template $Template -OwnerAlias $PrimaryLogin
