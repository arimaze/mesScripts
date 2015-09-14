#
# Refonte_Pre_Prod.ps1
#
# Shrinks all large logs file
# Free space 407 data and 153 logs
# Change backup logs maintenance plan to 15 mns on 101 and 102 nodes

# On MRSSPS103
# Check orphans
$db=get-spcontentdatabase bb2013_preprod_portal_content
$db.repair($false)
$db.repair($true)


# rename folder because names are too long by checking with this command
SELECT
   CONCAT([DirName], N'/', [LeafName]) AS [FullRelativePath],
   LEN(CONCAT([DirName], N'/', [LeafName])) AS [Length]
FROM 
   [dbo].[AllDocs]
ORDER BY 
   [Length] DESC

#Move my dashboard
New-SPContentDatabase "BB2013_PreProd_Dashboards_Content" -DatabaseServer "MRSSPSSPPP\SPPP" -WebApplication https://intranet-pre.bourbon-online.com -MaxSiteCount 5000 -WarningSiteCount 2000
Move-SPSite https://intranet-pre.bourbon-online.com/mydashboards -DestinationDatabase BB2013_PreProd_Dashboards_Content
Get-SPSite -ContentDatabase BB2013_PreProd_Portal_Content
Get-SPSite -ContentDatabase BB2013_PreProd_Dashboards_Content
get-spcontentdatabase | add-spshelladmin bourbon\svc.bippfront


Backup-SPSite -Identity https://intranet-pre.bourbon-online.com -Path \\mrssps102\t$\root.bak

New-SPContentDatabase "BB2013_PreProd_Quality_Content" -DatabaseServer "MRSSPSSPPP\SPPP" -WebApplication https://intranet-pre.bourbon-online.com -MaxSiteCount 5000 -WarningSiteCount 2000

#Add database to AG
#Check autogrow for this new content database

New-SPManagedPath "qa" -WebApplication "https://intranet-pre.bourbon-online.com" -Explicit

get-spcontentdatabase | add-spshelladmin bourbon\svc.bippfront


Restore-SPSite https://intranet-pre.bourbon-online.com/qa -Path c:\root.bak -ContentDatabase BB2013_PreProd_Quality_Content -force




#On MRSSPS104

#check orphans
$db=get-spcontentdatabase bb2013_PreProd_publishing_content
$db.repair($false)

Backup-SPSite -Identity https://intranet-pre.bourbon-online.com/sites/refonteintranet -Path c:\refonte.bak
Remove-SPSite https://intranet-pre.bourbon-online.com/sites/refonteintranet

#gradual delete

#Resto
Restore-SPSite https://intranet-pre.bourbon-online.com -Path c:\refonte.bak -ContentDatabase BB2013_PreProd_Publishing_Content -force















