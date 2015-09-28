#
# Refonte_Prod.ps1
#
# Shrinks all large logs file
# Change backup logs maintenance plan to 15 mns on 01 and 02 nodes

# Check orphans
$db=get-spcontentdatabase bb2013_prod_portal_content
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
New-SPContentDatabase "BB2013_Prod_Dashboards_Content" -DatabaseServer "MRSSPSSPP\SPP" -WebApplication https://intranet.bourbon-online.com -MaxSiteCount 5000 -WarningSiteCount 2000
#Ad database to AG
#change autogrow and size to 500 MB
Move-SPSite https://intranet.bourbon-online.com/mydashboards -DestinationDatabase BB2013_Prod_Dashboards_Content
#IISRESET all server
Get-SPSite -ContentDatabase BB2013_Prod_Portal_Content
Get-SPSite -ContentDatabase BB2013_Prod_Dashboards_Content
get-spcontentdatabase | add-spshelladmin bourbon\svc.bipfront



New-SPContentDatabase "BB2013_Prod_Quality_Content" -DatabaseServer "MRSSPSSPP\SPP" -WebApplication https://intranet.bourbon-online.com -MaxSiteCount 5000 -WarningSiteCount 2000
#Add database to AG
#mdf : 81920 mb and 10240 autogrow
#ldf : 5120 mb and 10 percent
New-SPManagedPath "qa" -WebApplication "https://intranet.bourbon-online.com" -Explicit
get-spcontentdatabase | add-spshelladmin bourbon\svc.bipfront
Backup-SPSite -Identity https://intranet.bourbon-online.com -Path c:\racine.bak

#Add a log file on disque Spp data  quality content : on sait jamais
Restore-SPSite https://intranet.bourbon-online.com/qa -Path c:\racine.bak -ContentDatabase BB2013_Prod_Quality_Content -force


# Check site and execute powershells script to correct
# Change all /QA/QMS layouts via powershell script
# Change masterpage /qa to bourbon 2011 home
# change masterpage /qa/qms Bourbon-2011 qms
# Create result source QMS
# Create content source QA on /qa
# Redeploy last update for QMS
# Change master page css to point to /qa/style.... /for all sub sites . No exceptions

#####################################   REFONTE ###################################################################
#check orphans
# Change backup logs maintenance plan to 15 mns on 01 and 02 nodes
$db=get-spcontentdatabase bb2013_Prod_publishing_content
$db.repair($false)

Backup-SPSite -Identity https://intranet.bourbon-online.com/sites/refonteintranet -Path c:\refonte.bak

#copy .back of publishing and portal into the / of T disk to keep save to no be erased by tina
#Shrink Publishing log file to save space

Dismount-SPContentDatabase BB2013_Prod_Portal_Content

New-SPContentDatabase "BB2013_Prod_Publish_Content" -DatabaseServer "MRSSPSSPP\SPP" -WebApplication https://intranet.bourbon-online.com -MaxSiteCount 5000 -WarningSiteCount 2000
# Add database to AG
get-spcontentdatabase | add-spshelladmin bourbon\svc.bipfront
# Change size and autogrow and add new log file to s:data because there are no space

#IIS reset all servers via .PS1


Restore-SPSite https://intranet.bourbon-online.com -Path c:\refonte.bak -ContentDatabase BB2013_Prod_Publish_Content -force
 


#Review crawl and delete "refonte intranet" or "publishing"
#dismount publishing content database

#Full crawl "PORTAL" content source
#change PORTAL to "continuous crawl"

















