#
# Prod_InstallCRM.ps1
#
#
# STEP 0: Sandbox solution started on 2 applications servers 03 & 04
# STEP 1 Create content DB and site collection
New-SPContentDatabase "BB2013_Prod_CRM_Content" -DatabaseServer "MRSSPSSPP\SPP" -WebApplication https://intranet.bourbon-online.com -MaxSiteCount 5000 -WarningSiteCount 2000
#Add database to AG
New-SPManagedPath "crm" -WebApplication "https://intranet.bourbon-online.com" -Explicit

$url = "https://intranet.bourbon-online.com/crm"
$ContentDatabase = "BB2013_Prod_CRM_Content"
$WebsiteName = "CRM"
$WebsiteDesc = "CRM site"
$Template = "BourbonSite#2"
$PrimaryLogin = "bourbon\svc.wssadmin-prod"

New-SPSite -Url $url –ContentDatabase $ContentDatabase -Name $WebsiteName –Description $WebsiteDesc  -Template $Template -OwnerAlias $PrimaryLogin

#STEP 2 Add the solution to the site collection via GUI

#STEP 3 Allow .htc files to the web app PORTAL-443 running this script
C:\Distrib\crm\AllowHtcExtn.ps1 "https://intranet.bourbon-online.com"

#STEP 4 IISreset all servers in the farm running this script
?C:\Users\svc.wssadmin-int\Desktop\PS_DoIISReset_AllServersInFarm.ps1

#STEP 5 Add bippfront to sp shell admin
get-spcontentdatabase | add-spshelladmin bourbon\svc.bipfront

#STEP 6 Add content data base to always on

#STEP 7 Set autogrow .mdf to 500 mb unlimited

#STEP 8 Delete ppssample page





