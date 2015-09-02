New-SPContentDatabase "BB2013_PreProd_Applications_Content" -DatabaseServer "MRSSPSSPPP\SPPP" -WebApplication https://intranet-pre.bourbon-online.com -MaxSiteCount 5000 -WarningSiteCount 2000

New-SPManagedPath "Applications" -WebApplication "https://intranet-pre.bourbon-online.com" -Explicit

$url = "https://intranet-pre.bourbon-online.com/applications"
$ContentDatabase = "BB2013_PreProd_Applications_Content"
$WebsiteName = "Applications"
$WebsiteDesc = "Applications site"
$Template = "BourbonSite#2"
$PrimaryLogin = "bourbon\svc.wssadmin-pre"

New-SPSite -Url $url –ContentDatabase $ContentDatabase -Name $WebsiteName –Description $WebsiteDesc  -Template $Template -OwnerAlias $PrimaryLogin


get-spcontentdatabase | add-spshelladmin bourbon\svc.bippfront


--------------optionnel pour renommer une base ----------------------


USE MASTER;
GO

ALTER DATABASE  [BB2013_Pre_Applications_Content]
SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO

ALTER DATABASE [BB2013_Pre_Applications_Content]
MODIFY NAME= BB2013_PreProd_Applications_Content;
GO

ALTER DATABASE BB2013_PreProd_Applications_Content
SET MULTI_USER
GO


mount-SPContentDatabase BB2013_PreProd_Applications_Content -webapplication "https://intranet-pre.bourbon-online.com"