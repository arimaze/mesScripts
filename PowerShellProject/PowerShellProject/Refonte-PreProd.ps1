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

#Move my dashboards
New-SPContentDatabase "BB2013_PreProd_Dashboards_Content" -DatabaseServer "MRSSPSSPPP\SPPP" -WebApplication https://intranet-pre.bourbon-online.com -MaxSiteCount 5000 -WarningSiteCount 2000
#Ad database to AG
Move-SPSite https://intranet-pre.bourbon-online.com/mydashboards -DestinationDatabase BB2013_PreProd_Dashboards_Content
Get-SPSite -ContentDatabase BB2013_PreProd_Portal_Content
Get-SPSite -ContentDatabase BB2013_PreProd_Dashboards_Content
get-spcontentdatabase | add-spshelladmin bourbon\svc.bippfront



New-SPContentDatabase "BB2013_PreProd_Quality_Content" -DatabaseServer "MRSSPSSPPP\SPPP" -WebApplication https://intranet-pre.bourbon-online.com -MaxSiteCount 5000 -WarningSiteCount 2000
#Add database to AG
#mdf : 81920 mb and 10240 autogrow
#ldf : 5120 mb and 10 percent
New-SPManagedPath "qa" -WebApplication "https://intranet-pre.bourbon-online.com" -Explicit
get-spcontentdatabase | add-spshelladmin bourbon\svc.bippfront
Backup-SPSite -Identity https://intranet-pre.bourbon-online.com -Path \\mrssps102\t$\racine.bak
Restore-SPSite https://intranet-pre.bourbon-online.com/qa -Path \\mrssps102\t$\racine.bak -ContentDatabase BB2013_PreProd_Quality_Content -force


#Check site and execute powershells script to correct
#Change all /QA/QMS layouts via powershell script
#CHange masterpage /qa to bourbon 2011 home
#change masterpage /qa/qms Bourbon-2011 qms
#Create result source QMS
#Create content source QA on /qa
#Redeploy last update for QMS
#change master page css to point to /qa/style....


#On MRSSPS104
#check orphans
$db=get-spcontentdatabase bb2013_PreProd_publishing_content
$db.repair($false)

Backup-SPSite -Identity https://intranet-pre.bourbon-online.com/sites/refonteintranet -Path c:\refonte.bak

# Disable FULL Backup all databases maintenance plan on nodes 101 & 102
#copy .back of publishing and portal into the / of T disk to keep save to no be erased by tina
#Shrink Publishing log file to save space

Dismount-SPContentDatabase BB2013_PreProd_Portal_Content

New-SPContentDatabase "BB2013_PreProd_Publish_Content" -DatabaseServer "MRSSPSSPPP\SPPP" -WebApplication https://intranet-pre.bourbon-online.com -MaxSiteCount 5000 -WarningSiteCount 2000
# Add database to AG
# Change size and autogrow and add new log file to s:data because there are no space

#IIS reset all servers via .PS1


Restore-SPSite https://intranet-pre.bourbon-online.com -Path c:\refonte.bak -ContentDatabase BB2013_PreProd_Publish_Content -force
 


#Review crawl and delete "refonte intranet" or "publishing"
#Full crawl "PORTAL" content source
#change PORTAL to "continuous crawl"
#Enable FULL Backup all databases maintenance plan on nodes 101 & 102















