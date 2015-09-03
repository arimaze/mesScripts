#
# InstallCRM.ps1
#
# STEP 0: Sandbox solution started on 2 applications servers 03 & 04
# STEP 1 Create content DB and site collection
New-SPContentDatabase "BB2013_Int_CRM_Content" -DatabaseServer "MRSSPI01\SPI" -WebApplication https://intranet-int.bourbon-online.com -MaxSiteCount 5000 -WarningSiteCount 2000
New-SPManagedPath "crm" -WebApplication "https://intranet-int.bourbon-online.com" -Explicit

$url = "https://intranet-int.bourbon-online.com/crm"
$ContentDatabase = "BB2013_Int_CRM_Content"
$WebsiteName = "CRM"
$WebsiteDesc = "CRM site"
$Template = "BourbonSite#2"
$PrimaryLogin = "bbint\svc.wssadmin-int"

New-SPSite -Url $url –ContentDatabase $ContentDatabase -Name $WebsiteName –Description $WebsiteDesc  -Template $Template -OwnerAlias $PrimaryLogin

#STEP 2 add the solution to the site collection via GUI

#STEP 3 allow .htc files to the web app PORTAL-443 running this script
C:\Distrib\crm\AllowHtcExtn.ps1 "https://intranet-int.bourbon-online.com"

#STEP 4 IISreset all servers in the farm running this script
?C:\Users\svc.wssadmin-int\Desktop\PS_DoIISReset_AllServersInFarm.ps1

#STEP 5 add bipfront to sp shell admin

#STEP 6 add content data base to always on

#STEP 7 set autogrow .mdf to 500 mb unlimited



